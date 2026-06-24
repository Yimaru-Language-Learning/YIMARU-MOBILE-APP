import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yimaru_app/services/secure_storage_service.dart';

import '../app/app.locator.dart';

class StatusCheckerService {
  // Dependency injection
  final storage = locator<SecureStorageService>();

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
    try{
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      String version = packageInfo.version; // e.g. 1.0.0
      String versionCode = packageInfo.buildNumber; // version code

      print("Version: $version");
      print("Build Number: $versionCode");
      return versionCode;

    }catch(e){
      print('IN-APP UPDATE EXCEPTION: ${e.toString()}');
      return null;
    }

  }
}
