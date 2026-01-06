import 'dart:convert';

class FaceComparisonResponse {
  final FaceComparison faceComparison;

  FaceComparisonResponse({required this.faceComparison});

  factory FaceComparisonResponse.fromJson(Map<String, dynamic> json) {
    return FaceComparisonResponse(
      faceComparison: FaceComparison.fromAny(json['faceComparison'])
    );
  }
}

class FaceComparison {
  final bool isSuccess;
  final Map<String, dynamic>? data;
  final String? error;

  FaceComparison({required this.isSuccess, this.data, this.error});

  /// Accepts either a Map or a JSON string
  factory FaceComparison.fromAny(dynamic value) {
    final map = _toMap(value) ?? {};

    return FaceComparison(
      isSuccess: (map['isSuccess'] as bool?) ?? false,
      data: _toMap(map['data']),
      error: map['error'] as String?,
    );
  }

  /// Helper: success + message in one line
  bool get ok => isSuccess && error == null;

  /// Helper: get data field safely
  T? getField<T>(String key) => (data?[key] as T?);

  /// Get the first similarity from FaceMatches (or null)
  double? get firstSimilarity {
    final matches = getField<List<dynamic>>('FaceMatches');
    if (matches == null || matches.isEmpty) return null;

    return (matches.first['Similarity'] as num?)?.toDouble();
  }

  /// Get all similarity values as a list
  List<double> get allSimilarities {
    final matches = getField<List<dynamic>>('FaceMatches');
    if (matches == null) return [];

    return matches
    .whereType<Map<String, dynamic>>()
    .map((e) => (e['Similarity'] as num?)?.toDouble())
    .whereType<double>()
    .toList();
  }

  /// Check if first similarity >= threshold (default 90)
  bool isFirstMatchAbove(double threshold) {
    final sim = firstSimilarity;
    return sim != null && sim >= threshold;
  }

  /// Check if any similarity >= threshold
  bool anyMatchAbove(double threshold) {
    return allSimilarities.any((s) => s >= threshold);
  }
}

Map<String, dynamic>? _toMap(dynamic value) {
  if (value == null) return null;
  if (value is Map<String, dynamic>) return value;
  if (value is String && value.trim().isNotEmpty) {
    try {
      final decoded = jsonDecode(value);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
    } catch (_) {
      return null;
    }
  }

  return null;
}