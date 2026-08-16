import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';

import '../../../app/app.locator.dart';

class SupportViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToFaqs() async =>
      await _navigationService.navigateToFaqsView();

  Future<void> navigateToAppRating() async =>
      await _navigationService.navigateToAppRatingView();

  Future<void> navigateToCallSupport() async =>
      await _navigationService.navigateToCallSupportView();

  Future<void> navigateToInAppSupport() async =>
      await _navigationService.navigateToInAppSupportView();

  Future<void> navigateToTelegramSupport() async =>
      await _navigationService.navigateToTelegramSupportView();
}
