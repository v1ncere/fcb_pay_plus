import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../data/data.dart';
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
      final echoRequest = GraphQLRequest<String>(
        document: '''
          query LivenessSessionId {
            livenessSessionId
          }
        ''',
      );

      final response = await Amplify.API.query(request: echoRequest).response;
      Map<String, dynamic> jsonMap = json.decode(response.data!);
      FaceLivenessSessionResponse res = FaceLivenessSessionResponse.fromJson(jsonMap);
      
      emit(
        res.model.success
        ? state.copyWith(sessionStatus: Status.success, sessionId: res.model.sessionId)
        : state.copyWith(sessionStatus: Status.failure, message: res.model.error ?? TextString.error)
      );
    } catch (_) {
      emit(state.copyWith(sessionStatus: Status.failure, message: TextString.error));
    }
    emit(state.copyWith(sessionStatus: Status.initial));
  }

  // INVOKE FACELIVENESS METHOD CHANNEL
  Future<void> _onFaceLivenessMethodChannelInvoked(FaceLivenessMethodChannelInvoked event, Emitter<FaceLivenessState> emit) async {
    emit(state.copyWith(invokeStatus: Status.loading));
    try {
      final MethodChannel channel = MethodChannel('com.example.fcb_pay_plus/liveness');

      final result = await channel.invokeMethod( // Send the session ID and region to the native side.
        'startFaceLiveness', {
          'sessionId': state.sessionId,
          'region': dotenv.get('FACELIVENESS_REGION'),
        }
      );

      if (result != null) {
        final map = Map<String, dynamic>.from(result);
        final status = map['status'] as String;
        
        emit(
          status == 'complete'
          ? state.copyWith(invokeStatus: Status.success, invokeResult: map)
          : state.copyWith(invokeStatus: Status.failure, message: map['message'] as String)
        );
      } else {
        emit(state.copyWith(invokeStatus: Status.failure, message: TextString.error));
      }
    } on PlatformException catch (e) {
      emit(state.copyWith(invokeStatus: Status.failure, message: '${e.message}'));
    } catch (_) {
      emit(state.copyWith(invokeStatus: Status.failure, message: TextString.error));
    }
    emit(state.copyWith(invokeStatus: Status.initial));
  }

  // FETCH FACELIVENESS RESULT
  Future<void> _onFaceLivenessResultFetched(FaceLivenessResultFetched event, Emitter<FaceLivenessState> emit) async {
    emit(state.copyWith(resultStatus: Status.loading));
    try {
      const graphQLDocument = '''
        query LivenessResult(\$data: AWSJSON!) {
          livenessResult(data: \$data)
        }
      ''';

      final echoRequest = GraphQLRequest<String>(
        document: graphQLDocument,
        variables: <String, dynamic> {
          "data": json.encode({ 'SessionId': state.sessionId })
        }
      );

      final response = await Amplify.API.query(request: echoRequest).response;
      Map<String, dynamic> jsonMap = json.decode(response.data!);
      FaceLivenessResultResponse res = FaceLivenessResultResponse.fromJson(jsonMap);

      if (res.model.success) {
        emit(
          res.model.isLivenessPassed
          ? state.copyWith(
            resultStatus: Status.success,
            rawBytes: res.model.referenceImageBytes,
            confidence: res.model.confidence)
          : state.copyWith(resultStatus: Status.failure, message: TextString.faceLivenessFailed)
        );
      } else {
        emit(state.copyWith(resultStatus: Status.failure, message: res.model.error ?? TextString.error));
      }
    } catch (e) {
      emit(state.copyWith(resultStatus: Status.failure, message: TextString.error));
    }
    emit(state.copyWith(resultStatus: Status.initial));
  }
}
