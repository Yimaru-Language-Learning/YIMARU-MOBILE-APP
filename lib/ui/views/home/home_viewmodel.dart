import 'package:yimaru_app/app/app.bottomsheets.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/user.dart';
import 'package:yimaru_app/services/status_checker_service.dart';
import 'package:yimaru_app/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/api_service.dart';
import '../../../services/authentication_service.dart';
import '../../../services/image_downloader_service.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';

class HomeViewModel extends ReactiveViewModel {

  final _bottomSheetService = locator<BottomSheetService>();
  final _authenticationService = locator<AuthenticationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_authenticationService];

  // Current user
  User? get _user => _authenticationService.user;

  User? get user => _user;

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






}
