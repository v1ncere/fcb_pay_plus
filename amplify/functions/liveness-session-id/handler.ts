import { RekognitionClient, CreateFaceLivenessSessionCommand } from "@aws-sdk/client-rekognition";
import { type Schema } from '../../data/resource';

const rekognitionClient = new RekognitionClient({ region: 'us-east-1' });

export const handler: Schema['livenessSessionId']['functionHandler'] = async (event) => {
  try {
    const command = new CreateFaceLivenessSessionCommand({});
    const response = await rekognitionClient.send(command);

    return { isSuccess: true, data: response };
  } catch (err: any) {
    console.error("Error fetch liveness session:", err);
    return { isSuccess: false, error: "Failed to fetch session." };
  }
};