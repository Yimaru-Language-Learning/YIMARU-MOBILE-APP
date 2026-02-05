import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/services/authentication_service.dart';

import '../../../app/app.locator.dart';
import '../../../services/status_checker_service.dart';

class WelcomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _authenticationService = locator<AuthenticationService>();

  int _currentPage = 0;

  int get currentPage => _currentPage;

  // Navigation
  Future<void> navigateToLogin() async =>
      await _navigationService.navigateToLoginView();

  void next() {
    _currentPage++;
    rebuildUi();
  }

  // Remote api call

  // First time install
  Future<void> setFirstTimeInstall() async {
    await runBusyFuture(_setFirstTimeInstall());
  }

  Future<void> _setFirstTimeInstall() async {
    if (await _statusChecker.checkConnection()) {
      await _authenticationService.setFirstTimeInstall(false);
      await navigateToLogin();
    }
  }
}
