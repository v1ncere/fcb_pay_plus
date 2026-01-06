import { SESClient, SendEmailCommand } from "@aws-sdk/client-ses";
import { getAmplifyDataClientConfig } from "@aws-amplify/backend/function/runtime";
import { Amplify } from "aws-amplify";
import { generateClient } from "aws-amplify/data";
import { env } from '$amplify/env/otpHandler';
import { randomInt, createHash } from "crypto";
import { type Schema } from '../../data/resource';

class UserError extends Error {}

const { resourceConfig, libraryOptions } = await getAmplifyDataClientConfig(env);
Amplify.configure(resourceConfig, libraryOptions);
const client = generateClient<Schema>();

const ses = new SESClient({});

const OTP_EXPIRY_SECONDS = 300; // 5 minutes
const RATE_LIMIT_MAX = 3;
const RATE_LIMIT_WINDOW_MS = 5 * 60 * 1000;

/* ---------------------------------------------------------
   MAIN HANDLER
--------------------------------------------------------- */
export const handler: Schema['otpApi']['functionHandler'] = async (event) => {
  try {
    const input = event.arguments.data;
    if (!input) throw new UserError('Missing parameters');
    const type = input['FunctionType'];

    switch(type) {
      case "send-otp":
        return await sendOtp(input);
      case "verify-otp":
        return await verifyOtp(input);
      case "resend-otp":
        return await resendOtp(input);
      default:
        throw new UserError("Unknown parameter");
    }
  } catch (err: any) {
    // business errors
    if (err instanceof UserError) {
      return { isSuccess: false, error: err.message };
    }

    // system errors
    console.error("SYSTEM OTP ERROR:", err);
    return { isSuccess: false, error: "System error. Please try again." };
  }
}

/* ---------------------------------------------------------
   RATE LIMIT
--------------------------------------------------------- */
async function checkRateLimit(target: string) {
  const now = Date.now();

  const records = await client.models.OtpSmsEmail.list({
    filter: { target: { eq: target } }
  });

  const count = records.data.filter(r => 
    r.createdAt && now - new Date(r.createdAt).getTime() < RATE_LIMIT_WINDOW_MS
  ).length;

  if (count >= RATE_LIMIT_MAX) {
    throw new UserError("Too many OTP requests. Try again later.");
  }
}

/* ---------------------------------------------------------
   📱  SEND OTP
--------------------------------------------------------- */
async function sendOtp(input: any) {
  const { Target: target, Channel: channel } = input;
  if (!target || !channel) throw new UserError("Missing parameters");

  await checkRateLimit(target);
  await deleteExpiredOtp(target);

  const otp = randomInt(100000, 999999).toString();
  const otpHash = createHash("sha256").update(otp).digest("hex");
  const expiresAt = new Date(Date.now() + OTP_EXPIRY_SECONDS * 1000).toISOString();

  await client.models.OtpSmsEmail.create({
    target,
    otpHash,
    channel,
    expiresAt,
    verified: false
  });

  if (channel === "sms") await sendSmsOtp(target, otp);
  if (channel === "email") await sendEmailOtp(target, otp);

  return { isSuccess: true, data: { message: "OTP sent successfully" } };
}

/* ---------------------------------------------------------
   🔄  RESEND OTP
--------------------------------------------------------- */
async function resendOtp(input: any) {
  const { Target: target, Channel: channel } = input;
  if (!target || !channel) throw new UserError("Missing parameters");

  await checkRateLimit(target);

  const record = await client.models.OtpSmsEmail.get({ target });

  // expired or no existing → treat as new OTP
  if (!record.data || Date.now() > new Date(record.data.expiresAt!).getTime()) {
    return await sendOtp(input);
  }

  const otp = randomInt(100000, 999999).toString();
  const otpHash = createHash("sha256").update(otp).digest("hex");
  const expiresAt = new Date(Date.now() + OTP_EXPIRY_SECONDS * 1000).toISOString();

  await client.models.OtpSmsEmail.update({
    target,
    otpHash,
    expiresAt
  });

  if (channel === "sms") await sendSmsOtp(target, otp);
  if (channel === "email") await sendEmailOtp(target, otp);

  return { isSuccess: true, data: { message: "OTP resent successfully" } };
}

/* ---------------------------------------------------------
   📱  VERIFY OTP
--------------------------------------------------------- */
async function verifyOtp(input: any) {
  const { Target: target, Otp: otp } = input;
  if (!target || !otp) throw new UserError("Missing parameters");

  const record = await client.models.OtpSmsEmail.get({ target });
  if (!record.data) throw new UserError("OTP not found");

  const attempts = record.data.attempts ?? 0;

  if (attempts >= 3) {
    await client.models.OtpSmsEmail.delete({ target });
    throw new UserError("Too many incorrect attempts. Please request a new OTP.");
  }

  if (Date.now() > new Date(record.data.expiresAt!).getTime()) {
    throw new UserError("OTP expired");
  }

  const otpHash = createHash("sha256").update(otp).digest("hex");
  if (otpHash !== record.data.otpHash) {
    await client.models.OtpSmsEmail.update({
      target,
      attempts: attempts + 1
    });

    throw new UserError("Invalid OTP");
  }

  await client.models.OtpSmsEmail.delete({ target });

  return { isSuccess: true, data: { message: "OTP verified successfully" } };
}

/* ---------------------------------------------------------
   📱  DELETE EXPIRED OTP
--------------------------------------------------------- */
async function deleteExpiredOtp(target: string) {
  const record = await client.models.OtpSmsEmail.get({ target });
  if (!record.data) return;

  if (Date.now() > new Date(record.data.expiresAt!).getTime()) {
    await client.models.OtpSmsEmail.delete({ target });
  }
}

/* ---------------------------------------------------------
   📱  M360 PH SMS SENDER
--------------------------------------------------------- */
async function sendSmsOtp(phone: string, otp: string) {
  const payload = {
    "app_key": env.APP_KEY,
    "app_secret": env.APP_SECRET,
    "msisdn" : phone,
    "content" : `FCBPay+ mobile app. Your verification code is ${otp}. It expires in 5 minutes.`,
    "shortcode_mask" : env.SHORTCODE_1,
    "is_intl" : false
  }

  const res = await fetch(env.M360_API, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(payload),
  });

  const json = await res.json();
  if (json.code !== 201) {
    throw new UserError("Failed to send SMS OTP");
  }
}

/* ---------------------------------------------------------
   📧  SES EMAIL SENDER
--------------------------------------------------------- */
async function sendEmailOtp(email: string, otp: string) {
  await ses.send(
    new SendEmailCommand({
      Destination: { ToAddresses: [email] },
      Message: {
        Subject: { Data: "Your Verification Code" },
        Body: { Text: { Data: `Your verification code is ${otp}.` } }
      },
      Source: env.SES_SOURCE_EMAIL, // Must be verified in SES
    })
  );
}