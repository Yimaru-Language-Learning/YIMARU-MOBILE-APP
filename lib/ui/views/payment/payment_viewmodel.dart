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

enum PaymentFailure { failed, uncertain }

enum CheckoutOutcome { success, failed, cancelled, uncertain }

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

  PaymentFailure? _startFailure;
  PaymentFailure? get startFailure => _startFailure;
  bool _failureDialogShown = false;
  bool _handlingCheckoutResult = false;

  bool claimFailureDialog() {
    if (_failureDialogShown) return false;
    _failureDialogShown = true;
    return true;
  }

  bool beginCheckoutResult() {
    if (_handlingCheckoutResult) return false;
    _handlingCheckoutResult = true;
    return true;
  }

  Future<CheckoutOutcome> checkCheckoutOutcome() async {
    final sessionId = _request?.sessionId;
    if (sessionId == null || sessionId.isEmpty) {
      return CheckoutOutcome.uncertain;
    }
    final status = await _apiService.getCheckoutPaymentStatus(sessionId);
    switch (status) {
      case 'SUCCESS':
        return CheckoutOutcome.success;
      case 'FAILED':
      case 'EXPIRED':
        return CheckoutOutcome.failed;
      case 'CANCELLED':
      case 'CANCELED':
        return CheckoutOutcome.cancelled;
      default:
        return CheckoutOutcome.uncertain;
    }
  }

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
    _request = null;
    _startFailure = null;
    _failureDialogShown = false;
    _handlingCheckoutResult = false;
    try {
      // No request has been sent when the connection check fails.
      if (!await _statusChecker.checkConnection()) {
        _startFailure = PaymentFailure.failed;
        return;
      }
      final response = method == PaymentMethod.sdk
          ? await _createLearnSubscriptionRequest(
              phone: phone, subscription: subscription)
          : await _createLearnDirectPaymentRequest(
              phone: phone, subscription: subscription);
      if (response['status'] == ResponseStatus.success) {
        final request = response['data'];
        final uri = request is LearnSubscriptionRequest
            ? Uri.tryParse(request.paymentUrl ?? '')
            : null;
        if (uri != null &&
            uri.host.isNotEmpty &&
            (uri.scheme == 'https' || uri.scheme == 'http')) {
          _request = request as LearnSubscriptionRequest;
        } else {
          // The payment may exist even though its checkout URL is missing.
          _startFailure = PaymentFailure.uncertain;
        }
      } else {
        _startFailure = response['payment_outcome_unknown'] == false
            ? PaymentFailure.failed
            : PaymentFailure.uncertain;
      }
    } catch (_) {
      _startFailure = PaymentFailure.uncertain;
    }
  }

  Future<Map<String, dynamic>> _createLearnSubscriptionRequest(
      {required String phone, required Subscription subscription}) async {
    Map<String, dynamic> data = {
      'provider': 'CHAPA',
      'phone': '251$phone',
      'email': 'test@gmail.com',
      'plan_id': subscription.id,
    };

    return _apiService.createSubscriptionRequest(data);
  }

// Create direct payment
  Future<void> createDirectPaymentRequest(
          {required String phone, required Subscription subscription}) async =>
      initiate(
          phone: phone, method: PaymentMethod.ussd, subscription: subscription);

  Future<Map<String, dynamic>> _createLearnDirectPaymentRequest(
      {required String phone, required Subscription subscription}) async {
    Map<String, dynamic> data = {
      'phone': '251$phone',
      'email': 'test@gmail.com',
      'plan_id': subscription.id,
      'payment_method': 'telebirr',
    };

    return _apiService.createDirectPaymentRequest(data);
  }

  // Update payment status
  Future<void> updatePaymentStatus() async => await runBusyFuture(
        _updatePaymentStatus(),
      );

  Future<void> _updatePaymentStatus() async {
    Map<String, dynamic> response = {};

    response = await _apiService.getProfileData(_user?.userId);

    if (response['status'] == ResponseStatus.success) {
      User user = response['data'] as User;
      await _authenticationService.saveUserData(user);
    }
  }
}
