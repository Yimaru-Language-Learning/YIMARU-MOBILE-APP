import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/services/authentication_service.dart';

import '../../../app/app.locator.dart';

class WelcomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final _authenticationService = locator<AuthenticationService>();

  int _currentPage = 0;

  int get currentPage => _currentPage;

  Future<void> setFirstTimeInstall() async {
    await runBusyFuture(_setFirstTimeInstall());
  }

  // First time install
  Future<void> _setFirstTimeInstall() async {
    await _authenticationService.setFirstTimeInstall(false);
    await navigateToLogin();
  }

  // Navigation
  Future<void> navigateToLogin() async =>
      await _navigationService.navigateToLoginView();

  void next() {
    _currentPage++;
    rebuildUi();
  }
}
