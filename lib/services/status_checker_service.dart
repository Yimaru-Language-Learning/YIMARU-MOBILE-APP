import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/services.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:storage_info/storage_info.dart';
import 'package:yimaru_app/services/secure_storage_service.dart';

import '../app/app.locator.dart';

class StatusCheckerService {
  // Dependency injection
  final storage = locator<SecureStorageService>();

  // Initialization
  bool _previousConnection = true;

  bool get previousConnection => _previousConnection;

  // Get phone battery level
  Future<int> getBatteryLevel() async {
    final battery = Battery();
    final batteryLevel = await battery.batteryLevel;
    return batteryLevel;
  }

  // Check internet connection
  Future<bool> checkConnection() async {
    if (await InternetConnection().hasInternetAccess) {
      _previousConnection = true;
      return true;
    } else {
      if (_previousConnection) {
        _previousConnection = false;
      }

      return false;
    }
  }

  // Check phone available storage
  Future<int> getAvailableStorage() async {
    try {
      final availableStorage =
          await StorageInfo().getStorageFreeSpace(SpaceUnit.Bytes);
      return availableStorage.toInt(); // Convert GB to bytes
    } catch (e) {
      return 0;
    }
  }

  // Check for latest update
  Future<void> checkAndUpdate() async {
    const requiredStorage = 500 * 1024 * 1024;

    final batteryLevel =
        await getBatteryLevel(); // Implement getBatteryLevel function
    final int storageAvailable =
        await getAvailableStorage(); // Implement getAvailableStorage
    if (batteryLevel < 20 || storageAvailable < requiredStorage) {
      if (batteryLevel < 20 || storageAvailable < requiredStorage) {
        //     'Unable to update app, please charge your phone & free up space.');
      } else if (batteryLevel < 20) {
        //     .showErrorToast('Unable to update app, please charge your phone.');
      } else if (storageAvailable < requiredStorage) {
        //     .showErrorToast('Unable to update app, please free up space.');
      }
      return; // Prevent update from starting
    }
    try {
      if (await checkConnection()) {
        await InAppUpdate
            .checkForUpdate(); // Continue update only if sufficient resources available
      }

      // ... rest of your update logic ...
    } on PlatformException {
      // Handle specific error code for better user experience and potentially different error messages for each issue
    }
  }
}
