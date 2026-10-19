import '../../common/app_constants.dart';

enum PaymentRedirect { none, success, failure, cancelled }

PaymentRedirect classifyPaymentRedirect(Uri? url) {
  if (url == null) return PaymentRedirect.none;
  final success = Uri.parse(kSuccessUrl);
  final failure = Uri.parse(kErrorUrl);
  // Do not interpret third-party URLs containing our URL as a callback.
  final trusted = [success, failure].any((callback) =>
      url.scheme == callback.scheme &&
      url.host == callback.host &&
      url.port == callback.port);
  if (!trusted) return PaymentRedirect.none;

  final status = url.queryParameters['status']?.toLowerCase();
  final callbackPath = url.path == success.path || url.path == failure.path;
  if (url.path == '/payment/cancel' ||
      url.path == '/payment/cancelled' ||
      (callbackPath && (status == 'cancelled' || status == 'canceled'))) {
    return PaymentRedirect.cancelled;
  }
  if (url.path == failure.path) return PaymentRedirect.failure;
  if (url.path == success.path) return PaymentRedirect.success;
  return PaymentRedirect.none;
}
