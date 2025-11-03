import { defineFunction } from "@aws-amplify/backend";

export const otpHandler = defineFunction({
  name: 'otpHandler',
  entry: './handler.ts',
  environment: {
    TABLE_NAME: "OtpSmsEmail",
  }
});