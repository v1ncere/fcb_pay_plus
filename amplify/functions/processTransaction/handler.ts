import { SignatureV4 } from "@smithy/signature-v4";
import { HttpRequest } from "@smithy/protocol-http";
import { defaultProvider } from "@aws-sdk/credential-provider-node";
import { env } from '$amplify/env/processTransaction';
import { Schema } from '../../data/resource';
import { Sha256 } from "@aws-crypto/sha256-js";
import fetch from "node-fetch";
import { v4 as uuidv4 } from 'uuid';

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
      case "transferToAccount":
        result = await transfer(inputData);
        break;
      case "transferPlcToWallet":
        result = await transfer(inputData);
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
  });

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

// * ====================== QUERIES ========================== * //

// GET ACCOUNT
async function getAccount(accountNumber: string) {
  const query = `
    query GetAccount($accountNumber: String!) {
      getAccount(accountNumber: $accountNumber) {
        accountNumber
        accountType
        creditLimit
        expiry
        status
        owner
      }
    }
  `;
  const res = await callAppSync<{
    data: { getAccount: any },
    errors?: any 
  }>(query, { accountNumber: accountNumber });
  
  if (res.errors) throw new Error(JSON.stringify(res.errors));
  const account = res?.data?.getAccount;
  if (!account) throw new Error('Account not found');
  return account;
}

// UPDATE ACCOUNT
async function updateAccount(accountNumber: string, accountType: string, creditLimit: number, expiry: Date, status: string) {
  const mutation = `
    mutation UpdateAccount($input: UpdateAccountInput!) {
      updateAccount(input: $input) {
        accountNumber
        accountType
        creditLimit
        expiry
        status
        owner
      }
    }
  `;
  const res = await callAppSync<{
    data: { updateAccount: any },
    errors?: any 
  }>(mutation, { input: { accountNumber, accountType, creditLimit, expiry: expiry.toISOString(), status } });
  
  if (res.errors) throw new Error(JSON.stringify(res.errors));
  const account = res?.data?.updateAccount;
  if (!account) throw new Error("Failed to update account");
  return account;
}

