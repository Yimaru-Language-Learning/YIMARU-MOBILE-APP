import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LocalizationService with ListenableServiceMixin {
  // Initialization
  localizationService() {
    listenToReactiveValues([_selectedLanguage]);
  }

  // Languages
  Map<String, dynamic> _selectedLanguage = {
    'code': 'EN',
    'language': 'English'
  };

  Map<String, dynamic> get selectedLanguage => _selectedLanguage;

  final List<Map<String, dynamic>> _languages = [
    {'code': 'አማ', 'language': 'አማርኛ'},
    {'code': 'EN', 'language': 'English'},
  ];

  List<Map<String, dynamic>> get languages => _languages;

  bool isSelectedLanguage(String title) =>
      _selectedLanguage['language'] == title;

  Future<void> setSelectedLanguage(
      {required BuildContext context,
      required Map<String, dynamic> title}) async {
    _selectedLanguage = title;

    if (title['code'] == 'አማ') {
      await setAmharicLanguage(context);
    } else {
      await setAmharicLanguage(context);
    }
    notifyListeners();
  }

  Future<void> setAmharicLanguage(BuildContext context) async =>
      await context.setLocale(const Locale('am'));

  Future<void> setEnglishLanguage(BuildContext context) async =>
      await context.setLocale(const Locale('en'));
}
