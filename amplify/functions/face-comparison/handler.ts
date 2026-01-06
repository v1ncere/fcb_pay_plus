import { RekognitionClient, CompareFacesCommand } from "@aws-sdk/client-rekognition";
import { type Schema } from '../../data/resource';

class UserError extends Error {}

const rekognitionClient = new RekognitionClient();

export const handler: Schema['faceComparison']['functionHandler'] = async (event) => {
  try {
    const params = event.arguments.data;
    const source = params['SourceImageBytes'];
    const target = params['TargetImageBytes'];
    if (!source || !target) throw new UserError("Missing parameters.");

    const sourceImageBytesBuffer = Buffer.from(source, 'base64');
    const targetImageBytesBuffer = Buffer.from(target, 'base64');

    const input = {
      SourceImage: { Bytes: sourceImageBytesBuffer },
      TargetImage: { Bytes: targetImageBytesBuffer },
      SimilarityThreshold: 95,
    };

    const command = new CompareFacesCommand(input);
    const response = await rekognitionClient.send(command);

    return { isSuccess: true, data: JSON.stringify(response) };
  } catch (err: any) {
    if (err instanceof UserError) {
      return { isSuccess: false, error: err.message };
    }

    console.error("Error:", err.message);
    return { isSuccess: false, error: "Failed to analyze image." };
  }
};