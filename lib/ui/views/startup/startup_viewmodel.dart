import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/in_app_update_service.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/status_checker_service.dart';

class StartupViewModel extends BaseViewModel {
  // Dependency injection
  final _statusChecker = locator<StatusCheckerService>();
  final _navigationService = locator<NavigationService>();
  final _inAppUpdateService = locator<InAppUpdateService>();
  final _authenticationService = locator<AuthenticationService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    final loggedIn = await _authenticationService.userLoggedIn();

    final firstTimeInstall = await _authenticationService.isFirstTimeInstall();

    await _inAppUpdate();

    if (firstTimeInstall) {
      await _navigationService.replaceWithWelcomeView();
    } else {
      if (loggedIn) {
        await _authenticationService.getUser();
        await _navigationService.replaceWithHomeView();
      } else {
        // Removable
        await _navigationService.replaceWithLoginView();
      }
    }
  }

  Future<void> _inAppUpdate() async {
    if (await _statusChecker.checkConnection()) {
      await _inAppUpdateService.checkForUpdate();
    }
  }
}
