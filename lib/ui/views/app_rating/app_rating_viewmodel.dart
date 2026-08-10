import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/field_option.dart';
import '../../../services/api_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';

class AppRatingViewModel extends FormViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // Review
  bool _focusReview = false;

  bool get focusReview => _focusReview;

  // Target
  String? _selectedTarget;

  String? get selectedTarget => _selectedTarget;

  // Rating
  String? _selectedRating;

  String? get selectedRating => _selectedRating;

  List<String> get _ratings => ['0', '1', '2', '3', '4', '5'];

  List<String> get ratings => _ratings;

  // Review
  void setReviewFocus() {
    _focusReview = true;
    rebuildUi();
  }

  // Target
  void setSelectedTarget(String value) {
    _selectedTarget = value;
    rebuildUi();
  }

  void setSelectedRating(String? value) {
    _selectedRating = value;
    rebuildUi();
  }

  // Navigation
  void pop() => _navigationService.back();

  // App review
  Future<void> rateApp(Map<String, dynamic> data) async =>
      await runBusyFuture(_rateApp(data), busyObject: StateObjects.appRating);

  Future<void> _rateApp(Map<String, dynamic> data) async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> response = await _apiService.rateApp(data);

      if (response['status'] == ResponseStatus.success) {
        pop();
        showSuccessToast(response['message']);
      } else {
        showErrorToast(response['message']);
      }
    }
  }
}
