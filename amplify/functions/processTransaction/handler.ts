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
        result = await transfer(inputData, transactionType);
        break;
      case "transferToAccount":
        result = await transfer(inputData, transactionType);
        break;
      case "transferPlcToWallet":
        result = await transfer(inputData, transactionType);
        break;
      case "paymentPlc":
        result = await paymentPlc(inputData);
        break;
      default:
        throw new Error("Unsupported transaction type");
    }

    return { isSuccess: true, data: result };
  } catch (error: any) {
    return { isSuccess: false, error: error.message || "Unknown error" };
  }
};

// ---- GRAPHQL CALLER ----
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

// GET ACCOUNT
async function getAccount(accountNumber: string) {
  const query = `
    query GetAccount($accountNumber: String!) {
      getAccount(accountNumber: $accountNumber) {
        accountNumber
        balance
        creditLimit
        type
        owner 
        ledgerStatus
      }
    }
  `;
  const res = await callAppSync<{ data: { getAccount: any }, errors?: any }>(query, { accountNumber: accountNumber });
  if (res.errors) throw new Error(JSON.stringify(res.errors));
  const account = res?.data?.getAccount;
  if (!account) throw new Error('Account not found');
  return account;
}

// GET ACCOUNT
async function getMerchant(id: string) {
  const query = `
    query GetMerchant($id: ID!) {
      getMerchant(id: $id) {
        id
        name
      }
    }
  `;
  const res = await callAppSync<{ data: { getMerchant: any }, errors?: any }>(query, { id: id });
  if (res.errors) throw new Error(JSON.stringify(res.errors));
  const merchant = res?.data?.getMerchant;
  if (!merchant) throw new Error('Merchant not found');
  return merchant;
}

// GET TRANSFERABLEUSER
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
  const res = await callAppSync<{ data: { getTransferableUser: any }, errors?: any }>(query, { id: id });
  if (res.errors) throw new Error(JSON.stringify(res.errors));
  const transferable = res?.data?.getTransferableUser;
  if (!transferable) throw new Error('Transferable user not found');
  return transferable;
}

// UPDATE ACCOUNT
async function updateAccount(accountNumber: string, balance: number, ledgerStatus: string) {
  const mutation = `
    mutation UpdateAccount($input: UpdateAccountInput!) {
      updateAccount(input: $input) {
        balance
      }
    }
  `;
  const res = await callAppSync<{ data: { updateAccount: any }, errors?: any }>(mutation, {
    input: { accountNumber, balance, ledgerStatus }
  });
  if (res.errors) throw new Error(JSON.stringify(res.errors));
  const account = res?.data?.updateAccount;
  if (!account) throw new Error("Failed to update account");
  return account.balance;
}

// CREATE TRANSACTION
async function createTransaction(input: any) {
  const mutation = `
    mutation CreateTransaction($input: CreateTransactionInput!) {
      createTransaction(input: $input) {
        id
      }
    }
  `;
  const res = await callAppSync<{ data: { createTransaction: any }, errors?: any }>(mutation, { input });
  if (res?.errors) throw new Error(JSON.stringify(res.errors));
  const trans = res?.data?.createTransaction;
  if (!trans) throw new Error("Failed to create transaction");
  return trans.id;
}

// CREATE NOTIFICATION
async function createNotification(content: string, sender: string, owner: string) {
  const mutation = `
    mutation CreateNotification($input: CreateNotificationInput!) {
      createNotification(input: $input) {
        id  
      }
    }
  `;
  const res = await callAppSync<{ data: { createNotification: any }, errors?: any }>(mutation, {
    input: { content, isRead: false, sender, owner }
  });
  if (res?.errors) throw new Error(JSON.stringify(res.errors));
  const notif = res?.data?.createNotification;
  if (!notif) throw new Error("Failed to create notification");
}

// CREATE RECEIPT
async function createReceipt(data: object, owner: string, transactionId: string) {
  const mutation = `
    mutation CreateReceipt($input: CreateReceiptInput!) {
      createReceipt(input: $input) {
        id
      }
    }
  `;
  const res = await callAppSync<{ data: { createReceipt: any }, errors?: any }>(mutation, {
    input: { data: JSON.stringify(data), owner, transactionId }
  });
  if (res?.errors) throw new Error(JSON.stringify(res.errors));
  const receipt = res?.data?.createReceipt;
  if (!receipt) throw new Error("Failed to create receipt");
  return receipt.id;
}

// GENERATE REFERENCE
function generateReceiptRef(): string {
  const timestamp = Date.now().toString(); // milliseconds since epoch
  const randomSuffix = Math.floor(Math.random() * 1000).toString().padStart(3, '0'); // 000–999
  return `FCBPay-${timestamp}${randomSuffix}`;
}

