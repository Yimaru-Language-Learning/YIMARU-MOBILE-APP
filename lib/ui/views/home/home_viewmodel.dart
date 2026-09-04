import 'package:yimaru_app/app/app.bottomsheets.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/models/user.dart';
import 'package:yimaru_app/services/status_checker_service.dart';
import 'package:yimaru_app/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../services/authentication_service.dart';
import '../../../services/developer_mode_service.dart';
import '../../../services/in_app_notification_service.dart';

class HomeViewModel extends ReactiveViewModel {
  // Dependency injection
  final _statusChecker = locator<StatusCheckerService>();

  final _bottomSheetService = locator<BottomSheetService>();

  final _developerModeService = locator<DeveloperModeService>();

  final _authenticationService = locator<AuthenticationService>();

  final _inAppNotificationService = locator<InAppNotificationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [
        _authenticationService,
        _developerModeService,
        _inAppNotificationService
      ];

  // Current user
  User? get _user => _authenticationService.user;

  User? get user => _user;

  // Logout state
  StateObjects get _state => _authenticationService.state;

  StateObjects get state => _state;

  // Developer mode
  bool get isDeveloperModeEnabled => _developerModeService.developerModeEnabled;


  // Bottom navigation
  int _currentPage = 0;

  int get currentPage => _currentPage;


  // Bottom navigation
  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      title: ksHomeBottomSheetTitle,
      variant: BottomSheetType.notice,
      description: ksHomeBottomSheetDescription,
    );
  }

  void setCurrentIndex(int index) {
    _currentPage = index;
    rebuildUi();
  }

  // Remote api calls

  // In-app update
  Future<void> initInAppNotification() async {
    if (await _statusChecker.checkConnection()) {
      await _inAppNotificationService.getUnreadNotifications();
    }
  }
}
