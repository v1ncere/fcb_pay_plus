import 'package:flutter/services.dart';

class NativeBridge {
  static const platform = MethodChannel('com.example.fcb_pay_plus/liveness');

  Future<String> startFaceLiveness() async {
    try {
      final result = await platform.invokeMethod('startFaceLiveness');
      return result;
    } on PlatformException catch (e) {
      return "Error: ${e.message}";
    } 
  }
}
