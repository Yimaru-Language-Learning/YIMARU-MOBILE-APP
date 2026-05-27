import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/learn_subscription_request.dart';
import '../../../services/api_service.dart';
import '../../../services/status_checker_service.dart';

class ArifPayViewModel extends BaseViewModel {
  // Dependency injection

  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // Learn subscription request
  LearnSubscriptionRequest? _request;

  LearnSubscriptionRequest? get request => _request;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> replaceWithHome() async =>
      await _navigationService.clearStackAndShow(Routes.homeView);

  // Remote api call

  // Learn subscription
  Future<void> createLearnSubscriptionRequest(String phone) async =>
      await runBusyFuture(_createLearnSubscriptionRequest(phone),
          busyObject: StateObjects.learnSubscription);

  Future<void> _createLearnSubscriptionRequest(String phone) async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> data = {
        'plan_id': 1,
        'phone': '251$phone',
        'provider': 'ARIFPAY',
        'email': 'test@gmail.com',
      };

      Map<String, dynamic> response =
          await _apiService.createSubscriptionRequest(data);

      if (response['status'] == ResponseStatus.success) {
        _request = response['data'];
      }
    }
  }

}
