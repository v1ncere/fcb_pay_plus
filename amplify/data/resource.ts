import { type ClientSchema, a, defineData } from '@aws-amplify/backend';
import { processTransaction } from '../functions/processTransaction/resource';
import { postConfirmation } from '../auth/post-confirmation/resource';

/*== STEP 1 ===============================================================
The section below creates a Todo database table with a "content" field. Try
adding a new "isDone" field as a boolean. The authorization rule below
specifies that any unauthenticated user can "create", "read", "update", 
and "delete" any "Todo" records.
=========================================================================*/
const schema = a.schema({
  // Account
  Account: a.model({
    accountNumber: a.string().required(),
    balance: a.float(),
    creditLimit: a.float(),
    expiry: a.datetime(),
    type: a.string(),
    ownerName: a.string(),
    owner: a.string().required(),
    ledgerStatus: a.string().required(), // [VL, NC, ND]
    isActive: a.boolean(), 
    // relationships
    transactions: a.hasMany('Transaction', 'accountId'), // one to many
    transferableUser: a.hasOne('TransferableUser', 'accountId')
  }).identifier(['accountNumber'])
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
    type: a.string().required(), // plc, psa, wlt, ppr
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
    accountButtonId: a.id(), // foreign key to link with Action Button
    accountButton: a.belongsTo('AccountButton', 'accountButtonId'), // relationship to Action Button
    dynamicRouteId: a.id(), // foreign key to link with DynamicWidget Viewer
    dynamicRoute: a.belongsTo('DynamicRoute', 'dynamicRouteId'), // relationship to DynamicWidget Viewer
    widgets: a.hasMany('DynamicWidget', 'buttonId') // one to many
  }).authorization((allow) => [
    allow.authenticated(),
    allow.owner(),
  ]),

  // Dynamic Viewer Widget
  DynamicRoute: a.model({
    title: a.string(),
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
  
  // Institution(deprecated) Merchant(latest)
  Merchant: a.model({
    name: a.string(),
    tag: a.string(),
    qrCode: a.string(),
    // relationships
    widget: a.hasMany('DynamicWidget', 'merchantWidgetId'),
    extraWidget: a.hasMany('DynamicWidget', 'merchantExtraId')
  }).authorization((allow) => [
    allow.authenticated(),
    allow.owner(),
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

  // Transaction History
  Transaction: a.model({
    accountNumber: a.string(),
    accountType: a.string(),
    details: a.string(),
    owner: a.string(),
    // relationships
    accountId: a.id(), // foreign key to link with Account
    account: a.belongsTo('Account', 'accountId'), // relationship to Account
    receipt: a.hasOne('Receipt', 'transactionId'),
  }).authorization((allow) => [
    allow.authenticated(),
    allow.owner()
  ]),

  // Receipt 
  Receipt: a.model({
    data: a.json(),
    owner: a.string(),
    // relationships
    transactionId: a.id(),
    transaction: a.belongsTo('Transaction', 'transactionId'),
  }).authorization((allow) => [
    allow.authenticated(),
    allow.owner(),
  ]),
 
  // SearchFilter
  SearchFilter: a.enum(['newest,oldest,plc,ppr,psa,wlt']),

  // API's
  processTransaction: a
    .query()
    .arguments({
      data: a.json().required(),
    })
    .returns(a.json())
    .authorization(allow => [allow.authenticated()])
    .handler(a.handler.function(processTransaction)),
})
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
