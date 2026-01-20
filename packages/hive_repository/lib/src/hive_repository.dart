
class HiveRepository {
  // // ====================== SCANNER =================
  //   static const String _scannerBox = 'SCANNER_BOX'; 
  //   static const String _scannerStaticKey = '5343';
  // // ================================================

  // Future<void> addQRDataList(List<QRModel> qrData) async {
  //   final box = await Hive.openBox<List<QRModel>>(_scannerBox);
  //   await box.put(_scannerStaticKey, qrData);
  // }

  // Future<List<QRModel>> getQRDataList() async {
  //   try {
  //     final box = await Hive.openBox<List<QRModel>>(_scannerBox);
  //     return box.get(_scannerStaticKey) ?? [];
  //   } catch (_) {
  //     return [];
  //   }
  // }

  // Future<void> deleteQRDataList() async {
  //   final box = await Hive.openBox<List<QRModel>>(_scannerBox);
  //   await box.delete(_scannerStaticKey);
  // }

  // Future<void> closeScannerBox() async {
  //   if (Hive.isBoxOpen(_scannerBox)) {
  //     final box = Hive.box<String>(_scannerBox);
  //     await box.close();
  //   }
  // }

  // // ================== ID ====================
  //   static const String _idBox = 'ID_BOX'; // for flutter secure storage
  //   static const String _idStaticKey = '1001';
  // // ==========================================

  // Future<void> addId(String id) async {
  //   final box = await Hive.openBox<String>(_idBox);
  //   await box.put(_idStaticKey, id);
  // }

  // Future<String> getId() async {
  //   try {
  //     final box = await Hive.openBox<String>(_idBox);
  //     return box.get(_idStaticKey) ?? '';
  //   } catch (_) {
  //     return '';
  //   }
  // }

  // Future<void> deleteId() async {
  //   final box = await Hive.openBox<String>(_idBox);
  //   await box.delete(_idStaticKey);
  // }

  // Future<void> closeIdBox() async {
  //   if (Hive.isBoxOpen(_idBox)) {
  //     final box = Hive.box<String>(_idBox);
  //     await box.close();
  //   }
  // }

  // // ================ QR RAW DATA ================
  //   static const String _qrRawBox = 'QR_RAW_BOX'; // for flutter secure storage
  //   static const String _qrRawStaticKey = '5152';
  // // =============================================

  // Future<void> addRawQR(String rawQRData) async {
  //   final box = await Hive.openBox<String>(_qrRawBox);
  //   await box.put(_qrRawStaticKey, rawQRData);
  // }
  
  // Future<String> getRawQR() async {
  //   try {
  //     final box = await Hive.openBox<String>(_qrRawBox);
  //     return box.get(_qrRawStaticKey) ?? '';
  //   } catch (_) {
  //     return '';
  //   }
  // }
  
  // Future<void> deleteRawQR() async {
  //   final box = await Hive.openBox<String>(_qrRawBox);
  //   await box.delete(_qrRawStaticKey);
  // }

  // Future<void> closeRawQrBox() async {
  //   if (Hive.isBoxOpen(_qrRawBox)) {
  //     final box = Hive.box<String>(_qrRawBox);
  //     await box.close();
  //   }
  // }

  // // ================== ACCOUNT ====================
  //   static const String _accountBox = 'ACCOUNT_BOX';
  // // ===============================================
  
  // Future<void> addAccountNumber({
  //   required String uid,
  //   required String accountNumber
  // }) async {
  //   final box = await Hive.openBox<String>(_accountBox);
  //   await box.put(uid, accountNumber);
  // }
  
  // Future<String> getAccountNumber(String uid) async {
  //   try {
  //     final box = await Hive.openBox<String>(_accountBox);
  //     return box.get(uid) ?? '';
  //   } catch (_) {
  //     return '';
  //   }
  // }
  
  // Future<void> deleteAccountNumber(String uid) async {
  //   final box = await Hive.openBox<String>(_accountBox);
  //   await box.delete(uid);
  // }

  // Future<void> closeAccountNumberBox() async {
  //   if (Hive.isBoxOpen(_accountBox)) {
  //     final box = Hive.box<String>(_accountBox);
  //     await box.close();
  //   }
  // }

  // // ================== MERCHANT =====================
  //   static const String _merchantBox = 'MERCHANT_BOX';
  // // =================================================
  
  // Future<void> addMerchant(MerchantModel model) async {
  //   final box = await Hive.openBox<MerchantModel>(_merchantBox);
  //   await box.put(model.id, model);
  // }

  // Future<List<MerchantModel>> getMerchants() async {
  //   try {
  //     final box = await Hive.openBox<MerchantModel>(_merchantBox);
  //     return box.values.toList();
  //   } catch (_) {
  //     return [];
  //   }
  // }

  // Future<void> deleteMerchant(String id) async {
  //   final box = await Hive.openBox<MerchantModel>(_merchantBox);
  //   await box.delete(id);
  // }

  // Future<void> closeMerchantBox() async {
  //   if (Hive.isBoxOpen(_merchantBox)) {
  //     final box = Hive.box<String>(_merchantBox);
  //     await box.close();
  //   }
  // }

  // // ===================== ONBOARDING =====================
  //   static const String _onboardingBox = 'ONBOARDING_BOX'; // for flutter secure storage
  //   static const String _onBoardingStaticKey = '4f4e';
  // // ======================================================
  
  // Future<void> updateOnboarding(bool status) async {
  //   final box = await Hive.openBox<bool>(_onboardingBox);
  //   await box.put(_onBoardingStaticKey, status);
  // }
  
  // Future<bool> isOnboarded() async {
  //   try {
  //     final box = await Hive.openBox<bool>(_onboardingBox);
  //     return box.get(_onBoardingStaticKey) ?? false;
  //   } catch (_) {
  //     return false;
  //   }
  // }
  
  // Future<void> deleteOnBoarding() async {
  //   final box = await Hive.openBox<bool>(_onboardingBox);
  //   await box.delete(_onBoardingStaticKey);
  // }
  
  // Future<void> closeOnboardingBox() async {
  //   if (Hive.isBoxOpen(_onboardingBox)) {
  //     final box = Hive.box<bool>(_onboardingBox);
  //     await box.close();
  //   }
  // }
}