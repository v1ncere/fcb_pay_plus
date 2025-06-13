import type { PostConfirmationTriggerHandler } from "aws-lambda";
import { type Schema } from "../../data/resource";
import { Amplify } from "aws-amplify";
import { generateClient } from "aws-amplify/data";
import { getAmplifyDataClientConfig } from '@aws-amplify/backend/function/runtime';
import { env } from "$amplify/env/post-confirmation";

const { resourceConfig, libraryOptions } = await getAmplifyDataClientConfig(env);

Amplify.configure(resourceConfig, libraryOptions);

const client = generateClient<Schema>();

export const handler: PostConfirmationTriggerHandler = async (event) => {
    await client.models.Account.create({
        accountNumber: event.request.userAttributes.sub,
        balance: 0,
        creditLimit: 0,
        expiry: new Date().toISOString(),
        type: 'wlt',
        ownerName: `${event.request.userAttributes['given_name']} ${event.request.userAttributes['family_name']}`,
        owner: event.request.userAttributes.sub,
        ledgerStatus: 'ND',
        isActive: false,
    });
    return event;
};