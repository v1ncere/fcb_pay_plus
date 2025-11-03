import { DynamoDBClient, PutItemCommand, GetItemCommand, DeleteItemCommand } from "@aws-sdk/client-dynamodb";
import { SNSClient, PublishCommand } from "@aws-sdk/client-sns";
import { SESClient, SendEmailCommand } from "@aws-sdk/client-ses";
import { randomInt, createHash } from "crypto";
import { Schema } from '../../data/resource';

const ddb = new DynamoDBClient({});
const sns = new SNSClient({});
const ses = new SESClient({});

const OTP_EXPIRY_SECONDS = 300; // 5 minutes

export const handler: Schema['otpHandler']['functionHandler'] = async (event) => {
  try {
    const inputData = event.arguments.data;
    if (!inputData) throw new Error('Missing required parameters');
    const funcType = inputData['FunctionType'];

    if (funcType == "send-otp") {
      return await sendOtp(inputData);
    } else if (funcType == "verify-otp") {
      return await verifyOtp(inputData);
    } else {
      return { isSuccess: false, error: "Unknown parameter" };
    }
  } catch (error: any) {
    return { isSuccess: false, error: error.message || 'Unknown error' };
  }
}

async function sendOtp(inputData: any) {
  const id = inputData['Id']; // email | phone
  const type = inputData['Type']; // email | sms

  if (!id || !type) throw new Error('Missing required parameters');
  
  const otp = randomInt(100000, 999999).toString();
  const hashedOtp = createHash("sha256").update(otp).digest("hex");
  const expiresAt = Math.floor(Date.now() / 1000) + OTP_EXPIRY_SECONDS;

  // Store in DynamoDB
  await ddb.send(new PutItemCommand({
    TableName: process.env.TABLE_NAME!,
    Item: {
      id: { S: id },
      otp: { S: hashedOtp },
      type: { S: type },
      expiresAt: { N: expiresAt.toString() },
      verified: { BOOL: false },
    },
  }));

  // Send OTP
  if (type === "sms") {
    await sendSmsOtp(id, otp);
  } else if (type === "email") {
    await sendEmailOtp(id, otp);
  }

  return { isSuccess: true, message: "OTP sent successfully" };
}

async function verifyOtp(inputData: any) {
  const id = inputData['Id'];
  const otp = inputData['Otp'];

  if (!id || !otp) throw new Error('Missing required parameters');

  const res = await ddb.send(new GetItemCommand({
    TableName: process.env.TABLE_NAME!,
    Key: { id: { S: id } },
  }));

  if (!res.Item) throw new Error('OTP not found');

  const storedHash = res.Item.otp.S!;
  const expiresAt = parseInt(res.Item.expiresAt.N!);

  if (Date.now() / 1000 > expiresAt) {
    await deleteOtp(id);
    throw new Error("OTP expired");
  }

  const hashToVerify = createHash("sha256").update(otp).digest("hex");
  if (hashToVerify !== storedHash) throw new Error('Invalid OTP');

  await deleteOtp(id);
  
  return { 
    isSuccess: true,
    data: {
      verified: true, 
      message: 'OTP verified successfully' 
    }
  };
}

async function deleteOtp(id: string) {
  await ddb.send(new DeleteItemCommand({
    TableName: process.env.TABLE_NAME!,
    Key: { id: { S: id } },
  }));
}

async function sendSmsOtp(phone: string, otp: string) {
  console.log(`Sending SMS OTP ${otp} to ${phone}`);
  await sns.send(new PublishCommand({
    PhoneNumber: phone,
    Message: `Your verification code is ${otp}. It will expire in 5 minutes.`,
  }));
}

async function sendEmailOtp(email: string, otp: string) {
  console.log(`Sending Email OTP ${otp} to ${email}`);
  await ses.send(new SendEmailCommand({
    Destination: { ToAddresses: [email] },
    Message: {
      Subject: { Data: "Your Verification Code" },
      Body: {
        Text: { Data: `Your verification code is ${otp}. It will expire in 5 minutes.` },
      },
    },
    Source: "hiei.mugiwara@gmail.com", // Must be verified in SES
  }));
}