import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
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
}
