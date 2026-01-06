import { type ClientSchema, a, defineData } from '@aws-amplify/backend';
import { processTransaction } from '../functions/processTransaction/resource';
import { postConfirmation } from '../auth/post-confirmation/resource';
import { otpApi } from '../functions/otp-api/resource';
import { textInImage } from '../functions/text-in-image/resource';
import { faceComparison } from '../functions/face-comparison/resource';
import { livenessSessionId } from '../functions/liveness-session-id/resource';
import { livenessResult } from '../functions/liveness-result/resource';

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
    allow.guest()
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
    allow.guest()
  ]),
  
  // Account Action Button
  AccountButton: a.model({
    type: a.string().required(), // options: WALLET(default)|PITAKARD|PLC|SA|DD|LOANS
    name: a.string(),
    // relationships
    buttons: a.hasMany('Button', 'accountButtonId'), // one to many
  }).identifier(['type'])
  .authorization((allow) => [
    allow.guest()
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
    allow.guest()
  ]),

  // Dynamic Viewer
  DynamicRoute: a.model({ // can be the parent of the button, dynamic page or category
    title: a.string(),
    category: a.string(),
    buttons: a.hasMany('Button', 'dynamicRouteId'), // one to many
  }).authorization((allow) => [
    allow.guest()
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
    allow.guest()
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
    allow.guest()
  ]),

  //* ACCOUNT VERIFICATION **/
  VerifyAccount: a.model({
    accountNumber: a.string(),
    accountAlias: a.string(),
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
    allow.guest(),
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
    allow.guest()
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
    allow.guest()
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
    allow.guest()
  ])),

  OtpSmsEmail: a.model({
    target: a.string().required(), // email | phone
    otpHash: a.string(),
    channel: a.string(), // sms | email
    expiresAt: a.datetime(),
    verified: a.boolean(),
    attempts: a.integer(),
  }).identifier(['target'])
  .authorization((allow => [
    allow.guest(),
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
    data: a.json().required()
  })
  .returns(a.json())
  .authorization(allow => [allow.guest()])
  .handler(a.handler.function(processTransaction)),

  otpApi: a
  .query()
  .arguments({
    data: a.json().required()
  })
  .returns(a.json())
  .authorization(allow => [allow.guest()])
  .handler(a.handler.function(otpApi)),

  textInImage: a
  .query()
  .arguments({
    data: a.json().required()
  })
  .returns(a.json())
  .authorization(allow => [allow.guest()])
  .handler(a.handler.function(textInImage)),

  faceComparison: a
  .query()
  .arguments({
    data: a.json().required()
  })
  .returns(a.json())
  .authorization(allow => [allow.guest()])
  .handler(a.handler.function(faceComparison)),

  livenessSessionId: a
  .query()
  .returns(a.json())
  .authorization(allow => [allow.guest()])
  .handler(a.handler.function(livenessSessionId)),

  livenessResult: a
  .query()
  .arguments({
    data: a.json().required()
  })
  .returns(a.json())
  .authorization(allow => [allow.guest()])
  .handler(a.handler.function(livenessResult)),

  // end schema
}).authorization((allow) => [
  allow.resource(otpApi).to(['query', 'mutate', 'listen']),
  allow.resource(postConfirmation),
]);

export type Schema = ClientSchema<typeof schema>;

export const data = defineData({
  schema,
  authorizationModes: {
    defaultAuthorizationMode: 'identityPool',
    apiKeyAuthorizationMode: { expiresInDays: 30 },
  },
});