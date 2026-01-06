import 'package:fcb_pay_plus/data/data.dart';

class SecureStorageRepository {
  final SecureStorageService storageService;

  SecureStorageRepository({required this.storageService});

  // SAVE METHODS
  Future<void> saveUsername(String username) async {
    await storageService.saveUsername(username);
  }

  Future<void> saveSessionToken(String session) async {
    await storageService.saveSessionToken(session);
  }

  Future<void> saveBiometricStatus(int status) async {
    await storageService.saveBiometricStatus(status);
  }

  Future<void> saveScannedQr(List<QrData> qrData) async {
    await storageService.saveScannedQr(qrData);
  }

  Future<void> saveRawQr(String rawQr) async {
    await storageService.saveRawQr(rawQr);
  }

  Future<void> saveId(String id) async {
    await storageService.saveId(id);
  }

  Future<void> saveOnboardingStatus(int status) async {
    await storageService.saveOnboardingStatus(status);
  }

  // READ METHODS
  Future<String?> getUsername() async {
    return await storageService.getUsername();
  }

  Future<String?> getSessionToken() async {
    return await storageService.getSessionToken();
  }

  Future<int?> getBiometricStatus() async {
    return await storageService.getBiometricStatus();
  }

  Future<List<QrData>?> getScannedQr() async {
    return await storageService.getScannedQr();
  }

  Future<String?> getRawQr() async {
    return await storageService.getRawQr();
  }

  Future<String?> getId() async {
    return await storageService.getId();
  }

  Future<int?> getOnboardingStatus() async {
    return await storageService.getOnboardingStatus();
  }

  // DELETE METHODS
  Future<void> deleteUsername() async {
    await storageService.deleteUsername();
  }

  Future<void> deleteSessionToken() async {
    await storageService.deleteSessionToken();
  }

  Future<void> deleteBiometricStatus() async {
    await storageService.deleteBiometricStatus();
  }

  Future<void> deleteScannedQr() async {
    await storageService.deleteScannedQr();
  }

  Future<void> deleteRawQr() async {
    await storageService.deleteRawQr();
  }

  Future<void> deleteId() async {
    await storageService.deleteId();
  }

  Future<void> deleteOnboardingStatus() async {
    await storageService.deleteOnboardingStatus();
  }

  // DELETE ALL FIELDS
  Future<void> clearAll() async {
    await storageService.clearAll();
  }
}