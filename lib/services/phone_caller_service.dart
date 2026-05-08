import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class PhoneCallerService {
  Future<void> call(String phone) async =>
      await FlutterPhoneDirectCaller.callNumber(phone);
}
