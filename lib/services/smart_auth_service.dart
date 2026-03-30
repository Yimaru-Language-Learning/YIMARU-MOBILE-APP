import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

class SmartAuthService implements SmsRetriever {
  final SmartAuth _smartAuth = SmartAuth.instance;

  @override
  Future<void> dispose() => _smartAuth.removeUserConsentApiListener();

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

  @override
  bool get listenForMultipleSms => true;
}
