import 'dart:convert';
import 'dart:typed_data';

class FaceLivenessResultResponse {
  FaceLivenessResult model;

  FaceLivenessResultResponse({required this.model});

  factory FaceLivenessResultResponse.fromJson(Map<String, dynamic> raw) {
    final decoded = json.decode(raw['livenessResult']);
    return FaceLivenessResultResponse(
      model: FaceLivenessResult.fromAny(decoded)
    );
  }
}

class FaceLivenessResult {
  final bool isSuccess;
  final Map<String, dynamic>? data;
  final String? error;

  FaceLivenessResult({required this.isSuccess, this.data, this.error});

  factory FaceLivenessResult.fromAny(Map<String, dynamic> map) {
    return FaceLivenessResult(
      isSuccess: (map['isSuccess'] as bool?) ?? false,
      data: _toMap(map['data']),
      error: map['error'] as String?,
    );
  }

  bool get success => isSuccess && error == null;

  /// Status: CREATED, IN_PROGRESS, SUCCEEDED, FAILED, EXPIRED
  String get status => data?['Status'] ?? 'UNKNOWN';

  /// Confidence score (0–100 float)
  double get confidence {
    final value = data?['Confidence'];
    if (value is num) return value.toDouble();
    return 0.0;
  }

  /// True if liveness is successful (status + confidence)
  bool get isLivenessPassed => status == 'SUCCEEDED' && confidence >= 90.0;

  /// Returns ReferenceImage.Bytes as List`<int>`
  List<int>? get referenceImageBytes {
    final raw = data?['ReferenceImage']?['Bytes'];
    
    if (raw is List) {
      return List<int>.from(raw);
    }
    if (raw is Map<String, dynamic>) {
      return _mapBytesSorter(raw);
    }

    return null;
  }

  /// Get list of audit images (Bytes only)
  List<Uint8List> get auditImages {
    final list = data?['AuditImages'];
    if (list is List) {
      return list.map((img) {
        final bytes = img['Bytes'];
        if (bytes is List) return Uint8List.fromList(bytes.cast<int>());
        return null;
      })
      .whereType<Uint8List>()
      .toList();
    }
    return [];
  }

  /// Challenge Type: FaceMovementAndLightChallenge
  String get challengeType => data?['Challenge']?['Type'] ?? '';

  /// Challenge Version
  String get challengeVersion => data?['Challenge']?['Version'] ?? '';

  /// Rare fallback if Bytes come as Map`<String, dynamic>`
  List<int> _mapBytesSorter(Map<String, dynamic> rawBytes) {
    final numericKeys = rawBytes.keys
    .map((e) => int.tryParse(e))
    .where((e) => e != null)
    .cast<int>()
    .toList();

    numericKeys.sort((a, b) => a.compareTo(b));

    return numericKeys.map((key) => rawBytes['$key'] as int).toList();
  }
}

Map<String, dynamic>? _toMap(dynamic val) {
  if (val == null) return null;
  if (val is Map<String, dynamic>) return val;
  if (val is String && val.trim().isNotEmpty) {
    try {
      final decoded = json.decode(val);
      if (decoded is Map<String, dynamic>) return decoded;
    } catch (_) {
      return null;
    }
  }
  return null;
}