import 'package:flutter/services.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/models/app_update.dart';
import 'package:yimaru_app/services/status_checker_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../ui/common/ui_helpers.dart';
import 'api_service.dart';

class InAppUpdateService {
  // Dependency Injection
  final _apiService = locator<ApiService>();

  final _navigationService = locator<NavigationService>();

  final _statusCheckerService = locator<StatusCheckerService>();

  Future<void> checkForUpdate() async {
    try {
      final String? deviceVersion = await _statusCheckerService.getAppVersion();
      final remoteVersion = await InAppUpdate.checkForUpdate();

      if (deviceVersion != remoteVersion.availableVersionCode.toString()) {
        Map<String, dynamic> response =
            await _apiService.checkUpdate(deviceVersion ?? '');

        if (response['status'] == ResponseStatus.success) {
          AppUpdate update = response['data'] as AppUpdate;
          if (update.updateAvailable ?? false) {
            if (update.forceUpdate ?? false) {
              AppUpdateResult result =
                  await InAppUpdate.performImmediateUpdate();
              if (result == AppUpdateResult.userDeniedUpdate) {
                showErrorToast(
                    'An update is required to continue using this app.');
                SystemNavigator.pop();
              }
            } else {
              await InAppUpdate.startFlexibleUpdate();
            }
          }
        }
      }
    } on PlatformException {
      // Handle specific error code for better user experience and potentially different error messages for each issue
    }
  }
}
