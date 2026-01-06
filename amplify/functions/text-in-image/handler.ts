import { RekognitionClient, DetectTextCommand } from "@aws-sdk/client-rekognition";
import { type Schema } from '../../data/resource';

class UserError extends Error {}

const rekognitionClient = new RekognitionClient();

export const handler: Schema['textInImage']['functionHandler'] = async (event) => {
  try {
    const params = event.arguments.data;
    const imageBytes = params['ImageBytes'];
    if (!imageBytes) throw new UserError("Missing parameters.");
    
    const imageBytesBuffer = Buffer.from(imageBytes, 'base64');
    
    const input = {
      Image: { Bytes: imageBytesBuffer },
      Filters: {
        WordFilter: {
          MinConfidence: 80,
        },
      },
    };

    const command = new DetectTextCommand(input);
    const response = await rekognitionClient.send(command);
    
    return { 
      isSuccess: true,
      data: JSON.stringify(response)
    };
  } catch (err: any) {
    if (err instanceof UserError) {
      return { isSuccess: false, error: err.message };
    }

    console.error("Error processing image:", err);
    return { isSuccess: false, error: "Failed to analyze image." };
  }
}