import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class CallSupportViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  void pop() => _navigationService.back();
}
