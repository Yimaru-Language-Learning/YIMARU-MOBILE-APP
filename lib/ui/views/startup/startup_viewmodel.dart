import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/in_app_update_service.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';
import '../../../services/image_downloader_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';

class StartupViewModel extends ReactiveViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();
  final _statusChecker = locator<StatusCheckerService>();
  final _navigationService = locator<NavigationService>();
  final _inAppUpdateService = locator<InAppUpdateService>();
  final _authenticationService = locator<AuthenticationService>();
  final _imageDownloaderService = locator<ImageDownloaderService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_authenticationService];

  // Current user
  User? get _user => _authenticationService.user;

  User? get user => _user;


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
        await _getProfileStatus();
      } else {
        // Removable
        await _navigationService.replaceWithLoginView();
      }
    }
  }



  // Navigation
  Future<void> replaceWithFailure() async => await _navigationService
      .replaceWithFailureView(label: 'Check you internet connection');

  Future<void> replaceWithOnboarding() async =>
      await _navigationService.replaceWithOnboardingView();


  Future<void> replaceWithHome() async =>
      await _navigationService.replaceWithHomeView();

  // Remote api calls

  // In-app update
  Future<void> _inAppUpdate() async {
    if (await _statusChecker.checkConnection()) {
      await _inAppUpdateService.checkForUpdate();
    }
  }

  // Get profile status
  Future<void> _getProfileStatus() async {
    Map<String, dynamic> response = {};
    if (_user?.profileCompleted == null) {
      if (await _statusChecker.checkConnection()) {
        print('PATH: 1');
        response = await _apiService.getProfileStatus(_user);
      } else {
        print('PATH: 2');

        await Future.delayed(kDuration);
        await replaceWithFailure();
      }
    } else if (!(_user?.profileCompleted ?? false)) {
      print('PATH: 3');

      response = {'data': false, 'status': ResponseStatus.success};
    } else {
      print('PATH: 4');

      response = {'data': true, 'status': ResponseStatus.success};
    }
    if (response['status'] == ResponseStatus.success && !response['data']) {
      print('PATH: 5');

      await replaceWithOnboarding();
    } else if (response['status'] == ResponseStatus.success &&
        response['data']) {
      print('PATH: 6');

      await saveProfileStatus(response['data']);

      await _getProfileData();

      await replaceWithHome();
    }
  }

  // Save profile status
  Future<void> saveProfileStatus(bool value) async =>
      await _authenticationService.saveProfileStatus(value);

  // Get profile data
  Future<void> _getProfileData() async {
    if (!(_user?.userInfoLoaded ?? false)) {
      Map<String, dynamic> response = {};

      if (_user?.profileCompleted != null &&
          (_user?.profileCompleted ?? false)) {
        if (await _statusChecker.checkConnection()) {
          response = await _apiService.getProfileData(_user?.userId);

          if (response['status'] == ResponseStatus.success) {
            User user = response['data'] as User;

            await _authenticationService.saveUserData(user);

            String image =
                await _imageDownloaderService.downloader(user.profilePicture);

            await _authenticationService.saveProfilePicture(image);
          }
        } else {
          await replaceWithFailure();
        }
      }
    }
  }
}
