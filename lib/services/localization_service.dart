import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/services/secure_storage_service.dart';

import '../app/app.locator.dart';

class LocalizationService with ListenableServiceMixin {
  // Dependency injection
  final _secureService = locator<SecureStorageService>();

  // Initialization
  localizationService() {
    listenToReactiveValues([_selectedLanguage]);
  }

  // Languages
  Map<String, dynamic> _selectedLanguage = {
    'code': 'en',
    'language': 'English'
  };

  Map<String, dynamic> get selectedLanguage => _selectedLanguage;

  final List<Map<String, dynamic>> _languages = [
    {'code': 'am', 'language': 'አማርኛ'},
    {'code': 'en', 'language': 'English'},
  ];

  List<Map<String, dynamic>> get languages => _languages;

  bool isSelectedLanguage(String title) =>
      _selectedLanguage['language'] == title;

  Future<void> setSelectedLanguage(
      {required BuildContext context,
      required Map<String, dynamic> title}) async {
    _selectedLanguage = title;

    if (title['code'] == 'am') {
      await setAmharicLanguage(context);
    } else {
      await setEnglishLanguage(context);
    }
    notifyListeners();
  }

  Future<void> loadSelectedLanguage() async {
    String language = await _secureService.getString('language') ?? 'en';

    if (language == 'en') {
      _selectedLanguage = {'code': 'en', 'language': 'English'};
    } else {
      _selectedLanguage = {'code': 'am', 'language': 'አማርኛ'};
    }
    notifyListeners();
  }

  Future<void> setAmharicLanguage(BuildContext context) async {
    await context.setLocale(const Locale('am'));
    await _secureService.setString('language', 'am');
    notifyListeners();
  }

  Future<void> setEnglishLanguage(BuildContext context) async {
    await context.setLocale(const Locale('en'));
    await _secureService.setString('language', 'en');
    notifyListeners();
  }
}
