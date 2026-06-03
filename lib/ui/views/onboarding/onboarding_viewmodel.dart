import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import '../../../app/app.locator.dart';
import '../../../models/field_option.dart';
import '../../../services/google_auth_service.dart';
import '../../../services/localization_service.dart';
import '../../../services/onboarding_service.dart';

class OnboardingViewModel extends ReactiveViewModel
    with FormStateHelper
    implements FormViewModel {
  // Dependency injection

  final _navigationService = locator<NavigationService>();

  final _googleAuthService = locator<GoogleAuthService>();

  final _onboardingService = locator<OnboardingService>();

  final _localizationService = locator<LocalizationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_googleAuthService, _localizationService];

  // Google user
  GoogleSignInAccount? get _googleUser => _googleAuthService.googleUser;

  GoogleSignInAccount? get googleUser => _googleUser;

  // Languages
  Map<String, dynamic> get _selectedLanguage =>
      _localizationService.selectedLanguage;

  Map<String, dynamic> get selectedLanguage => _selectedLanguage;

  // Navigation
  int _currentPage = 0;

  int get currentPage => _currentPage;

  int _previousPage = 0;

  int get previousPage => _previousPage;

  // Full name
  bool _focusFullName = false;

  bool get focusFullName => _focusFullName;

  // Educational background
  List<FieldOption> get _educationalBackgrounds =>
      _onboardingService.educationalBackgrounds;

  List<FieldOption> get educationalBackgrounds => _educationalBackgrounds;

  FieldOption? _selectedEducationalBackground;

  FieldOption? get selectedEducationalBackground =>
      _selectedEducationalBackground;

  // Gender
  final List<String> _gendersEn = [
    'Male',
    'Female',
  ];

  List<String> get gendersEn => _gendersEn;

  final List<String> _gendersAm = [
    'ወንድ',
    'ሴት',
  ];

  List<String> get gendersAm => _gendersAm;

  String? _selectedGender;

  String? get selectedGender => _selectedGender;

  // Age group
  List<FieldOption> get _ageGroups => _onboardingService.ageGroups;

  List<FieldOption> get ageGroups => _ageGroups;

  FieldOption? _selectedAgeGroup;

  FieldOption? get selectedAgeGroup => _selectedAgeGroup;

  // Occupation
  FieldOption? _selectedOccupation;

  FieldOption? get selectedOccupation => _selectedOccupation;

  // Country
  FieldOption? _selectedCountry;

  FieldOption? get selectedCountry => _selectedCountry;

  // Region
  bool _focusRegion = false;

  bool get focusRegion => _focusRegion;

  bool _dropdownRegion = false;

  bool get dropdownRegion => _dropdownRegion;

  FieldOption? _selectedRegion;

  FieldOption? get selectedRegion => _selectedRegion;

  // Learning goal
  FieldOption? _selectedLearningGoal;

  FieldOption? get selectedLearningGoal => _selectedLearningGoal;

  List<FieldOption> get _learningGoals => _onboardingService.learningGoals;

  List<FieldOption> get learningGoals => _learningGoals;

  // Learning reason

  FieldOption? _selectedLanguageGoal;

  FieldOption? get selectedLanguageGoal => _selectedLanguageGoal;

  List<FieldOption> get _languageGoals => _onboardingService.languageGoals;

  List<FieldOption> get languageGoals => _languageGoals;

  // Challenges
  FieldOption? _selectedChallenge;

  FieldOption? get selectedChallenge => _selectedChallenge;

  List<FieldOption> get _challenges => _onboardingService.challenges;

  List<FieldOption> get challenges => _challenges;

  // Topic
  FieldOption? _selectedTopic;

  FieldOption? get selectedTopic => _selectedTopic;

  List<FieldOption> get _topics => _onboardingService.topics;

  List<FieldOption> get topics => _topics;

  // User data
  final Map<String, dynamic> _userData = {};

  Map<String, dynamic> get userData => _userData;

  // Full name
  void setFullNameFocus() {
    _focusFullName = true;
    rebuildUi();
  }

  // Education background
  void setSelectedEducationalBackground(FieldOption value) {
    _selectedEducationalBackground = value;
    rebuildUi();
  }

  bool isSelectedEducationalBackground(FieldOption value) =>
      _selectedEducationalBackground == value;

  // Gender
  void setSelectedGender(String gender) {
    _selectedGender = gender;
    rebuildUi();
  }

  bool isSelectedGender(String value) => _selectedGender == value;

  // Age group
  void setSelectedAgeGroup(FieldOption value) {
    _selectedAgeGroup = value;

    rebuildUi();
  }

  bool isSelectedAgeGroup(FieldOption value) => _selectedAgeGroup == value;

  // Occupation
  List<FieldOption> get _occupations => _onboardingService.occupations;

  List<FieldOption> get occupations => _occupations;

  void setSelectedOccupation(FieldOption? value) {
    _selectedOccupation = value;
    rebuildUi();
  }

  // Country
  List<FieldOption> get _countries => _onboardingService.countries;

  List<FieldOption> get countries => _countries;

  void setSelectedCountry(FieldOption? value) {
    _selectedCountry = value;
    if (value?.code?.toLowerCase().trim() == 'et') {
      _dropdownRegion = true;
      _selectedRegion = _regions.firstWhere(
          (e) => e.code?.toLowerCase().trim().contains('addis_ababa') ?? false);
    } else {
      _dropdownRegion = false;
    }

    rebuildUi();
  }

  // Region
  List<FieldOption> get _regions => _onboardingService.regions;

  List<FieldOption> get regions => _regions;

  void setSelectedRegion(FieldOption? value) {
    _selectedRegion = value;
    rebuildUi();
  }

  void setRegionFocus() {
    _focusRegion = true;
    rebuildUi();
  }

  void unsetRegionFocus() {
    _focusRegion = false;
    rebuildUi();
  }

  // Learning goal
  void setSelectedLearningGoal(FieldOption value) {
    _selectedLearningGoal = value;
    rebuildUi();
  }

  bool isSelectedLearningGoal(FieldOption value) =>
      _selectedLearningGoal == value;

  // Language goal
  void setSelectedLanguageGoal(FieldOption value) {
    _selectedLanguageGoal = value;

    rebuildUi();
  }

  bool isSelectedLanguageGoal(FieldOption value) =>
      _selectedLanguageGoal == value;

  // Challenges

  void setSelectedChallenge(FieldOption value) {
    _selectedChallenge = value;
    rebuildUi();
  }

  bool isSelectedChallenge(FieldOption value) => _selectedChallenge == value;

  // Topics

  void setSelectedTopic(FieldOption value) {
    _selectedTopic = value;
    rebuildUi();
  }

  bool isSelectedTopic(FieldOption value) => _selectedTopic == value;

  // Add user data
  void addUserData(Map<String, dynamic> data) {
    _userData.addAll(data);
  }

  void clearUserData() {
    _userData.clear();
  }

  // Form reset

  // Reset full name form screen
  void resetFullNameFormScreen() {
    _focusFullName = false;
    rebuildUi();
  }

  // Reset gender form screen
  void resetGenderFormScreen() {
    _selectedGender = null;
    rebuildUi();
  }

  // Reset age group form screen
  void resetAgeGroupFormScreen() {
    _selectedAgeGroup = null;
    rebuildUi();
  }

  // Reset educational background form screen
  void resetEducationalBackgroundFormScreen() {
    _selectedEducationalBackground = null;
    rebuildUi();
  }

  // Reset occupation form screen
  void resetOccupationFormScreen() {
    _selectedOccupation = null;
    rebuildUi();
  }

  // Reset country region form screen
  void resetCountryRegionFormScreen() {
    _focusRegion = false;
    _selectedRegion = null;
    _selectedCountry = null;
    rebuildUi();
  }

  // Reset learning goal form screen
  void resetLearningGoalFormScreen() {
    _selectedLearningGoal = null;
    rebuildUi();
  }

  // Reset language goal form screen
  void resetLanguageGoalFormScreen() {
    _selectedLanguageGoal = null;
    rebuildUi();
  }

  // Reset challenge form screen
  void resetChallengeFormScreen() {
    _selectedChallenge = null;

    rebuildUi();
  }

  // Reset topic form screen
  void resetTopicFormScreen() {
    _selectedTopic = null;
    rebuildUi();
  }

  // In-app navigation
  void next({int? page}) async {
    if (page == null) {
      if (_previousPage != 0) {
        _currentPage = _previousPage;
      } else {
        _currentPage++;
      }
    } else {
      _previousPage = _currentPage;
      _currentPage = page;
    }
    rebuildUi();
  }

  void goBack() {
    if (_currentPage == 0) {
      _navigationService.back();
    } else {
      _currentPage--;

      rebuildUi();
    }
  }

  // Navigation
  Future<void> navigateToLanguage() async =>
      await _navigationService.navigateToLanguageView();

  Future<void> navigateToAssessment() async =>
      await _navigationService.navigateToAssessmentView(data: _userData);
}
