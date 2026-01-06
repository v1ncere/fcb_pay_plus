import 'dart:convert';

class FaceLivenessSessionResponse {
  final FaceLivenessSession model;

  FaceLivenessSessionResponse({required this.model});

  factory FaceLivenessSessionResponse.fromJson(Map<String, dynamic> raw) {
    final decoded = json.decode(raw['livenessSessionId']);
    return FaceLivenessSessionResponse(
      model: FaceLivenessSession.fromAny(decoded)
    );
  }
}

class FaceLivenessSession {
  final bool isSuccess;
  final Map<String, dynamic>? data;
  final String? error;

  FaceLivenessSession({required this.isSuccess, this.data, this.error});

  factory FaceLivenessSession.fromAny(Map<String, dynamic> map) {
    return FaceLivenessSession(
      isSuccess: (map['isSuccess'] as bool?) ?? false,
      data: _toMap(map['data']),
      error: map['error'] as String?,
    );
  }

  bool get success => isSuccess && error == null;

  String get sessionId => (data?['SessionId'] as String? ?? '');
}

Map<String, dynamic>? _toMap(dynamic val) {
  if (val == null) return null;
  if (val is Map<String, dynamic>) return val;
  if (val is String && val.trim().isNotEmpty) {
    try {
      final decoded = json.decode(val);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
    } catch (_) {
      return null;
    }
  }
  return null;
}