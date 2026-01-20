import { defineBackend } from '@aws-amplify/backend';
import { auth } from './auth/resource';
import { data } from './data/resource';
import { storage } from './storage/resource';
import { processTransaction } from './functions/processTransaction/resource';
import { otpApi } from './functions/otp-api/resource';
import { textInImage } from './functions/text-in-image/resource';
import { faceComparison } from './functions/face-comparison/resource';
import { livenessSessionId } from './functions/liveness-session-id/resource';
import { livenessResult } from './functions/liveness-result/resource';

/**
 * @see https://docs.amplify.aws/react/build-a-backend/ to add storage, functions, and more
 */
defineBackend({
  auth,
  data,
  storage,
  processTransaction,
  otpApi,
  textInImage,
  faceComparison,
  livenessSessionId,
  livenessResult,
});
