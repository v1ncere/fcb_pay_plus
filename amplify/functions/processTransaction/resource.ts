import { defineFunction } from "@aws-amplify/backend";

export const processTransaction = defineFunction({
    name: 'processTransaction',
    environment: {
        API_ENDPOINT: "https://xq3nfmzncfbtdkg5o4dhipw6jq.appsync-api.ap-southeast-2.amazonaws.com/graphql",
        API_REGION: "ap-southeast-2",
        API_SERVICE: "appsync"
    }
});