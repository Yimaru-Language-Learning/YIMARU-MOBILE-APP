import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/api_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';

class InAppSupportViewModel extends FormViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // Subject
  bool _focusSubject = false;

  bool get focusSubject => _focusSubject;

  // Description
  bool _focusDescription = false;

  bool get focusDescription => _focusDescription;

  // Type
  bool _focusType = false;

  bool get focusType => _focusType;

  // Subject
  void setSubjectFocus() {
    _focusSubject = true;
    rebuildUi();
  }

  // Description
  void setDescriptionFocus() {
    _focusDescription = true;
    rebuildUi();
  }

  // Type
  void setTypeFocus() {
    _focusType = true;
    rebuildUi();
  }

  // Navigation
  void pop() => _navigationService.back();

  // My subscriptions
  Future<void> reportIssue(Map<String, dynamic> data) async =>
      await runBusyFuture(_reportIssue(data),
          busyObject: StateObjects.inAppSupport);

  Future<void> _reportIssue(Map<String, dynamic> data) async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> response = await _apiService.reportIssue(data);

      if (response['status'] == ResponseStatus.success) {
        pop();
        showSuccessToast(response['message']);
      } else {
        showErrorToast(response['message']);
      }
    }
  }
}