// --- PAYMENT FUNCTION ---
async function payment(inputData: any): Promise<any> {
  const { DynamicWidgets, ExtraWidgets, TransactionType, Owner } = inputData;
  const sourceAccountId = DynamicWidgets?.SourceAccount;
  const merchantId = DynamicWidgets?.Merchant;
  const rawAmount = DynamicWidgets?.Amount;

  if (!sourceAccountId || !rawAmount) throw new Error("Missing required parameter.");

  const amount = parseFloat(typeof rawAmount === 'string' ? rawAmount.replace(/,/g, '') : rawAmount) || 0;

  // GET SOURCE ACCOUNT
  const sourceAccount = await getAccount(sourceAccountId);
  const sourceBalance = sourceAccount.balance;
  if (sourceAccount.ledgerStatus === "ND") throw new Error("Transaction in progress. Please wait a moment.");

  if (sourceBalance < amount) throw new Error("Insufficient balance");

  // GET MERCHANT
  const merchant = await getMerchant(merchantId);
  
  // UPDATE ACCOUNT
  const updatedSourceAccountBalance = await updateAccount(sourceAccount.accountNumber, sourceBalance - amount, "ND");

  try {
    // CREATE TRANSACTION
    const transactionId = await createTransaction({
      accountNumber: sourceAccount.accountNumber, 
      accountType: sourceAccount.type,
      details: `Payment of ₱${amount} to ${merchant.name} from ${sourceAccount.accountNumber}`,
      owner: Owner,
      accountId: sourceAccount.accountNumber,
    });

    // CREATE NOTIFICATION
    await createNotification(
      `Payment amounting of ₱${amount} to ${merchant.name} has been made.`,
      sourceAccount.accountNumber,
      Owner,
    );

    // CREATE RECEIPT
    const receiptId = await createReceipt(
      {
        "Reference ID": generateReceiptRef(),
        "Mode": TransactionType,
        "From Account": sourceAccount.accountNumber,
        "Paid to Account": merchant.name,
        "Amount": amount,
        "Date": new Date().toISOString(),
      },
      Owner,
      transactionId
    );

    return {
      transactionId: transactionId,
      balance: updatedSourceAccountBalance,
      receiptId: receiptId
    }
  } catch (error: any) {
    // Rollback balance
    await updateAccount(sourceAccount.accountNumber, sourceBalance, sourceAccount.ledgerStatus).catch(e => {
      console.error("Rollback failed:", e);
      throw new Error("Critical error: transaction failed and rollback also failed.");
    });
    throw error;
  }
}

// --- TRANSFER FUNCTION ---
async function transfer(inputData: any, transferType: string): Promise<any> {
  const { DynamicWidgets, ExtraWidgets, TransactionType, Owner } = inputData;
  const sourceAccountId = DynamicWidgets?.SourceAccount;
  const destinationAccountId = DynamicWidgets?.DestinationAccount;
  const rawAmount = DynamicWidgets?.Amount;

  if (!sourceAccountId || !destinationAccountId || !rawAmount) throw new Error("Missing required parameter.");

  const amount = parseFloat(typeof rawAmount === "string" ? rawAmount.replace(/,/g, "") : rawAmount) || 0;

  // SOURCE ACCOUNT
  const sourceAccount = await getAccount(sourceAccountId);
  const sourceBalance = sourceAccount.balance;
  if (sourceAccount.ledgerStatus === "ND") throw new Error("Transaction in progress. Please wait a moment.");
  
  let account;
  if (transferType === "transfer") {
    // TRANSFERABLE USER
    const transferableUser = await getTransferableUser(destinationAccountId);
    if (transferableUser.isTransferable === false) throw new Error("Transfer could not be completed. The destination account may be invalid or restricted. Please verify the account details and try again.");
    account = transferableUser.accountId; // the account number of the transferable user
  } else {
    account = destinationAccountId;
  }

  // DESTINATION ACCOUNT
  const destinationAccount = await getAccount(account);
  const destinationBalance = destinationAccount.balance;
  if (destinationAccount.ledgerStatus === "NC") throw new Error("Transaction in progress. Please wait a moment.");
  
  // EVENT PROCESS
  let sourceResult: number = 0;
  let destinationResult: number = 0;
  if (transferType === "transfer" || transferType === "transferToAccount") {
    if (sourceBalance < amount) throw new Error("Insufficient account balance");
    sourceResult = sourceBalance - amount;
    destinationResult = destinationBalance + amount;
  } else if (transferType === "transferPlcToWallet") {
    sourceResult = sourceBalance + amount;
    if (sourceResult > sourceAccount.creditLimit) throw new Error("Your credit limit has been reached. Please pay down your balance or adjust the transfer amount to continue.")
    destinationResult = destinationBalance + amount;
  }
  
  // UPDATE ACCOUNTS
  const updatedSourceBalance = await updateAccount(sourceAccount.accountNumber, sourceResult, "ND");
  await updateAccount(destinationAccount.accountNumber, destinationResult, "NC");

  try {
    // CREATE TRANSACTION
    const transactionId = await createTransaction({
      accountNumber: sourceAccount.accountNumber, 
      accountType: sourceAccount.type,
      details: `Transferred to ${destinationAccount.$accountNumber}`,
      owner: Owner,
      accountId: sourceAccount.accountNumber,
    });

    // CREATE SOURCE NOTIFICATION
    await createNotification(
      `A transfer of ₱${amount} to ${destinationAccount.ownerName} was successfully processed. Ref: ${transactionId}`,
      sourceAccount.accountNumber,
      Owner,
    );

    // CREATE RECEIVER NOTIFICATION
    if (transferType === "transfer") {
      await createNotification(
        `You have received ₱${amount} from ${sourceAccount.ownerName}. Ref ${transactionId}`,
        sourceAccount.accountNumber,
        destinationAccount.owner,
      );
    }

    // CREATE RECEIPT
    const receiptId = await createReceipt(
      {
        "Reference ID": generateReceiptRef(),
        "Mode": "Transfer",
        "From Account": sourceAccount.accountNumber,
        "Transfer to Account": destinationAccount.accountNumber,
        "Amount": `₱${amount}`,
        "Date": new Date().toISOString(),
      },
      Owner,
      transactionId,
    );

    return {
      transactionId: transactionId,
      balance: updatedSourceBalance,
      receiptId: receiptId
    }
  } catch (error: any) {
    // Rollback balance
    await updateAccount(sourceAccount.accountNumber, sourceBalance, sourceAccount.ledgerStatus).catch(e => {
      console.error(`Rollback failed for sender ${sourceAccount.accountNumber}:`, e);
      throw new Error("Critical error: transaction failed and rollback also failed.");
    });
    await updateAccount(destinationAccount.accountNumber, destinationBalance, destinationAccount.ledgerStatus).catch(e => {
      console.error(`Rollback failed for receiver ${destinationAccount.accountNumber}:`, e);
      throw new Error("Critical error: transaction failed and rollback also failed.");
    });
    throw error;
  }
}

