import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/services.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:storage_info/storage_info.dart';
import 'package:yimaru_app/app/app.locator.dart';

import '../ui/common/ui_helpers.dart';

class InAppUpdateService {
  final _navigationService = locator<NavigationService>();

  Future<int> getBatteryLevel() async {
    final battery = Battery();
    final batteryLevel = await battery.batteryLevel;
    return batteryLevel;
  }

  Future<int> getAvailableStorage() async {
    try {
      final availableStorage =
          await StorageInfo().getStorageFreeSpace(SpaceUnit.Bytes);
      return availableStorage.toInt(); // Convert GB to bytes
    } catch (e) {
      return 0;
    }
  }

  Future<void> checkForUpdate() async {
    const requiredStorage = 500 * 1024 * 1024;

    final batteryLevel =
        await getBatteryLevel(); // Implement getBatteryLevel function
    final int storageAvailable =
        await getAvailableStorage(); // Implement getAvailableStorage
    if (batteryLevel < 20 || storageAvailable < requiredStorage) {
      if (batteryLevel < 20 || storageAvailable < requiredStorage) {
        // KewedeConst().showErrorToast(
        //     'Unable to update app, please charge your phone & free up space.');
      } else if (batteryLevel < 20) {
        // KewedeConst()
        //     .showErrorToast('Unable to update app, please charge your phone.');
      } else if (storageAvailable < requiredStorage) {
        // KewedeConst()
        //     .showErrorToast('Unable to update app, please free up space.');
      }
      // Show user-friendly message explaining why update failed and suggesting solutions (e.g., charge device, free up space)
    }
    try {
      final info = await InAppUpdate.checkForUpdate();
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        AppUpdateResult result = await InAppUpdate.performImmediateUpdate();
        if (result == AppUpdateResult.userDeniedUpdate) {
          showErrorToast('An update is required to continue using this app.');
          _navigationService.back();
        }
      }

      // ... rest of your update logic ...
    } on PlatformException {
      // Handle specific error code for better user experience and potentially different error messages for each issue
    }
  }
}
