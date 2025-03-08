import { defineStorage } from '@aws-amplify/backend';

export const storage = defineStorage({
    name: 'FCBPayPlusDrive',
    access: (allow) => ({
        'validation-picture/{entity_id}/*': [
            allow.guest.to(['read']),
            allow.entity('identity').to(['read', 'write', 'delete'])
        ],
        'picture-submission/*': [
            allow.authenticated.to(['read', 'write']),
            allow.guest.to(['write'])
        ],
    })
});