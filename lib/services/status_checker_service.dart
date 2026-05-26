import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yimaru_app/services/secure_storage_service.dart';

import '../app/app.locator.dart';

class StatusCheckerService {
  // Dependency injection
  final storage = locator<SecureStorageService>();

  // Initialization
  bool _previousConnection = true;

  bool get previousConnection => _previousConnection;

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

  // Get app version
  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version; // e.g. 1.0.0
    String buildNumber = packageInfo.buildNumber; // version code

    print("Version: $version");
    print("Build Number: $buildNumber");
    return buildNumber;
  }
}
