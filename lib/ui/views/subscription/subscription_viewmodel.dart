import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/subscription.dart';
import '../../../services/api_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class SubscriptionViewModel extends FormViewModel {
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

  Subscription? _selectedSubscription;

  Subscription? get selectedSubscription => _selectedSubscription;

  List<Subscription> _subscriptions = [];

  List<Subscription> get subscriptions => _subscriptions;

  // Phone number
  void setPhoneNumberFocus() {
    _focusPhoneNumber = true;
    rebuildUi();
  }

  //Learn subscriptions

  void setSelectedPricing(int index) {
    _selectedIndex = index;
    _selectedSubscription = _subscriptions[index];
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

  Future<void> navigateToPayment(
      {required String phone,
      required PaymentMethod method,
      required Subscription? subscription}) async {
    pop();
    await _navigationService.navigateToPaymentView(
        phone: phone,
        method: method,
        subscription: subscription ?? _subscriptions[0]);
  }

  // Remote api call

  // Subscriptions
  Future<void> getSubscriptions(SubscriptionType type) async =>
      await runBusyFuture(_getSubscriptions(type),
          busyObject: StateObjects.subscriptions);

  Future<void> _getSubscriptions(SubscriptionType type) async {
    print(type);
    if (await _statusChecker.checkConnection()) {
      if (type == SubscriptionType.learn) {
        _subscriptions = await _apiService.getSubscriptions('LEARN_ENGLISH');
      } else if (type == SubscriptionType.duolingo) {
        _subscriptions = await _apiService.getSubscriptions('DUOLINGO');
      } else {
        _subscriptions = await _apiService.getSubscriptions('IELTS');
      }
    }
  }
}
