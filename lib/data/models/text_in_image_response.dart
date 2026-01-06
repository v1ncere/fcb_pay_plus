import 'dart:convert';

class TextInImageResponse {
  final TextInImage textInImage;
  
  TextInImageResponse({required this.textInImage});

  factory TextInImageResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['textInImage'];
    final map = raw is String
      ? jsonDecode(raw)
      : raw is Map<String, dynamic>
        ? raw
        : throw Exception("Invalid data format.");
    return TextInImageResponse(textInImage: TextInImage.fromJson(map));
  }
}

class TextInImage {
  final bool isSuccess;
  final Map<String, dynamic>? data;
  final String? error;

  TextInImage({required this.isSuccess, this.data, this.error});
  
  factory TextInImage.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    final parsedData = rawData == null
    ? null
    : rawData is String
      ? jsonDecode(rawData)
      : rawData is Map<String, dynamic>
        ? rawData
        : throw Exception("Unexpected data format for data");

    return TextInImage(
      isSuccess: (json['isSuccess'] as bool?) ?? false,
      data: parsedData,
      error: json['error'] as String?,
    );
  }

  // ---------------------------
  // 🔥 Helper Methods
  // ---------------------------

  /// Raw TextDetections list
  List<dynamic> get detections => (data?['TextDetections'] as List<dynamic>? ?? []);

  /// Extract only detected text strings
  List<String> get detectedTexts => detections
  .map((e) => (e['DetectedText']?.toString() ?? "")
    .replaceAll(',', '')
    .trim()
    .toLowerCase())
  .where((txt) => txt.isNotEmpty)
  .toList();

  /// Check if any detected text contains the given keyword
  bool containsText(String keyword) {
    final lower = keyword.trim().toLowerCase();
    return detectedTexts.any((e) => e.contains(lower));
  }

  /// Find the first match (or null)
  String? firstMatch(String keyword) {
    final lower = keyword.trim().toLowerCase();
    return detectedTexts.firstWhere(
      (e) => e.contains(lower),
      orElse: () => "",
    ).isEmpty ? null : detectedTexts.firstWhere((e) => e.contains(lower));
  }

  /// Check if all keywords appear somewhere in the text
  bool containsAll(List<String> keywords) {
    for (final e in keywords) {
      if (!containsText(e)) return false;
    }
    return true;
  }

  /// Check if ANY of the keywords exists
  bool containsAny(List<String> keywords) {
    for (final e in keywords) {
      if (containsText(e)) return true;
    }
    return false;
  }
}