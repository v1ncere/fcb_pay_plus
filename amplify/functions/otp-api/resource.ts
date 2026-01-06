import { defineFunction, secret } from "@aws-amplify/backend";

export const otpApi = defineFunction({
  name: 'otpApi',
  environment: {
    SES_SOURCE_EMAIL: secret('SES_SOURCE_EMAIL'),
    APP_KEY: secret('APP_KEY'),
    APP_SECRET: secret('APP_SECRET'),
    SHORTCODE_1: secret('SHORTCODE_1'),
    SHORTCODE_2: secret('SHORTCODE_2'),
    M360_API: secret('M360_API'),
  },
});