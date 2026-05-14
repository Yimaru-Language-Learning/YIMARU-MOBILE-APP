import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/services/localization_service.dart';

import '../../../app/app.locator.dart';

class LanguageViewModel extends ReactiveViewModel {
  // Dependency injection
  final _navigationService = locator<NavigationService>();

  final _localizationService = locator<LocalizationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_localizationService];



  // Languages
  List<Map<String, dynamic>> get _languages => _localizationService.languages;

  List<Map<String, dynamic>> get languages => _languages;

  Map<String, dynamic> get _selectedLanguage => _localizationService.selectedLanguage;

  Map<String, dynamic> get selectedLanguage => _selectedLanguage;
  // Languages
  bool isSelectedLanguage(String title) =>
      _localizationService.isSelectedLanguage(title);

  Future<void> setSelectedLanguage(
          {required BuildContext context,
          required Map<String, dynamic> title}) async =>
      await _localizationService.setSelectedLanguage(
          context: context, title: title);

  // Navigation
  void pop() => _navigationService.back();
}
