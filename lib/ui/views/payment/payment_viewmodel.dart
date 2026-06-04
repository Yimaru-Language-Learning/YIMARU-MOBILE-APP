import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/learn_subscription.dart';
import '../../../models/learn_subscription_request.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';
import '../../../services/authentication_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class PaymentViewModel extends ReactiveViewModel {
  // Dependency injection

  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  final _authenticationService = locator<AuthenticationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_authenticationService];

  // Current user
  User? get _user => _authenticationService.user;

  User? get user => _user;

  // Learn subscription request
  LearnSubscriptionRequest? _request;

  LearnSubscriptionRequest? get request => _request;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> replaceWithHome() async =>
      await _navigationService.clearStackAndShow(Routes.homeView);

  // Remote api call

  // Learn subscription
  Future<void> createLearnSubscriptionRequest(
          {required String phone,
          required LearnSubscription subscription}) async =>
      await runBusyFuture(
          _createLearnSubscriptionRequest(
              phone: phone, subscription: subscription),
          busyObject: StateObjects.learnSubscription);

  Future<void> _createLearnSubscriptionRequest(
      {required String phone, required LearnSubscription subscription}) async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> data = {
        'provider': 'CHAPA',
        'phone': '251$phone',
        'email': 'test@gmail.com',
        'plan_id': subscription.id,
      };

      Map<String, dynamic> response =
          await _apiService.createSubscriptionRequest(data);

      if (response['status'] == ResponseStatus.success) {
        _request = response['data'];
      }
    }
  }

  // Update payment status
  Future<void> updatePaymentStatus() async =>
      await runBusyFuture(_updatePaymentStatus(),
          busyObject: StateObjects.learnSubscription);

  Future<void> _updatePaymentStatus() async {
    Map<String, dynamic> response = {};

    response = await _apiService.getProfileData(_user?.userId);

    if (response['status'] == ResponseStatus.success) {
      User user = response['data'] as User;
      await _authenticationService.saveUserData(user);
    }
  }
}
