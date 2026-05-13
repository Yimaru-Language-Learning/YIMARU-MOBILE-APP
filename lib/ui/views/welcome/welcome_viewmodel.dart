import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/services/authentication_service.dart';

import '../../../app/app.locator.dart';

class WelcomeViewModel extends BaseViewModel {
  // Dependency Injection
  final _navigationService = locator<NavigationService>();

  final _authenticationService = locator<AuthenticationService>();

  // Navigation
  Future<void> navigateToLogin() async =>
      await _navigationService.replaceWithLoginView();

  // Remote api call

  // First time install
  Future<void> setFirstTimeInstall() async {
    await runBusyFuture(_setFirstTimeInstall());
  }

  Future<void> _setFirstTimeInstall() async {
    await _authenticationService.setFirstTimeInstall(false);
    await navigateToLogin();
  }
}
