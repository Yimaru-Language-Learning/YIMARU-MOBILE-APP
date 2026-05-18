import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/learn_subscription.dart';

import '../../../app/app.locator.dart';
import '../../../services/api_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class LearnSubscriptionViewModel extends FormViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // In-app navigation
  int _currentPage = 0;

  int get currentPage => _currentPage;

  // Phone number
  bool _focusPhoneNumber = false;

  bool get focusPhoneNumber => _focusPhoneNumber;

  // Learn subscriptions
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  List<LearnSubscription> _subscriptions = [];

  List<LearnSubscription> get subscriptions => _subscriptions;

  // Phone number
  void setPhoneNumberFocus() {
    _focusPhoneNumber = true;
    rebuildUi();
  }

  // In-app navigation

  void goBack() {
    if (_currentPage == 0) {
      _navigationService.back();
    } else {
      _currentPage--;
      rebuildUi();
    }
  }

  void next() async {
    _currentPage++;
    rebuildUi();
  }

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToArifPay(String phone) async {
    pop();
    await _navigationService.navigateToArifPayView(phone: phone);
  }

  //Learn subscriptions

  void setSelectedPricing(int index) {
    _selectedIndex = index;
    rebuildUi();
  }

  // Remote api call

  // Learn subscriptions
  Future<void> getLearnSubscriptions() async =>
      await runBusyFuture(_getLearnSubscriptions(),
          busyObject: StateObjects.learnSubscriptions);

  Future<void> _getLearnSubscriptions() async {
    if (await _statusChecker.checkConnection()) {
      _subscriptions = await _apiService.getLearnSubscriptions();
      _subscriptions = _subscriptions + _subscriptions + _subscriptions;
    }
  }
}
