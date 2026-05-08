import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/services/image_picker_service.dart';
import 'package:yimaru_app/services/phone_caller_service.dart';
import 'package:yimaru_app/ui/common/app_constants.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../app/app.locator.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';
import '../../../services/authentication_service.dart';
import '../../../services/google_auth_service.dart';
import '../../../services/status_checker_service.dart';
import '../../../services/url_launcher_service.dart';
import '../../common/app_colors.dart';

class ProfileViewModel extends ReactiveViewModel {
  final _apiService = locator<ApiService>();

  final _dialogService = locator<DialogService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  final _googleAuthService = locator<GoogleAuthService>();

  final _imagePickerService = locator<ImagePickerService>();

  final _authenticationService = locator<AuthenticationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_authenticationService];

  // Current user
  User? get _user => _authenticationService.user;

  User? get user => _user;

  // Image picker
  Future<void> openCamera() async =>
      runBusyFuture(_openCamera(), busyObject: StateObjects.profileImage);

  Future<void> _openCamera() async {
    String? image = await _imagePickerService.camera();
    pop();
    if (image != null) {
      await updateProfilePicture(image);
      await _authenticationService.saveProfilePicture(image);
    }
  }

  Future<void> openGallery() async =>
      runBusyFuture(_openGallery(), busyObject: StateObjects.profileImage);

  Future<void> _openGallery() async {
    String? image = await _imagePickerService.gallery();
    pop();
    if (image != null) {
      await updateProfilePicture(image);
      await _authenticationService.saveProfilePicture(image);
    }
  }

  // Dialog
  Future<bool?> showAbortDialog() async {
    DialogResponse? response = await _dialogService.showDialog(
      title: 'Logout',
      cancelTitle: 'No',
      buttonTitle: 'Yes',
      barrierDismissible: true,
      cancelTitleColor: kcDarkGrey,
      buttonTitleColor: kcPrimaryColor,
      description: 'Are you sure you want to quit?',
    );
    return response?.confirmed;
  }

  // Navigation
  void pop() => _navigationService.back();

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

  Future<void> navigateToLogin() async =>
      await _navigationService.clearStackAndShow(Routes.loginView);

  // Remote api call

  // Update profile
  Future<void> updateProfilePicture(String image) async =>
      await runBusyFuture(_updateProfilePicture(image));

  Future<void> _updateProfilePicture(String image) async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> data = {'profile_picture_url': image};
      await _apiService.updateProfileImage(data: data, userId: _user?.userId);
    }
  }

  Future<void> logout() async {
    bool? response = await showAbortDialog();
    if (response != null && response) {
      await _logout();
    }
  }

  Future<void> _logout() async {
    await _googleAuthService.logout();
    await _authenticationService.logout();
    await navigateToLogin();
  }
}
