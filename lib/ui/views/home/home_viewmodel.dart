import 'package:yimaru_app/app/app.bottomsheets.dart';
import 'package:yimaru_app/app/app.dialogs.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/user_model.dart';
import 'package:yimaru_app/services/status_checker_service.dart';
import 'package:yimaru_app/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/ui/views/failure/failure_view.dart';

import '../../../services/api_service.dart';
import '../../../services/authentication_service.dart';
import '../../../services/image_downloader_service.dart';
import '../../common/enmus.dart';

class HomeViewModel extends ReactiveViewModel {
  final _apiService = locator<ApiService>();
  final _dialogService = locator<DialogService>();
  final _statusChecker = locator<StatusCheckerService>();
  final _navigationService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _authenticationService = locator<AuthenticationService>();
  final _imageDownloaderService = locator<ImageDownloaderService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_authenticationService];

  // Current user
  UserModel? get _user => _authenticationService.user;

  UserModel? get user => _user;

  // Bottom navigation
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    rebuildUi();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      title: 'Stacked Rocks!',
      variant: DialogType.infoAlert,
      description: 'Give stacked  stars on Github',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      title: ksHomeBottomSheetTitle,
      variant: BottomSheetType.notice,
      description: ksHomeBottomSheetDescription,
    );
  }

  Future<void> saveProfileStatus(bool value) async =>
      await _authenticationService.saveProfileStatus(value);

  // Navigation
  Future<void> replaceWithFailure() async =>
      await _navigationService.clearStackAndShowView(
        const FailureView(label: 'Check your internet connection to proceed'),
      );

  Future<void> replaceWithOnboarding() async =>
      await _navigationService.replaceWithOnboardingView();

  // Remote api calls

  // Profile data
  Future<void> getProfileData() async => await runBusyFuture(_getProfileData());

  Future<void> _getProfileData() async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> response = {};

      if (_user?.profileCompleted != null &&
          (_user?.profileCompleted ?? false)) {
        if (await _statusChecker.checkConnection()) {
          response = await _apiService.getProfileData(_user?.userId);

          if (response['status'] == ResponseStatus.success) {
            UserModel user = response['data'] as UserModel;

            String image =
                await _imageDownloaderService.downloader(user.profilePicture);

            await _authenticationService.saveUserData(image: image, data: user);
          }
        }
      }
    }
  }

  // Profile status
  Future<void> getProfileStatus() async =>
      await runBusyFuture(_getProfileStatus());

  Future<void> _getProfileStatus() async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> response = {};

      if (_user?.profileCompleted == null) {
        if (await _statusChecker.checkConnection()) {
          response = await _apiService.getProfileStatus(_user);
        } else {
          await replaceWithFailure();
        }
      } else if (!(_user?.profileCompleted ?? false)) {
        response = {'data': false, 'status': ResponseStatus.success};
      } else {
        response = {'data': true, 'status': ResponseStatus.success};
      }

      if (response['status'] == ResponseStatus.success && !response['data']) {
        await replaceWithOnboarding();
      } else if (response['status'] == ResponseStatus.success &&
          response['data']) {
        await saveProfileStatus(response['data']);
      }
    }
  }
}
