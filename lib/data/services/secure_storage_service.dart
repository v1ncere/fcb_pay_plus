
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data.dart';

class SecureStorageService {
  final  _storage = const FlutterSecureStorage();

  //* SAVE METHODS *//

  Future<void> saveUsername(String username) async {
    await _storage.write(key: 'username', value: username);
  }

  Future<void> saveSessionToken(String session) async {
    await _storage.write(key: 'session', value: session);
  }

  Future<void> saveBiometricStatus(int status) async {
    await _storage.write(key: 'biometric', value: status.toString());
  }

  Future<void> saveScannedQr(List<QrData> qrData) async {
    String result = qrData.map((e) => e.toMap()).toList().toString();
    await _storage.write(key: 'scanner', value: result);
  }

  Future<void> saveRawQr(String rawQr) async {
    await _storage.write(key: 'rawQr', value: rawQr);
  }

  Future<void> saveId(String id) async {
    await _storage.write(key: 'id', value: id);
  }

  Future<void> saveOnboardingStatus(int status) async {
    await _storage.write(key: 'onboarding', value: status.toString());
  }

  // ============== READ ==============

  Future<String?> getUsername() async => await _storage.read(key: 'username');
  
  Future<String?> getSessionToken() async => await _storage.read(key: 'session');

  Future<int?> getBiometricStatus() async {
    String? status = await _storage.read(key: 'biometric');
    return status != null ? int.tryParse(status) : null;
  }

  Future<List<QrData>?> getScannedQr() async {
    final result = await _storage.read(key: 'scanner');
    return result != null 
    ? (json.decode(result) as List).map((e) => QrData.fromMap(e as Map<String, dynamic>)).toList()
    : null;
  }

  Future<String?> getRawQr() async => await _storage.read(key: 'rawQr');

  Future<String?> getId() async => await _storage.read(key: 'id');

  Future<int?> getOnboardingStatus() async {
    String? status = await _storage.read(key: 'onboarding');
    return status != null ? int.tryParse(status) : null;
  }

  // ============ DELETE SINGLE FIELD ============

  Future<void> deleteUsername() async => await _storage.delete(key: 'username');

  Future<void> deleteSessionToken() async => await _storage.delete(key: 'session');

  Future<void> deleteBiometricStatus() async => await _storage.delete(key: 'biometric');

  Future<void> deleteScannedQr() async => await _storage.delete(key: 'scanner');

  Future<void> deleteRawQr() async => await _storage.delete(key: 'rawQr');

  Future<void> deleteId() async => await _storage.delete(key: 'id');

  Future<void> deleteOnboardingStatus() async => await _storage.delete(key: 'onboarding');

  // ============ DELETE ALL FIELDS ============

  Future<void> clearAll() async => await _storage.deleteAll();
}