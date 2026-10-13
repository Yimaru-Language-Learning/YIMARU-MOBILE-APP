import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';

import '../../../app/app.locator.dart';
import '../../../services/localization_service.dart';
import '../../../services/api_service.dart';
import '../../common/retryable_load.dart';

class AccountPrivacyViewModel extends ReactiveViewModel {
  static const reminderLoadKey = 'reminderPreferenceLoad';
  static const reminderSaveKey = 'reminderPreferenceSave';
  bool? remindersEnabled;
  Future<void> loadReminders() => runReadLoad(() async {
        final enabled = await locator<ApiService>().getReminderPreference();
        if (!disposed) remindersEnabled = enabled;
      }, busyObject: reminderLoadKey);
  Future<void> setReminders(bool enabled) => runReadLoad(() async {
        final saved =
            await locator<ApiService>().setReminderPreference(enabled);
        if (!disposed) remindersEnabled = saved;
      }, busyObject: reminderSaveKey);
  // Dependency injection
  final _navigationService = locator<NavigationService>();

  final _localizationService = locator<LocalizationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_localizationService];

  // Languages
  Map<String, dynamic> get _selectedLanguage =>
      _localizationService.selectedLanguage;

  Map<String, dynamic> get selectedLanguage => _selectedLanguage;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToTerms() async =>
      await _navigationService.navigateToTermsAndConditionsView();

  Future<void> navigateToLanguage() async =>
      await _navigationService.navigateToLanguageView();

  Future<void> navigateToPrivacyPolicy() async =>
      await _navigationService.navigateToPrivacyPolicyView();
}
