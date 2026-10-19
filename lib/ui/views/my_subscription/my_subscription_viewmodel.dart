import 'package:stacked/stacked.dart';
import '../../common/retryable_load.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/my_subscription.dart';
import '../../../services/api_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class MySubscriptionViewModel extends BaseViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  List<MySubscription> _subscriptions = [];

  List<MySubscription> get subscriptions => _subscriptions;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToSubscription(SubscriptionType type) async {
    await _navigationService.navigateToSubscriptionView(type: type);
  }

  // My subscriptions
  Future<void> getMySubscriptions() async =>
      await runReadLoad(() => _getMySubscriptions(),
          busyObject: StateObjects.mySubscriptions);

  Future<void> _getMySubscriptions() async {
    if (await _statusChecker.checkConnection()) {
      _subscriptions = await _apiService.getMySubscriptions();
    } else {
      throw StateError('No internet connection');
    }
  }
}
