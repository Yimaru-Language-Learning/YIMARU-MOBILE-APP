import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class TermsAndConditionsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Navigation
  void pop() => _navigationService.back();
}
