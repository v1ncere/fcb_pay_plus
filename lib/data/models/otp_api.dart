import 'dart:convert';

class OtpApiResponse {
  final OtpApi otpApi;

  OtpApiResponse({required this.otpApi});

  factory OtpApiResponse.fromJson(Map<String, dynamic> json) {
    final decoded = jsonDecode(json['otpApi']); // must start with the function name
    return OtpApiResponse(otpApi: OtpApi.fromJson(decoded));
  }
}

class OtpApi {
  final bool isSuccess;
  final OtpData? data;
  final String? error;

  OtpApi({required this.isSuccess, this.data, this.error});

  factory OtpApi.fromJson(Map<String, dynamic> json) {
    String? parsedError;
    
    if (json['error'] != null) {
      final rawError = json['error'];
      try {
        final decoded = jsonDecode(rawError);
        if (decoded is List && decoded.isNotEmpty && decoded[0]['message'] != null) {
          parsedError = decoded.map((e) => e['message']).join('\n');
        } else {
          parsedError = decoded.toString();
        }
      } catch (_) {
        parsedError = rawError;
      }
    }

    return OtpApi(
      isSuccess: json['isSuccess'] as bool,
      data: json['data'] != null ? OtpData.fromMap(json['data']) : null,
      error: parsedError
    );
  }
}

class OtpData {
  final String message;

  OtpData({ required this.message });

  factory OtpData.fromMap(Map<String, dynamic> map) {
    return OtpData(
      message: map['message'] as String,
    );
  }
}