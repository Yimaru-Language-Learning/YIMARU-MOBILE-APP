import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:safe_device/safe_device.dart';
import 'package:yimaru_app/services/secure_storage_service.dart';

import '../app/app.locator.dart';

class StatusCheckerService {
  // Dependency injection
  final storage = locator<SecureStorageService>();

  // Developer mode
  bool? _isDeveloperModeEnabled;

  bool? get isDeveloperModeEnabled => _isDeveloperModeEnabled;

  // Developer mode
  Future<void> checkDeveloperMode() async {
    try {
      _isDeveloperModeEnabled = await SafeDevice.isDevelopmentModeEnable;
    } catch (e) {
      _isDeveloperModeEnabled = false;
    }
  }

  Future<bool> isRestricted() async {
    if (kDebugMode) return false;
    await checkDeveloperMode();
    return _isDeveloperModeEnabled ?? false;
  }

  // Check internet connection
  Future<bool> checkConnection() async {
    if (await InternetConnection().hasInternetAccess) {
      return true;
    } else {
      return false;
    }
  }

  // Get app version
  Future<String?> getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      String version = packageInfo.version; // e.g. 1.0.0
      String versionCode = packageInfo.buildNumber; // version code

      return versionCode;
    } catch (e) {
      return null;
    }
  }
}