// GET MERCHANT
async function getMerchant(id: string) {
  const query = `
    query GetMerchant($id: ID!) {
      getMerchant(id: $id) {
        id
        name
        tag
        qrCode
      }
    }
  `;
  const res = await callAppSync<{
    data: { getMerchant: any },
    errors?: any,
  }>(query, { id: id });
  
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
        isTransferable
        owner
        accountId
      }
    }
  `;
  const res = await callAppSync<{
    data: { getTransferableUser: any },
    errors?: any
  }>(query, { id: id });

  if (res.errors) throw new Error(JSON.stringify(res.errors));
  const transferable = res?.data?.getTransferableUser;
  if (!transferable) throw new Error('Transferable user not found');
  return transferable;
}

// CREATE TRANSACTION
async function createTransaction(input: any) {
  const mutation = `
    mutation CreateTransaction($input: CreateTransactionInput!) {
      createTransaction(input: $input) {
        accountNumber
        transDate
        referenceId
        transCode
        transAmount
        amountType
        balanceActual
        balanceCleared
        ledgerStatus
        accountId
      }
    }
  `;
  const res = await callAppSync<{
    data: { createTransaction: any },
    errors?: any 
  }>(mutation, { input });
  
  if (res?.errors) throw new Error(JSON.stringify(res.errors));
  const transaction = res?.data?.createTransaction;
  if (!transaction) throw new Error("Failed to create transaction");
  return transaction;
}

// GET TRANSACTION BY ACCOUNT UPDATEDAT
async function getTransactionsByAccountUpdatedAt(accountNumber: string) {
  const query = `
    query LatestTxn($accountNumber: String!, $limit: Int!, $sortDirection: ModelSortDirection!) {
      transactionsByAccountUpdatedAt(
        accountNumber: $accountNumber
        limit: $limit
        sortDirection: $sortDirection
      ) {
        items {
          accountNumber
          transDate
          referenceId
          transCode
          transAmount
          amountType
          balanceActual
          balanceCleared
          ledgerStatus
          updatedAt
          createdAt
        }
      }
    }
  `;
  const res = await callAppSync<{
    data: { transactionsByAccountUpdatedAt: { items: any[] } },
    errors?: any,
  }>(query, { accountNumber: accountNumber, limit: 1, sortDirection: "DESC" });
  
  if (res.errors) throw new Error(JSON.stringify(res.errors));
  const transaction = res?.data?.transactionsByAccountUpdatedAt?.items?.[0];
  if (!transaction) throw new Error('Transaction not found');
  return transaction;
}

// CREATE TRANSACTION DETAILS
async function createTransactionDetail(input: any) {
  const mutation = `
    mutation CreateTransactionDetail($input: CreateTransactionDetailInput!) {
      createTransactionDetail(input: $input) {
        transDate
        referenceId
        transCode
        sourceAccount
        destinationAccount
        otherInformation
        deviceInfo
      }
    }
  `;
  const res = await callAppSync<{
    data: { createTransactionDetail: any },
    errors?: any,
  }>(mutation, { input });
  
  if (res?.errors) throw new Error(JSON.stringify(res.errors));
  const transDetails = res?.data?.createTransactionDetail;
  if (!transDetails) throw new Error("Failed to create transaction details");
  return transDetails;
}

// CREATE NOTIFICATION
async function createNotification(content: string, sender: string, owner: string) {
  const mutation = `
    mutation CreateNotification($input: CreateNotificationInput!) {
      createNotification(input: $input) {
        id
        content
        isRead
        sender
        owner
      }
    }
  `;
  const res = await callAppSync<{
    data: { createNotification: any },
    errors?: any 
  }>(mutation, { input: { content, isRead: false, sender, owner } });
  
  if (res?.errors) throw new Error(JSON.stringify(res.errors));
  const notif = res?.data?.createNotification;
  if (!notif) throw new Error("Failed to create notification");
  return notif;
}

// --- PAYMENT FUNCTION ---
async function payment(inputData: any): Promise<any> {
  const { DynamicWidgets, ExtraWidgets, TransactionType, Owner } = inputData;
  const sourceAccountId = DynamicWidgets?.SourceAccount;  // source account
  const merchantId = DynamicWidgets?.Merchant;            // merchant id
  const rawAmount = DynamicWidgets?.Amount;               // payment amount
  
  // SOURCE ACCOUNT AND AMOUNT MUST NOT BE EMPTY
  if (!sourceAccountId || !rawAmount) throw new Error("Missing required parameter.");
  // PARSE RAW AMOUNT INTO FLOAT
  const amount = parseFloat(typeof rawAmount === 'string' ? rawAmount.replace(/,/g, '') : rawAmount) || 0;
  // GET LATEST ACCOUNT SPECIFIC TRANSACTION
  const latestTransByAccount = await getTransactionsByAccountUpdatedAt(sourceAccountId);
  // CLEARED BALANCE
  const clearedBalance = latestTransByAccount.balanceCleared;
  // CHECK LEDGER STATUS IF ITS VL
  if (latestTransByAccount.ledgerStatus === 'ND') throw new Error('Transaction in progress. Please wait a moment.');
  // CHECK IF CLEARED BALACE IS SUFFICIENT
  if (clearedBalance < amount) throw new Error("Insufficient balance");
  // difference of the payment
  const diff = clearedBalance - amount;
  // GET MERCHANT
  const merchant = await getMerchant(merchantId);

  try {
    const awsDate = new Date().toISOString().split("T")[0];
    const referenceId = uuidv4();
    // CREATE TRANSACTION
    await createTransaction({
      accountNumber: sourceAccountId,
      transDate: awsDate,
      referenceId: referenceId,
      transCode: TransactionType,
      transAmount: amount,
      amountType: 'BOTH',
      balanceActual: diff,
      balanceCleared: diff,
      ledgerStatus: 'ND',
    });

    await createTransactionDetail({
      transDate: awsDate,
      referenceId: referenceId,
      transCode: TransactionType,
      sourceAccount: sourceAccountId,
      destinationAccount: merchantId,
      otherInformation: `Payment amounting of ₱${amount} to ${merchant.name} has been made.`,
      deviceInfo: '', // TODO: get the serial number of the phone
    });

    // CREATE NOTIFICATION
    await createNotification(
      `Payment amounting of ₱${amount} to ${merchant.name} has been made.`,
      latestTransByAccount.accountNumber,
      Owner,
    );

    return { // TODO: this is not final return
      accountNumber: sourceAccountId,
      transDate: awsDate,
      referenceId: referenceId,
      transCode: TransactionType,
    }
  } catch (error: any) {
    // TODO: Rollback here if possible
    throw error;
  }
}

// --- TRANSFER FUNCTION ---
async function transfer(inputData: any): Promise<any> {
  const { DynamicWidgets, ExtraWidgets, TransactionType, Owner } = inputData;
  const sourceAccountId = DynamicWidgets?.SourceAccount;
  const destinationAccountId = DynamicWidgets?.DestinationAccount;
  const rawAmount = DynamicWidgets?.Amount;
  // REQUIRED PARAMETER CHECKING
  if (!sourceAccountId || !destinationAccountId || !rawAmount) throw new Error("Missing required parameter.");
  // RAW AMOUNT PARSE INTO FLOAT
  const amount = parseFloat(typeof rawAmount === "string" ? rawAmount.replace(/,/g, "") : rawAmount) || 0;
  
  // SOURCE ACCOUNT
  const sourceAccount = await getAccount(sourceAccountId);
  // SOURCE ACCOUNT LATEST TRANSACTION
  const sourceAccountLatestTrx = await getTransactionsByAccountUpdatedAt(sourceAccountId);
  // SOURCE CLEARED BALANCE
  const sourceClearedBalance = sourceAccountLatestTrx.balanceCleared;
  // LEDGER STATUS CHECK IF VERIFIED
  if (sourceAccountLatestTrx.ledgerStatus === "ND") throw new Error("Transaction in progress. Please wait a moment.");

  // DESTINATION ACCOUNT
  const destinationAccountLatestTrx = await getTransactionsByAccountUpdatedAt(destinationAccountId);
  // LATEST DESTINATION ACCOUNT TRANSACTION
  const destinationClearedBalance = destinationAccountLatestTrx.balanceCleared;
  // LEDGER STATUS CHECK IF VERIFIED
  if (destinationAccountLatestTrx.ledgerStatus === "NC") throw new Error("Transaction in progress. Please wait a moment.");
  
  // EVENT PROCESS
  let sourceAccountDebit: number = 0;
  let destinationAccountCredit: number = 0;
  if (TransactionType === "transfer" || TransactionType === "transferToAccount") {
    if (sourceClearedBalance < amount) throw new Error("Insufficient account balance");
    sourceAccountDebit = sourceClearedBalance - amount;
    destinationAccountCredit = destinationClearedBalance + amount;
  } else if (TransactionType === "transferPlcToWallet") {
    sourceAccountDebit = sourceClearedBalance + amount;
    if (sourceAccountDebit > sourceAccount.creditLimit) throw new Error("Your credit limit has been reached. Please pay down your balance or adjust the transfer amount to continue.")
    destinationAccountCredit = destinationClearedBalance + amount;
  }

  try {
    const awsDate = new Date().toISOString().split("T")[0];
    const referenceId = uuidv4();
    // CREATE SOURCE TRANSACTION
    await createTransaction({
      accountNumber: sourceAccountId,
      transDate: awsDate,
      referenceId: referenceId,
      transCode: TransactionType,
      transAmount: amount,
      amountType: 'BOTH',
      balanceActual: sourceAccountDebit,
      balanceCleared: sourceAccountDebit,
      ledgerStatus: 'ND',
    });

    // CREATE DESTINATION TRANSACTION
    if (TransactionType === "transfer") {
      await createTransaction({
        accountNumber: destinationAccountId,
        transDate: awsDate,
        referenceId: referenceId,
        transCode: TransactionType,
        transAmount: amount,
        amountType: 'BOTH',
        balanceActual: destinationAccountCredit,
        balanceCleared: destinationAccountCredit,
        ledgerStatus: 'NC',
      });
    }

    await createTransactionDetail({
      transDate: awsDate,
      referenceId: referenceId,
      transCode: TransactionType,
      sourceAccount: sourceAccountId,
      destinationAccount: destinationAccountId,
      otherInformation: `Transferred to ${destinationAccountLatestTrx.accountNumber}`,
      deviceInfo: '', // TODO: get the serial number of the phone
    });

    // CREATE SOURCE NOTIFICATION
    await createNotification(
      `A transfer of ₱${amount} to ${destinationAccountLatestTrx.ownerName} was successfully processed. Ref: ${referenceId}`,
      sourceAccountLatestTrx.accountNumber,
      Owner,
    );

    // CREATE RECEIVER NOTIFICATION
    if (TransactionType === "transfer") {
      await createNotification(
        `You have received ₱${amount} from ${sourceAccountLatestTrx.accountNumber}. Ref ${referenceId}`,
        sourceAccountLatestTrx.accountNumber,
        destinationAccountLatestTrx.owner,
      );
    }

    return { // TODO: this is not final return
      accountNumber: sourceAccountId,
      transDate: awsDate,
      referenceId: referenceId,
      transCode: TransactionType,
    }
  } catch (error: any) {
    // Rollback balance
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
  const sourceAccountLatestTrx = await getTransactionsByAccountUpdatedAt(sourceAccountId);
  const sourceClearedBalance = sourceAccountLatestTrx.clearedBalance;
  if (sourceAccountLatestTrx.ledgerStatus === "ND") throw new Error("Transaction in progress. Please wait a moment.");

  // DESTINATION ACCOUNT
  const destinationAccountLatestTrx = await getTransactionsByAccountUpdatedAt(destinationAccountId);
  const destinationClearedBalance = destinationAccountLatestTrx.clearedBalance;
  if (destinationAccountLatestTrx.ledgerStatus === "NC") throw new Error("Transaction in progress. Please wait a moment.");
  
  // CHECK PROCESS
  if (destinationClearedBalance <= 0) throw new Error("There is no outstanding balance to pay."); // check no payment
  if (sourceClearedBalance < amount) throw new Error("Insufficient account balance"); // check source balance sufficient
  if (destinationClearedBalance < amount) throw new Error("Payment amount exceeds outstanding balance."); // check exceed payment

  try {
    const awsDate = new Date().toISOString().split("T")[0];
    const referenceId = uuidv4();
    // CREATE SOURCE TRANSACTION
    await createTransaction({
      accountNumber: sourceAccountId,
      transDate: awsDate,
      referenceId: referenceId,
      transCode: TransactionType,
      transAmount: amount,
      amountType: 'BOTH',
      balanceActual: sourceClearedBalance - amount,
      balanceCleared: sourceClearedBalance - amount,
      ledgerStatus: 'ND',
    });

    // CREATE DESTINATION TRANSACTION
    await createTransaction({
      accountNumber: destinationAccountId,
      transDate: awsDate,
      referenceId: referenceId,
      transCode: TransactionType,
      transAmount: amount,
      amountType: 'BOTH',
      balanceActual: destinationClearedBalance - amount,
      balanceCleared: destinationClearedBalance - amount,
      ledgerStatus: 'NC',
    });

    await createTransactionDetail({
      transDate: awsDate,
      referenceId: referenceId,
      transCode: TransactionType,
      sourceAccount: sourceAccountId,
      destinationAccount: destinationAccountId,
      otherInformation: `Payment to Pitakard Line of Credit ${destinationAccountLatestTrx.accountNumber} from ${sourceAccountLatestTrx.accountNumber}`,
      deviceInfo: '', // TODO: get the serial number of the phone
    });

    // CREATE NOTIFICATION
    await createNotification(
      `A payment of ₱${amount} to your Pitakard Line of Credit was successfully processed. Ref: ${referenceId}`,
      destinationAccountLatestTrx.accountNumber,
      Owner,
    );

    return { // TODO: this is not final return
      accountNumber: sourceAccountId,
      transDate: awsDate,
      referenceId: referenceId,
      transCode: TransactionType,
    }
  } catch (error: any) {
    // TODO:
    throw error;
  }
}