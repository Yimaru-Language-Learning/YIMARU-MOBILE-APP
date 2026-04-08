import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

class SmartAuthService implements SmsRetriever {
  // Instance initialization
  final SmartAuth _smartAuth = SmartAuth.instance;

  // Dispose listener
  @override
  Future<void> dispose() => _smartAuth.removeUserConsentApiListener();

  // Get sms code
  @override
  Future<String?> getSmsCode() async {
    final res = await _smartAuth.getSmsWithUserConsentApi();
    if (res.hasData) {
      final code = res.requireData.code;

      return code;
    } else if (res.isCanceled) {
      return null;
    } else {
      return null;
    }
  }

  // Listen multiple sms
  @override
  bool get listenForMultipleSms => true;
}
