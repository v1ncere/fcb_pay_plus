part of 'face_liveness_bloc.dart';

class FaceLivenessState extends Equatable {
  const FaceLivenessState({
    this.sessionId = '',
    this.sessionStatus = Status.initial,
    this.invokeStatus = Status.initial,
    this.resultStatus = Status.initial,
    this.invokeResult = const {},
    this.confidence = 0.0,
    this.rawBytes = const [],
    this.message = '',
  });

  final String sessionId;
  final Status sessionStatus;
  final Status invokeStatus;
  final Status resultStatus;
  final Map<dynamic, dynamic> invokeResult;
  final double confidence;
  final List<int> rawBytes;
  final String message;

  FaceLivenessState copyWith({
    String? sessionId,
    Status? sessionStatus,
    Status? invokeStatus,
    Status? resultStatus,
    Map<dynamic, dynamic>? invokeResult,
    double? confidence,
    List<int>? rawBytes,
    String? message,
  }) {
    return FaceLivenessState(
      sessionId: sessionId ?? this.sessionId,
      sessionStatus: sessionStatus ?? this.sessionStatus,
      invokeStatus: invokeStatus ?? this.invokeStatus,
      resultStatus: resultStatus ?? this.resultStatus,
      invokeResult: invokeResult ?? this.invokeResult,
      confidence: confidence ?? this.confidence,
      rawBytes: rawBytes ?? this.rawBytes,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
    invokeStatus,
    sessionStatus,
    resultStatus,
    sessionId,
    invokeResult,
    confidence,
    rawBytes,
    message,
  ];
}
