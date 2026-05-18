import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/services/authentication_service.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';
import '../../../services/image_downloader_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class StartupViewModel extends ReactiveViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();
  final _statusChecker = locator<StatusCheckerService>();
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _imageDownloaderService = locator<ImageDownloaderService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_authenticationService];

  // Current user
  User? get _user => _authenticationService.user;

  User? get user => _user;

  // Main startup and navigation logic
  Future runStartupLogic() async {
    final loggedIn = await _authenticationService.userLoggedIn();

    final firstTimeInstall = await _authenticationService.isFirstTimeInstall();

    if (firstTimeInstall) {
      await _navigationService.replaceWithLandingView();
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

  Future<void> replaceWithHome() async =>
      await _navigationService.replaceWithHomeView();

  Future<void> replaceWithFailure() async =>
      await _navigationService.replaceWithFailureView(
          label: 'Check you internet connection',
          onTap: () async => await _getProfileStatus());

  Future<void> replaceWithOnboarding() async =>
      await _navigationService.replaceWithOnboardingView();

  // Remote api calls

  // Get profile status
  Future<void> _getProfileStatus() async {
    final bool? profileCompleted = _user?.profileCompleted;
    Map<String, dynamic> response = {};
    if (profileCompleted == null) {
      if (await _statusChecker.checkConnection()) {
        response = await _apiService.getProfileStatus(_user);
      } else {
        await replaceWithFailure();
      }
    } else if (!profileCompleted) {
      response = {'data': false, 'status': ResponseStatus.success};
    } else {
      response = {'data': true, 'status': ResponseStatus.success};
    }
    if (response['status'] == ResponseStatus.success && !response['data']) {
      await replaceWithOnboarding();
    } else if (response['status'] == ResponseStatus.success &&
        response['data']) {
      await saveProfileStatus(response['data']);

      await _getProfileData();

      await replaceWithHome();
    } else {
      await replaceWithFailure();
    }
  }

  // Save profile status
  Future<void> saveProfileStatus(bool value) async =>
      await _authenticationService.saveProfileStatus(value);

  // Get profile data
  Future<void> _getProfileData() async {
    bool? infoLoaded = _user?.userInfoLoaded ?? false;
    bool? profileCompleted = _user?.profileCompleted ?? false;

    if (!infoLoaded) {
      Map<String, dynamic> response = {};

      if (profileCompleted) {
        response = await _apiService.getProfileData(_user?.userId);

        if (response['status'] == ResponseStatus.success) {
          User user = response['data'] as User;

          await _authenticationService.saveUserData(user);

          String image =
              await _imageDownloaderService.downloader(user.profilePicture);

          await _authenticationService.saveProfilePicture(image);
        }
      }
    }
  }
}
