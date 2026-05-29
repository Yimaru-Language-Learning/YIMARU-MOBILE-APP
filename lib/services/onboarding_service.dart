import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/field_option.dart';

import '../app/app.locator.dart';
import 'api_service.dart';

class OnboardingService with ListenableServiceMixin {
  // Dependency injection
  final _apiService = locator<ApiService>();

  // Initialization
  learnService() {
    listenToReactiveValues([
      _topics,
      _regions,
      _ageGroups,
      _countries,
      _challenges,
      _occupations,
      _learningGoals,
      _languageGoals,
      _educationalBackgrounds
    ]);
  }

  // Topics
  List<FieldOption> _topics = [];

  List<FieldOption> get topics => _topics;

  // Regions
  List<FieldOption> _regions = [];

  List<FieldOption> get regions => _regions;

  // Age groups
  List<FieldOption> _ageGroups = [];

  List<FieldOption> get ageGroups => _ageGroups;

  // Countries
  List<FieldOption> _countries = [];

  List<FieldOption> get countries => _countries;

  // Challenges
  List<FieldOption> _challenges = [];

  List<FieldOption> get challenges => _challenges;

  // Occupations
  List<FieldOption> _occupations = [];

  List<FieldOption> get occupations => _occupations;

  // Learning goals
  List<FieldOption> _learningGoals = [];

  List<FieldOption> get learningGoals => _learningGoals;

  // Language goals
  List<FieldOption> _languageGoals = [];

  List<FieldOption> get languageGoals => _languageGoals;

  // Educational backgrounds
  List<FieldOption> _educationalBackgrounds = [];

  List<FieldOption> get educationalBackgrounds => _educationalBackgrounds;

  // Onboarding fields
  Future<bool> getOnboardingFields() async {
    _topics = await _apiService.getTopics();

    _ageGroups = await _apiService.getAgeGroups();

    _countries = await _apiService.getCountries();

    _occupations = await _apiService.getOccupations();

    _regions = await _apiService.getEthiopiaRegions();

    _learningGoals = await _apiService.getLearningGoals();

    _languageGoals = await _apiService.getLanguageGoals();

    _challenges = await _apiService.getLanguageChallenges();

    _educationalBackgrounds = await _apiService.getEducationalLevels();
    notifyListeners();

    if (_topics.isNotEmpty &&
        _ageGroups.isNotEmpty &&
        _countries.isNotEmpty &&
        _occupations.isNotEmpty &&
        _regions.isNotEmpty &&
        _learningGoals.isNotEmpty &&
        _challenges.isNotEmpty &&
        _educationalBackgrounds.isNotEmpty) {
      return true;
    }
    return false;
  }

  // Profile detail fields
  Future<void> getProfileDetailFields() async {
    _countries = await _apiService.getCountries();

    _occupations = await _apiService.getOccupations();

    _regions = await _apiService.getEthiopiaRegions();

    notifyListeners();
  }
}
