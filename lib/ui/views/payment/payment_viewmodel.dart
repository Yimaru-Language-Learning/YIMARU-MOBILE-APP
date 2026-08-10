import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/subscription.dart';
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

  Future<void> initiate(
          {required String phone,
          required PaymentMethod method,
          required Subscription subscription}) async =>
      await runBusyFuture(
          _initiate(phone: phone, method: method, subscription: subscription),
          busyObject: StateObjects.learnSubscription);

  Future<void> _initiate(
      {required String phone,
      required PaymentMethod method,
      required Subscription subscription}) async {
    if (method == PaymentMethod.sdk) {
      await _createLearnSubscriptionRequest(
          phone: phone, subscription: subscription);
    } else {
      await _createLearnDirectPaymentRequest(
          phone: phone, subscription: subscription);
    }
  }

  Future<void> _createLearnSubscriptionRequest(
      {required String phone, required Subscription subscription}) async {
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

// Create direct payment
  Future<void> createDirectPaymentRequest(
          {required String phone, required Subscription subscription}) async =>
      await runBusyFuture(
          _createLearnDirectPaymentRequest(
              phone: phone, subscription: subscription),
          busyObject: StateObjects.learnSubscription);

  Future<void> _createLearnDirectPaymentRequest(
      {required String phone, required Subscription subscription}) async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> data = {
        'phone': '251$phone',
        'email': 'test@gmail.com',
        'plan_id': subscription.id,
        'payment_method': 'telebirr',
      };

      Map<String, dynamic> response =
          await _apiService.createDirectPaymentRequest(data);

      if (response['status'] == ResponseStatus.success) {
        _request = response['data'];
      }
    }
  }

  // Update payment status
  Future<void> updatePaymentStatus() async =>
      await runBusyFuture(_updatePaymentStatus(),);

  Future<void> _updatePaymentStatus() async {
    Map<String, dynamic> response = {};

    response = await _apiService.getProfileData(_user?.userId);

    if (response['status'] == ResponseStatus.success) {
      User user = response['data'] as User;
      await _authenticationService.saveUserData(user);
    }
  }
}
