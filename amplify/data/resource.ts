import { type ClientSchema, a, defineData } from '@aws-amplify/backend';
import { processTransaction } from '../functions/processTransaction/resource';
import { postConfirmation } from '../auth/post-confirmation/resource';
import { otpHandler } from '../functions/otpHandler/resource';

/*== STEP 1 ===============================================================
The section below creates a Todo database table with a "content" field. Try
adding a new "isDone" field as a boolean. The authorization rule below
specifies that any unauthenticated user can "create", "read", "update", 
and "delete" any "Todo" records.
=========================================================================*/
const schema = a.schema({
  // Account
  Account: a.model({
    accountNumber: a.string().required(), // account number (identifier, primary key)
    accountType: a.string(),              // options: WALLET(default)|PITAKARD|PLC|SA|DD|LOANS
    creditLimit: a.float(),               // credit limit of the account type (WALLET, PLC)
    expiry: a.datetime(),                 // expiry of the (PLC)
    status: a.string(),                   // options: NA(new)(default)|AC(active)|LC(locked)|CL(closed)|BL(blocked)
    owner: a.string().required(),         // owner id of the account
    // relationships
    transactions: a.hasMany('Transaction', 'accountId'), // one to many
    transferableUser: a.hasOne('TransferableUser', 'accountId')
  }).identifier(['accountNumber']) // [accountNumber]
  .authorization((allow) => [
    allow.authenticated(),
    allow.ownerDefinedIn("owner") // experiment
  ]),

  // Fund Transfer Accounts
  TransferableUser: a.model({
    name: a.string().required(),
    isTransferable: a.boolean().required(),
    owner: a.string().required(),
    // relationships
    accountId: a.id(),
    account: a.belongsTo('Account', 'accountId')
  }).authorization((allow) => [
    allow.authenticated(),
    allow.owner()
  ]),
  
  // Account Action Button
  AccountButton: a.model({
    type: a.string().required(), // options: WALLET(default)|PITAKARD|PLC|SA|DD|LOANS
    name: a.string(),
    // relationships
    buttons: a.hasMany('Button', 'accountButtonId'), // one to many
  }).identifier(['type'])
  .authorization((allow) => [
    allow.authenticated(),
    allow.owner()
  ]),

  // Button
  Button: a.model({
    backgroundColor: a.string(),
    icon: a.string(),
    iconColor: a.string(),
    position: a.integer(),
    title: a.string(),
    titleColor: a.string(),
    type: a.string(),
    // relationship
    accountButtonId: a.id(), // foreign key to link with AccountButton
    accountButton: a.belongsTo('AccountButton', 'accountButtonId'), // relationship to Action Button
    dynamicRouteId: a.id(), // foreign key to link with DynamicWidget Viewer
    dynamicRoute: a.belongsTo('DynamicRoute', 'dynamicRouteId'), // relationship to DynamicWidget Viewer
    widgets: a.hasMany('DynamicWidget', 'buttonId'), // one to many
  }).authorization((allow) => [
    allow.authenticated(),
    allow.owner(),
  ]),

  // Dynamic Viewer
  DynamicRoute: a.model({ // can be the parent of the button, dynamic page or category
    title: a.string(),
    category: a.string(),
    buttons: a.hasMany('Button', 'dynamicRouteId'), // one to many
  }).authorization((allow) => [
    allow.authenticated(),
    allow.owner()
  ]),
  
  // Dynamic Widget 
  DynamicWidget: a.model({
    hasExtra: a.boolean(),
    content: a.string(),
    dataType: a.string(),
    node: a.string(),
    position: a.integer(),
    title: a.string(),
    widgetType: a.string(),
    // relationships
    buttonId: a.id(), // foreign key to link with Button
    button: a.belongsTo('Button', 'buttonId'),
    merchantWidgetId: a.id(), // foreign key to link with Merchant
    merchantWidget: a.belongsTo('Merchant', 'merchantWidgetId'),
    merchantExtraId: a.id(), // foreign key to link with Merchant
    merchantExtraWidget: a.belongsTo('Merchant', 'merchantExtraId'),
  }).authorization((allow) => [
    allow.authenticated(),
    allow.owner()
  ]),
  
  // Merchant(latest)
  Merchant: a.model({
    name: a.string(),
    tag: a.string(),
    qrCode: a.string(),
    // relationships
    widget: a.hasMany('DynamicWidget', 'merchantWidgetId'),
    extraWidget: a.hasMany('DynamicWidget', 'merchantExtraId'),
  }).authorization((allow) => [
    allow.authenticated(),
    allow.owner(),
  ]),

  //* ACCOUNT VERIFICATION **/
  VerifyAccount: a.model({
    accountNumber: a.string(),
    accountAlias: a.string(),
  }).authorization((allow) => [
    allow.guest(),
  ]),

  //* OTP REQUEST **/
  OtpRequest: a.model({
    email: a.string(),
    mobileNumber: a.string(),
  }).authorization((allow) => [
    allow.guest(),
  ]),

  //* SIGNUP **/
  SignupRequest: a.model({
    accountNumber: a.string(),
    accountAlias: a.string(),
    email: a.string(),
    mobileNumber: a.string(),
    details: a.json(),
    profileRef: a.string(),
    validIdRef: a.string(),
  }).authorization((allow) => [
    allow.guest(),
  ]),

  // Notification
  Notification: a.model({
    content: a.string(), 
    isRead: a.boolean(),
    sender: a.string(),
    owner: a.string(),
  }).authorization((allow) => [
    allow.authenticated(),
    allow.owner()
  ]),

  TransactionTransactionDetail: a.model({
    accountNumber: a.string().required(),
    transDate: a.date().required(),
    referenceId: a.string().required(),
    transCode: a.string().required(),
    // relationships
    transaction: a.belongsTo('Transaction', ['transDate', 'referenceId', 'transCode', 'accountNumber']),
    transactionDetail: a.belongsTo('TransactionDetail', ['transDate', 'referenceId', 'transCode']),
  }).authorization((allow) => [
    allow.authenticated(),
    allow.owner(),
  ]),

  // Transaction History
  Transaction: a.model({
    accountNumber: a.string().required(),
    transDate: a.date().required(),
    referenceId: a.string().required(),
    transCode: a.string().required(),
    transAmount: a.float(),
    amountType: a.string(),
    balanceActual: a.float(),
    balanceCleared: a.float(),
    ledgerStatus: a.string(),
    // relationships
    accountId: a.id(),
    account: a.belongsTo('Account', 'accountId'), // relationship to Account
    transactionDetails: a.hasMany('TransactionTransactionDetail', ['transDate', 'referenceId', 'transCode', 'accountNumber']), // has many transactionDetail
    // only for the TS linter to accept the updatedAt
    updatedAt: a.datetime(),
  }).identifier(['transDate', 'referenceId', 'transCode', 'accountNumber'])
  .secondaryIndexes((index) => [
    index('accountNumber')
    .sortKeys(['updatedAt'])
    .queryField('transactionsByAccountUpdatedAt'),
  ])
  .authorization((allow) => [
    allow.authenticated(),
    allow.owner(),
  ]),

  TransactionDetail: a.model({
    transDate: a.date().required(),
    referenceId: a.string().required(),
    transCode: a.string().required(),
    sourceAccount: a.string(),
    destinationAccount: a.string(),
    otherInformation: a.string(),
    deviceInfo: a.string(),
    // relationships
    transactions: a.hasMany('TransactionTransactionDetail', ['transDate', 'referenceId', 'transCode']), // has many transaction
  }).identifier(['transDate', 'referenceId', 'transCode']) //
  .authorization((allow => [
    allow.authenticated(),
    allow.owner(),
  ])),

  OtpSmsEmail: a.model({
    target: a.string().required(), // email | phone
    otp: a.string(),
    channel: a.string(), // sms | email
    expiresAt: a.string(),
    verified: a.boolean(),
  }).authorization((allow => [
    allow.guest()
  ])),

  DeviceId: a.model({
    deviceId: a.string().required(),
    owner: a.string().required(),
    deviceModel: a.string().required(),
  }).authorization((allow => [
    allow.guest(),
  ])),

  // AccountType
  AccountType: a.enum([
    'wallet',   //
    'pitakard', //
    'plc',      //
    'sa',       //
    'dd',       //
    'loans',    //
  ]),

  // AccountStatus
  AccountStatus: a.enum([
    'NA', // new account
    'AC', // active
    'BL', // blocked
    'LC', // locked
    'CL', // closed
  ]),

  // LedgerStatus
  LedgerStatus: a.enum([
    'VL', // verified ledger
    'ND', // non-verified debit
    'NC', // non-verified credit
  ]),

  // API's for process the transaction
  processTransaction: a
  .query()
  .arguments({
    data: a.json().required(),
  })
  .returns(a.json())
  .authorization(allow => [allow.authenticated()])
  .handler(a.handler.function(processTransaction)),

  otpHandler: a
  .query()
  .arguments({
    data: a.json().required(),
  })
  .returns(a.json())
  .authorization(allow => [allow.guest()])
  .handler(a.handler.function(otpHandler)),

}) // end
.authorization((allow) => [allow.resource(postConfirmation)]);

