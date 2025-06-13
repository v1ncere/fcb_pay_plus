import { SignatureV4 } from "@smithy/signature-v4";
import { HttpRequest } from "@smithy/protocol-http";
import { defaultProvider } from "@aws-sdk/credential-provider-node";
import { env } from '$amplify/env/processTransaction';
import { Schema } from '../../data/resource';
import { Sha256 } from "@aws-crypto/sha256-js";
import fetch from "node-fetch";

export const handler: Schema['processTransaction']['functionHandler'] = async (event) => {
  try {
    const inputData = event.arguments.data;
    if (!inputData) throw new Error('Missing required parameters');
    const transactionType = inputData["TransactionType"];

    let result;
    switch (transactionType) {
      case "payment":
        result = await payment(inputData);
        break;
      case "transfer":
        result = await transfer(inputData);
        break;
      default:
        throw new Error("Unsupported transaction type");
    }

    return { isSuccess: true, data: result };
  } catch (error: any) {
    return { isSuccess: false, error: error.message || "Unknown error" };
  }
};

// ---- GraphQL Caller ----
async function callAppSync<T>(query: string, variables: any): Promise<T> {
  const endpoint = new URL(env.API_ENDPOINT);
  const body = JSON.stringify({ query, variables });

  const request = new HttpRequest({
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      host: endpoint.host,
    },
    hostname: endpoint.hostname,
    body: body,
    path: endpoint.pathname
  });

  const signer = new SignatureV4({
    credentials: defaultProvider(),
    region: env.API_REGION,
    service: env.API_SERVICE,
    sha256: Sha256,
  })

  const signedRequest = await signer.sign(request);
  const result = await fetch(endpoint, {
    method: signedRequest.method,
    headers: signedRequest.headers,
    body: typeof signedRequest.body === 'string'
    ? signedRequest.body
    : Buffer.from(signedRequest.body ?? '').toString(),
  });

  const json = await result.json();
  return json as T;
}

// Get User Account
async function getAccount(accountNumber: string) {
  const query = `
    query GetAccount($accountNumber: String!) {
      getAccount(accountNumber: $accountNumber) {
        accountNumber
        balance
        type
        owner 
        ledgerStatus
      }
    }
  `;
  const result = await callAppSync<{ data: { getAccount: any }, errors?: any }>(query, { accountNumber: accountNumber });
  
  if (result.errors) throw new Error(JSON.stringify(result.errors));
  const account = result?.data?.getAccount;
  if (!account) throw new Error('User account not found');
  
  return account;
}

// Get Transferable User
async function getTransferableUser(id: string) {
  const query = `
    query GetTransferableUser($id: ID!) {
      getTransferableUser(id: $id) {
        id
        name
        owner
        accountId
      }
    }
  `;
  const result = await callAppSync<{ data: { getTransferableUser: any }, errors?: any }>(query, { id: id });
  
  if (result.errors) throw new Error(JSON.stringify(result.errors));
  const transferableUser = result?.data?.getTransferableUser;
  if (!transferableUser) throw new Error('Transferable user not found');
  
  return transferableUser;
}

// Update Account
async function updateAccount(accountNumber: string, balance: number, ledgerStatus: string) {
  const mutation = `
    mutation UpdateAccount($input: UpdateAccountInput!) {
      updateAccount(input: $input) {
        balance
      }
    }
  `;
  const result = await callAppSync<{ data: { updateAccount: any }, errors?: any }>(mutation, {
    input: { accountNumber, balance, ledgerStatus }
  });

  if (result.errors) throw new Error(JSON.stringify(result.errors));
  if (!result?.data?.updateAccount) throw new Error("Failed to update account");

  return result?.data?.updateAccount?.balance;
}

// Create Transaction
async function createTransaction(input: any) {
  const mutation = `
    mutation CreateTransaction($input: CreateTransactionInput!) {
      createTransaction(input: $input) {
        id
      }
    }
  `;
  const result = await callAppSync<{ data: { createTransaction: any }, errors?: any }>(mutation, {
    input
  });
  
  if (result?.errors) throw new Error(JSON.stringify(result.errors));
  if (!result?.data?.createTransaction) throw new Error("Failed to create transaction");

  return result?.data?.createTransaction?.id;
}

// Create Notification
async function createNotification(content: string, sender: string, owner: string) {
  const mutation = `
    mutation CreateNotification($input: CreateNotificationInput!) {
      createNotification(input: $input) {
        id  
      }
    }
  `;
  const result = await callAppSync<{ data: { createNotification: any }, errors?: any }>(mutation, {
    input: { content, isRead: false, sender, owner }
  });

  if (result?.errors) throw new Error(JSON.stringify(result.errors));
}

// Create Receipt
async function createReceipt(data: object, owner: string, transactionId: string) {
  const mutation = `
    mutation CreateReceipt($input: CreateReceiptInput!) {
      createReceipt(input: $input) {
        id
      }
    }
  `;
  const result = await callAppSync<{ data: { createReceipt: any }, errors?: any }>(mutation, {
    input: { data: JSON.stringify(data), owner, transactionId }
  });

  if (result?.errors) throw new Error(JSON.stringify(result.errors));

  return result?.data?.createReceipt?.id;
}

function generateReceiptRef(): string {
  const timestamp = Date.now().toString(); // milliseconds since epoch
  const randomSuffix = Math.floor(Math.random() * 1000).toString().padStart(3, '0'); // 000–999
  return `FCBPay-${timestamp}${randomSuffix}`;
}

