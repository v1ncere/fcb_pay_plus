import { RekognitionClient, GetFaceLivenessSessionResultsCommand } from "@aws-sdk/client-rekognition";
import { type Schema } from '../../data/resource';

class UserError extends Error {}

const rekognitionClient = new RekognitionClient({ region: 'us-east-1' });

export const handler: Schema['livenessResult']['functionHandler'] = async (event) => {
  try {
    const params = event.arguments.data;
    const sessionId = params['SessionId'];
    if (!sessionId) throw new UserError('Missing parameter.');

    const input = { SessionId: sessionId }

    const command = new GetFaceLivenessSessionResultsCommand(input);
    const response = await rekognitionClient.send(command);
    
    return { isSuccess: true, data: response };
  } catch (err: any) {
    if (err instanceof UserError) {
      return { isSuccess: false, error: err.message };
    }
    
    console.error("Error fetch liveness result:", err);
    return { isSuccess: false, error: "Failed to fetch result." };
  }
};
