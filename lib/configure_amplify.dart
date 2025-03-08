import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

import 'amplify_outputs.dart';
import 'models/ModelProvider.dart';

Future<void> configureAmplify() async {
  try {
    await Amplify.addPlugins(
      [
        AmplifyAuthCognito(),
        AmplifyAPI(
          options: APIPluginOptions(
            modelProvider: ModelProvider.instance
          )
        ),
        AmplifyStorageS3(),
      ]
    );
    await Amplify.configure(amplifyConfig);
    safePrint('Successfully configured');
  } on Exception catch (e) {
    safePrint("Error configuring Amplify: $e");
  }
}