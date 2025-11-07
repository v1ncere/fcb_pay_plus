import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DeviceIdHelper {
  static final _storage = FlutterSecureStorage();
  static const _key = 'persistent_device_id';

  static Future<String> getDeviceUniqueId() async {
    // Check if stored ID already exists
    String? storedId = await _storage.read(key: _key);
    if (storedId != null) return storedId;

    // Generate a new one if not yet stored
    final deviceInfo = DeviceInfoPlugin();
    String rawId = '';

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      rawId = '${androidInfo.fingerprint}_${androidInfo.hardware}_${androidInfo.model}';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      rawId = iosInfo.identifierForVendor ?? 'unknown_ios_device';
    } else {
      rawId = 'unsupported_platform';
    }

    // Create a hashed version for privacy
    final hashedId = sha256.convert(utf8.encode(rawId)).toString();

    // Save it securely so it persists across app restarts
    await _storage.write(key: _key, value: hashedId);

    return hashedId;
  }

  static Future<Map<String, dynamic>> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return _readAndroidBuildData(androidInfo);
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return _readIosDeviceInfo(iosInfo);
    } else {
      return <String, dynamic>{'error': 'Failed to get platform version.'};
    }
  }
}

Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  return <String, dynamic>{
    'version.securityPatch': build.version.securityPatch,
    'version.sdkInt': build.version.sdkInt,
    'version.release': build.version.release,
    'version.previewSdkInt': build.version.previewSdkInt,
    'version.incremental': build.version.incremental,
    'version.codename': build.version.codename,
    'version.baseOS': build.version.baseOS,
    'board': build.board,
    'bootloader': build.bootloader,
    'brand': build.brand,
    'device': build.device,
    'display': build.display,
    'fingerprint': build.fingerprint,
    'hardware': build.hardware,
    'host': build.host,
    'id': build.id,
    'manufacturer': build.manufacturer,
    'model': build.model,
    'product': build.product,
    'name': build.name,
    'supported32BitAbis': build.supported32BitAbis,
    'supported64BitAbis': build.supported64BitAbis,
    'supportedAbis': build.supportedAbis,
    'tags': build.tags,
    'type': build.type,
    'isPhysicalDevice': build.isPhysicalDevice,
    'freeDiskSize': build.freeDiskSize,
    'totalDiskSize': build.totalDiskSize,
    'systemFeatures': build.systemFeatures,
    'isLowRamDevice': build.isLowRamDevice,
    'physicalRamSize': build.physicalRamSize,
    'availableRamSize': build.availableRamSize,
  };
}

Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
  return <String, dynamic>{
    'name': data.name,
    'systemName': data.systemName,
    'systemVersion': data.systemVersion,
    'model': data.model,
    'modelName': data.modelName,
    'localizedModel': data.localizedModel,
    'identifierForVendor': data.identifierForVendor,
    'isPhysicalDevice': data.isPhysicalDevice,
    'isiOSAppOnMac': data.isiOSAppOnMac,
    'freeDiskSize': data.freeDiskSize,
    'totalDiskSize': data.totalDiskSize,
    'physicalRamSize': data.physicalRamSize,
    'availableRamSize': data.availableRamSize,
    'utsname.sysname:': data.utsname.sysname,
    'utsname.nodename:': data.utsname.nodename,
    'utsname.release:': data.utsname.release,
    'utsname.version:': data.utsname.version,
    'utsname.machine:': data.utsname.machine,
  };
}