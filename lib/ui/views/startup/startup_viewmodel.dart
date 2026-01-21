import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/services/authentication_service.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    final loggedIn = await _authenticationService.userLoggedIn();
    final firstTimeInstall = await _authenticationService.isFirstTimeInstall();

    if (firstTimeInstall) {
      _navigationService.replaceWithWelcomeView();
    } else {
      if (loggedIn) {
        _navigationService.replaceWithHomeView();
      } else {
        _navigationService.replaceWithLoginView();
      }
    }
  }
}
