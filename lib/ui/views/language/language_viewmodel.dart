import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class LanguageViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

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

  // Languages
  void setSelectedLanguage(Map<String, dynamic> title) {
    _selectedLanguage = title;
    rebuildUi();
  }

  bool isSelectedLanguage(String title) =>
      _selectedLanguage['language'] == title;
  // Navigation
  void pop() => _navigationService.back();
}
