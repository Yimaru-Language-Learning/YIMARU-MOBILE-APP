import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/phone_caller_service.dart';
import '../../common/app_constants.dart';

class CallSupportViewModel extends BaseViewModel {
  // Dependency injection
  final _navigationService = locator<NavigationService>();

  final _phoneCallerService = locator<PhoneCallerService>();

  // Call support
  Future<void> callSupport() => _phoneCallerService.call(kPhoneSupport);

  // Navigation
  void pop() => _navigationService.back();
}