// --- PLC PAY NOW FUNCTION ---
async function paymentPlc(inputData: any): Promise<any> {
  const { DynamicWidgets, ExtraWidgets, TransactionType, Owner } = inputData;
  const sourceAccountId = DynamicWidgets?.SourceAccount;
  const destinationAccountId = DynamicWidgets?.DestinationAccount;
  const rawAmount = DynamicWidgets?.Amount;

  if (!sourceAccountId || !destinationAccountId || !rawAmount) throw new Error("Missing required parameter.");

  const amount = parseFloat(typeof rawAmount === "string" ? rawAmount.replace(/,/g, "") : rawAmount) || 0;

  // SOURCE ACCOUNT
  const sourceAccount = await getAccount(sourceAccountId);
  const sourceBalance = sourceAccount.balance;
  if (sourceAccount.ledgerStatus === "ND") throw new Error("Transaction in progress. Please wait a moment.");

  // DESTINATION ACCOUNT
  const destinationAccount = await getAccount(destinationAccountId);
  const destinationBalance = destinationAccount.balance;
  if (destinationAccount.ledgerStatus === "NC") throw new Error("Transaction in progress. Please wait a moment.");
  
  // CHECK PROCESS
  if (destinationBalance <= 0) throw new Error("There is no outstanding balance to pay."); // check no payment
  if (sourceBalance < amount) throw new Error("Insufficient account balance"); // check source balance sufficient
  if (destinationBalance < amount) throw new Error("Payment amount exceeds outstanding balance."); // check exceed payment
  
  // UPDATE ACCOUNTS
  await updateAccount(sourceAccount.accountNumber, sourceBalance - amount, "ND");
  const updatedDestinationBalance = await updateAccount(destinationAccount.accountNumber, destinationBalance - amount, "NC");

  try {
    // CREATE TRANSACTION
    const transactionId = await createTransaction({
      accountNumber: destinationAccount.accountNumber, 
      accountType: destinationAccount.type,
      details: `Payment to Pitakard Line of Credit ${destinationAccount.accountNumber} from ${sourceAccount.accountNumber}`,
      owner: Owner,
      accountId: destinationAccount.accountNumber,
    });

    // CREATE NOTIFICATION
    await createNotification(
      `A payment of ₱${amount} to your Pitakard Line of Credit was successfully processed. Ref: ${transactionId}`,
      destinationAccount.accountNumber,
      Owner,
    );

    // CREATE RECEIPT
    const receiptId = await createReceipt(
      {
        "Reference ID": generateReceiptRef(),
        "Mode": "Payment",
        "From Account": sourceAccount.accountNumber,
        "Paid to Account": destinationAccount.accountNumber,
        "Amount": `₱${amount}`,
        "Date": new Date().toISOString(),
      },
      Owner,
      transactionId,
    );

    return {
      transactionId: transactionId,
      balance: updatedDestinationBalance,
      receiptId: receiptId
    }
  } catch (error: any) {
    // Rollback balance
    await updateAccount(sourceAccount.accountNumber, sourceBalance, sourceAccount.ledgerStatus).catch(e => {
      console.error(`Rollback failed for sender ${sourceAccount.accountNumber}:`, e);
      throw new Error("Critical error: transaction failed and rollback also failed.");
    });
    await updateAccount(destinationAccount.accountNumber, destinationBalance, destinationAccount.ledgerStatus).catch(e => {
      console.error(`Rollback failed for receiver ${destinationAccount.accountNumber}:`, e);
      throw new Error("Critical error: transaction failed and rollback also failed.");
    });
    throw error;
  }
}