export type Schema = ClientSchema<typeof schema>;

export const data = defineData({
  schema,
  authorizationModes: {
    defaultAuthorizationMode: 'userPool',
    apiKeyAuthorizationMode: {
      expiresInDays: 30,
    },
  },
});

/*== STEP 2 ===============================================================
Go to your frontend source code. From your client-side code, generate a
Data client to make CRUDL requests to your table. (THIS SNIPPET WILL ONLY
WORK IN THE FRONTEND CODE FILE.)

Using JavaScript or Next.js React Server Components, Middleware, Server 
Actions or Pages Router? Review how to generate Data clients for those use
cases: https://docs.amplify.aws/gen2/build-a-backend/data/connect-to-API/
=========================================================================*/

/*
"use client"
import { generateClient } from "aws-amplify/data";
import type { Schema } from "@/amplify/data/resource";

const client = generateClient<Schema>() // use this Data client for CRUDL requests
*/

/*== STEP 3 ===============================================================
Fetch records from the database and use them in your frontend component.
(THIS SNIPPET WILL ONLY WORK IN THE FRONTEND CODE FILE.)
=========================================================================*/

/* For example, in a React component, you can use this snippet in your
  function's RETURN statement */
// const { data: todos } = await client.models.Todo.list()

// return <ul>{todos.map(todo => <li key={todo.id}>{todo.content}</li>)}</ul>
