import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:aws_signature_v4/aws_signature_v4.dart';
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_plus/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'face_liveness_event.dart';
part 'face_liveness_state.dart';

class FaceLivenessBloc extends Bloc<FaceLivenessEvent, FaceLivenessState> {
  FaceLivenessBloc() : super(FaceLivenessState()) {
    on<FaceLivenessSessionIdFetched>(_onFaceLivenessSessionIdFetched);
    on<FaceLivenessMethodChannelInvoked>(_onFaceLivenessMethodChannelInvoked);
    on<FaceLivenessResultFetched>(_onFaceLivenessResultFetched);
  }

  // Fetch FaceLiveness Session
  Future<void> _onFaceLivenessSessionIdFetched(FaceLivenessSessionIdFetched event, Emitter<FaceLivenessState> emit) async {
    emit(state.copyWith(sessionStatus: Status.loading));
    try {
      final cognito = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
      final result = await cognito.fetchAuthSession();
      final cred = result.credentialsResult.value;
      final signer = AWSSigV4Signer(credentialsProvider: AWSCredentialsProvider(AWSCredentials(cred.accessKeyId, cred.secretAccessKey, cred.sessionToken)));
      final endpoint = Uri.https(dotenv.get('FACELIVENESS_SESSION_HOST'), dotenv.get('FACELIVENESS_SESSION_PATH'));
      final scope = AWSCredentialScope(region: dotenv.get('COGNITO_REGION'), service: AWSService(dotenv.get('SERVICE')));
      final request = AWSHttpRequest(
        method: AWSHttpMethod.post,
        uri: endpoint,
        headers: {
          AWSHeaders.host: endpoint.host,
          AWSHeaders.contentType: 'application/json',
        },
      );
      final signedRequest = await signer.sign(request, credentialScope: scope);
      final resp = signedRequest.send();
      final respBody = await resp.response;

      if (respBody.statusCode == 200) {
        final map = jsonDecode(await respBody.decodeBody()) as Map<String, dynamic>;
        final sessionId = map["sessionId"] as String;
        emit(state.copyWith(sessionStatus: Status.success, sessionId: sessionId));
      } else {
        emit(state.copyWith(sessionStatus: Status.failure, message:'Error: ${await respBody.decodeBody()}'));
      }
    } catch (e) {
      emit(state.copyWith(sessionStatus: Status.failure, message:'Error: ${e.toString()}'));
    }
    emit(state.copyWith(sessionStatus: Status.initial));
  }

  // Invoke FaceLiveness Method Channel
  Future<void> _onFaceLivenessMethodChannelInvoked(FaceLivenessMethodChannelInvoked event, Emitter<FaceLivenessState> emit) async {
    emit(state.copyWith(invokeStatus: Status.loading));
    try {
      final MethodChannel channel = MethodChannel('com.example.fcb_pay_plus/liveness');
      // Send the session ID and region to the native side.
      final result = await channel.invokeMethod(
        'startFaceLiveness', {
          'sessionId': state.sessionId,
          'region': dotenv.get('FACELIVENESS_REGION'),
        }
      );
      if (result != null) {
        final map = Map.from(result);
        final status = map['status'] as String;
        
        if (status == "complete") {
          emit(state.copyWith(invokeStatus: Status.success, invokeResult: map));
        } else {
          emit(state.copyWith(invokeStatus: Status.failure, message: map['message'] as String));
        }
      } else {
        emit(state.copyWith(invokeStatus: Status.failure, message: TextString.error));
      }
    } on PlatformException catch (e) {
      emit(state.copyWith(invokeStatus: Status.failure, message:"Error: ${e.message}"));
    } catch (e) {
      emit(state.copyWith(invokeStatus: Status.failure, message:"Error: ${e.toString()}"));
    }
    emit(state.copyWith(invokeStatus: Status.initial));
  }

  // Fetch FaceLiveness Result
  Future<void> _onFaceLivenessResultFetched(FaceLivenessResultFetched event, Emitter<FaceLivenessState> emit) async {
    emit(state.copyWith(resultStatus: Status.loading));
    try {
      final cognito = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
      final result = await cognito.fetchAuthSession();
      final cred = result.credentialsResult.value;
      final signer = AWSSigV4Signer(credentialsProvider: AWSCredentialsProvider(AWSCredentials(cred.accessKeyId, cred.secretAccessKey, cred.sessionToken)));
      final url = Uri.https(dotenv.get('FACELIVENESS_RESULT_HOST'), dotenv.get('FACELIVENESS_RESULT_PATH'));
      final scope = AWSCredentialScope(region: dotenv.get('COGNITO_REGION'), service: AWSService(dotenv.get('SERVICE')));
      final request = AWSHttpRequest(
        method: AWSHttpMethod.post,
        uri: url,
        headers: {
          AWSHeaders.host: url.host,
          AWSHeaders.contentType: 'application/json',
        },
        body: json.encode({ 'sessionId': state.sessionId }).codeUnits,
      );

      final signedRequest = await signer.sign(request, credentialScope: scope);
      final res = signedRequest.send();
      final respBody = await res.response;

      if (respBody.statusCode == 200) {
        final map = jsonDecode(await respBody.decodeBody()) as Map<String, dynamic>;
        final rawBytes = map["ReferenceImage"]["Bytes"] as Map<String, dynamic>;
        final confidence = map["Confidence"] as double;
        
        if (confidence > 90.00) {
          emit(state.copyWith(resultStatus: Status.success, rawBytes: mapBlobSorter(rawBytes), confidence: confidence));
        } else {
          emit(state.copyWith(resultStatus: Status.failure, message: TextString.faceLivenessFailed));
        }
      } else {
        emit(state.copyWith(resultStatus: Status.failure, message:'Error: ${await respBody.decodeBody()}'));
      }
    } catch (e) {
      emit(state.copyWith(resultStatus: Status.failure, message:'Error: ${e.toString()}'));
    }
  }

  List<int> mapBlobSorter(Map<String, dynamic> rawBytes) {
    // convert map keys into list
    var sortedKeys = rawBytes.keys.toList()
    ..sort((a, b) => int.parse(a).compareTo(int.parse(b))); // parse into int and sort the keys 
    // return List<int> from map
    return sortedKeys.map((key) => rawBytes[key] as int).toList();
  }
}
