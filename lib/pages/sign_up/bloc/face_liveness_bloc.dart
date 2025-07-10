import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:aws_signature_v4/aws_signature_v4.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../utils/utils.dart';

part 'face_liveness_event.dart';
part 'face_liveness_state.dart';

class FaceLivenessBloc extends Bloc<FaceLivenessEvent, FaceLivenessState> {
  FaceLivenessBloc() : super(FaceLivenessState()) {
    on<FaceLivenessSessionIdFetched>(_onFaceLivenessSessionIdFetched);
    on<FaceLivenessMethodChannelInvoked>(_onFaceLivenessMethodChannelInvoked);
    on<FaceLivenessResultFetched>(_onFaceLivenessResultFetched);
  }

  // FETCH FACELIVENESS SESSION
  Future<void> _onFaceLivenessSessionIdFetched(FaceLivenessSessionIdFetched event, Emitter<FaceLivenessState> emit) async {
    emit(state.copyWith(sessionStatus: Status.loading));
    try {
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

      final signer = await _awsSigV4Signer();
      final signedRequest = await signer.sign(request, credentialScope: scope);
      final awsBaseHttpResponse = signedRequest.send();
      final response = await awsBaseHttpResponse.response;
      
      if (response.statusCode == 200) {
        final responseString = await response.decodeBody();
        final Map<String, dynamic> map = jsonDecode(responseString);
        final sessionId = map['sessionId'] as String;
        emit(state.copyWith(sessionStatus: Status.success, sessionId: sessionId));
      } else {
        final data = await response.decodeBody();
        final Map<String, dynamic> map = jsonDecode(data);
        final errorMessage = map['message'] ?? TextString.error;
        emit(state.copyWith(sessionStatus: Status.failure, message: errorMessage));
      }
    } catch (e) {
      emit(state.copyWith(sessionStatus: Status.failure, message: TextString.error));
    }
    emit(state.copyWith(sessionStatus: Status.initial));
  }

  // INVOKE FACELIVENESS METHOD CHANNEL
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
        
        if (status == 'complete') {
          emit(state.copyWith(invokeStatus: Status.success, invokeResult: map));
        } else {
          emit(state.copyWith(invokeStatus: Status.failure, message: map['message'] as String));
        }
      } else {
        emit(state.copyWith(invokeStatus: Status.failure, message: TextString.error));
      }
    } on PlatformException catch (e) {
      emit(state.copyWith(invokeStatus: Status.failure, message: '${e.message}'));
    } catch (e) {
      emit(state.copyWith(invokeStatus: Status.failure, message: TextString.error));
    }
    emit(state.copyWith(invokeStatus: Status.initial));
  }

  // FETCH FACELIVENESS RESULT
  Future<void> _onFaceLivenessResultFetched(FaceLivenessResultFetched event, Emitter<FaceLivenessState> emit) async {
    emit(state.copyWith(resultStatus: Status.loading));
    try {
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

      final signer = await _awsSigV4Signer();
      final signedRequest = await signer.sign(request, credentialScope: scope);
      final awsBaseHttpResponse = signedRequest.send();
      final response = await awsBaseHttpResponse.response;

      if (response.statusCode == 200) {
        final responseString = await response.decodeBody();
        final Map<String, dynamic> dataMap = jsonDecode(responseString);
        final rawBytes = dataMap['ReferenceImage']['Bytes'] as Map<String, dynamic>;
        final confidence = dataMap['Confidence'] as double;
        
        if (confidence >= 90.00) {
          emit(state.copyWith(
            resultStatus: Status.success,
            rawBytes: mapBytesSorter(rawBytes),
            confidence: confidence, 
            message: TextString.faceLivenessSuccess
          ));
        } else {
          emit(state.copyWith(resultStatus: Status.failure, message: TextString.faceLivenessFailed));
        }
      } else {
        final data = await response.decodeBody();
        final Map<String, dynamic> map = jsonDecode(data);
        final errorMessage = map['message'] ?? TextString.error;
        emit(state.copyWith(resultStatus: Status.failure, message: errorMessage));
      }
    } catch (e) {
      emit(state.copyWith(resultStatus: Status.failure, message: TextString.error));
    }
    emit(state.copyWith(resultStatus: Status.initial));
  }

  // AWS SIGNER
  Future<AWSSigV4Signer> _awsSigV4Signer() async {
    final cognito = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    final result = await cognito.fetchAuthSession();
    final credential = result.credentialsResult.value;

    return  AWSSigV4Signer(
      credentialsProvider: AWSCredentialsProvider(
        AWSCredentials(
          credential.accessKeyId,
          credential.secretAccessKey,
          credential.sessionToken,
        ),
      ),
    );
  }

  // SORT BYTES FROM MAP
  List<int> mapBytesSorter(Map<String, dynamic> rawBytes) {
    // convert map keys into list
    var sortedKeys = rawBytes.keys.toList()
    ..sort((a, b) => int.parse(a).compareTo(int.parse(b))); // parse into int and sort the keys 
    // return List<int> from map
    return sortedKeys.map((key) => rawBytes[key] as int).toList();
  }
}
