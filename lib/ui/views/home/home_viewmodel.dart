import 'package:yimaru_app/app/app.bottomsheets.dart';
import 'package:yimaru_app/app/app.dialogs.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/user_model.dart';
import 'package:yimaru_app/services/status_checker_service.dart';
import 'package:yimaru_app/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/failure/failure_view.dart';
import 'package:yimaru_app/ui/views/login/login_view.dart';
import 'package:yimaru_app/ui/views/startup/startup_view.dart';

import '../../../services/api_service.dart';
import '../../../services/authentication_service.dart';
import '../../common/enmus.dart';

class HomeViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _dialogService = locator<DialogService>();
  final _statusChecker = locator<StatusCheckerService>();
  final _navigationService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _authenticationService = locator<AuthenticationService>();

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

  Future<void> saveFullName(String name) async {
    Map<String, dynamic> data = {
      'firstName': name,
    };
    await _authenticationService.saveFullName(data);
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
  Future<void> getProfileData() async =>
      await runBusyFuture<Map<String, dynamic>>(_getProfileData());

  Future<Map<String, dynamic>> _getProfileData() async {
    Map<String, dynamic> response = {};

    UserModel? user = await _authenticationService.getUser();

    if (user?.profileCompleted != null) {
      if (await _statusChecker.checkConnection()) {
        response = await _apiService.getProfileData(user?.userId);
        if (response['status'] == ResponseStatus.success) {
          Map<String, dynamic> data = {
            'firstName': response['data']['first_name']
          };
          await _authenticationService.saveFullName(data);
        }
      }
    }

    return response;
  }

  Future<void> getProfileStatus() async {
    Map<String, dynamic> response =
        await runBusyFuture<Map<String, dynamic>>(_getProfileStatus());
    if (response['status'] == ResponseStatus.success && !response['data']) {
      await replaceWithOnboarding();
    } else if (response['status'] == ResponseStatus.success &&
        response['data']) {
      await saveProfileStatus(response['data']);
    }
  }

  Future<Map<String, dynamic>> _getProfileStatus() async {
    Map<String, dynamic> response = {};

    UserModel? user = await _authenticationService.getUser();
    if (user?.profileCompleted == null) {
      if (await _statusChecker.checkConnection()) {
        response = await _apiService.getProfileStatus(user);
      } else {
        await replaceWithFailure();
      }
    } else {
      response = {'data': true, 'status': ResponseStatus.success};
    }

    return response;
  }
}