// --- Main Payment Function ---
async function payment(inputData: any): Promise<any> {
  const { DynamicWidgets, ExtraWidgets, TransactionType, Owner } = inputData;
  const account = DynamicWidgets?.Accounts;
  const amount = parseFloat(DynamicWidgets?.Amount) || 0;
  const institutions = DynamicWidgets?.Institutions;

  if (!account || !amount) throw new Error("Missing account or amount");

  // get the user
  const userAccount = await getAccount(account);
  const originalBalance = userAccount.balance;

  if (userAccount.ledgerStatus === "ND") throw new Error("Transaction in progress. Please wait a moment.");
  if (originalBalance < amount) throw new Error("Insufficient balance");
  
  // update the user
  const updatedBalance = await updateAccount(userAccount.accountNumber, originalBalance - amount, "ND");

  try {
    // create user transaction
    const transactionId = await createTransaction({
      accountNumber: userAccount.accountNumber, 
      accountType: userAccount.type,
      details: TransactionType,
      owner: Owner,
      accountId: userAccount.accountNumber,
    });

    // create user notification
    await createNotification(
      `Payment amounting of ₱${amount} to ${institutions} has been made.`,
      userAccount.accountNumber,
      Owner,
    );

    // create user receipt
    const receiptId = await createReceipt(
      {
        "Reference ID": generateReceiptRef(),
        "Mode": TransactionType,
        "From Account": userAccount.accountNumber,
        "Paid to Account": institutions,
        "Amount": amount,
        "Date": new Date().toISOString(),
      },
      Owner,
      transactionId
    );

    return {
      transactionId: transactionId,
      balance: updatedBalance,
      receiptId: receiptId
    }
  } catch (error: any) {
    // Rollback balance
    await updateAccount(userAccount.accountNumber, originalBalance, "VL").catch(e => {
      console.error("Rollback failed:", e);
      throw new Error("Critical error: transaction failed and rollback also failed.");
    });
    throw error;
  }
}

// --- Main Transfer Function ---
async function transfer(inputData: any): Promise<any> {
  const { DynamicWidgets, ExtraWidgets, TransactionType, Owner } = inputData;
  const account = DynamicWidgets?.Accounts;
  const transferableUserId = DynamicWidgets?.TransferableUser;
  const rawAmount = DynamicWidgets?.Amount;

  if (!account || !rawAmount || !transferableUserId) throw new Error("Missing required parameter.");

  const amount = parseFloat(typeof rawAmount === 'string' ? rawAmount.replace(/,/g, '') : rawAmount) || 0;

  // GET SENDER ACCOUNT
  const senderAccount = await getAccount(account);
  const senderBalance = senderAccount.balance;

  if (senderAccount.ledgerStatus === "ND") throw new Error("Transaction in progress. Please wait a moment.");
  if (senderBalance < amount) throw new Error("Insufficient account balance");

  // get the transferable user
  const transferableUser = await getTransferableUser(transferableUserId);
  const receiverAccount = await getAccount(transferableUser.accountId);
  const receiverBalance = receiverAccount.balance;

  if (receiverAccount.ledgerStatus === "ND") throw new Error("Transaction in progress. Please wait a moment.");
  
  // update the user
  const updatedSenderBalance = await updateAccount(senderAccount.accountNumber, senderBalance - amount, 'ND');
  await updateAccount(transferableUser.accountId, receiverBalance + amount, 'ND');

  try {
    // create sender transaction
    const transactionId = await createTransaction({
      accountNumber: senderAccount.accountNumber, 
      accountType: senderAccount.type,
      details: TransactionType,
      owner: Owner,
      accountId: senderAccount.accountNumber,
    });

    // create sender notification
    await createNotification(
      `A transfer of ₱${amount} to ${receiverAccount.ownerName} was successfully processed. Ref: ${transactionId}`,
      senderAccount.accountNumber,
      Owner,
    );

    // create receiver notification
    await createNotification(
      `You have received ₱${amount} from ${senderAccount.ownerName}. Ref ${transactionId}`,
      senderAccount.accountNumber,
      receiverAccount.owner,
    );

    // create user receipt
    const receiptId = await createReceipt(
      {
        "Reference ID": generateReceiptRef(),
        "Mode": TransactionType,
        "From Account": senderAccount.accountNumber,
        "Transfer to Account": receiverAccount.accountNumber,
        "Amount": `₱${amount}`,
        "Date": new Date().toISOString(),
      },
      Owner,
      transactionId
    );

    return {
      transactionId: transactionId,
      balance: updatedSenderBalance,
      receiptId: receiptId
    }
  } catch (error: any) {
    // Rollback balance
    await updateAccount(senderAccount.accountNumber, senderBalance, senderAccount.ledgerStatus).catch(e => {
      console.error(`Rollback failed for sender ${senderAccount.accountNumber}:`, e);
      throw new Error("Critical error: transaction failed and rollback also failed.");
    });
    await updateAccount(receiverAccount.accountNumber, receiverBalance, receiverAccount.ledgerStatus).catch(e => {
      console.error(`Rollback failed for receiver ${receiverAccount.accountNumber}:`, e);
      throw new Error("Critical error: transaction failed and rollback also failed.");
    });
    throw error;
  }
}