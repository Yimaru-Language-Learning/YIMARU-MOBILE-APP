import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';

import '../../../app/app.locator.dart';
import '../../../services/authentication_service.dart';

class ProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final _authenticationService = locator<AuthenticationService>();

  Future<void> logOut() async {
    await _authenticationService.logOut();
    await _navigationService.replaceWithLoginView();
  }

  Future<void> navigateToProfileDetail() async =>
      await _navigationService.navigateToProfileDetailView();

  Future<void> navigateToDownloads() async =>
      await _navigationService.navigateToDownloadsView();

  Future<void> navigateToProgress() async =>
      await _navigationService.navigateToProgressView();

  Future<void> navigateToAccountPrivacy() async =>
      await _navigationService.navigateToAccountPrivacyView();

  Future<void> navigateToSupport() async =>
      await _navigationService.navigateToSupportView();
}
