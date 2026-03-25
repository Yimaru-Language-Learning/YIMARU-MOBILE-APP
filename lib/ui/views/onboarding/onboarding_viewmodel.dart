import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import '../../../app/app.locator.dart';
import '../../../services/google_auth_service.dart';

class OnboardingViewModel extends ReactiveViewModel
    with FormStateHelper
    implements FormViewModel {
  // Dependency injection

  final _navigationService = locator<NavigationService>();

  final _googleAuthService = locator<GoogleAuthService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_googleAuthService];

  // Google user
  GoogleSignInAccount? get _googleUser => _googleAuthService.googleUser;

  GoogleSignInAccount? get googleUser => _googleUser;

  // Navigation
  int _currentPage = 0;

  int get currentPage => _currentPage;

  int _previousPage = 0;

  int get previousPage => _previousPage;

  // Full name
  bool _focusFullName = false;

  bool get focusFullName => _focusFullName;

  // Educational background
  final List<String> _educationalBackgrounds = [
    'No formal education',
    'Primary school',
    'Secondary /High school',
    'College / Diploma',
    'Bachelor’s and above',
  ];

  List<String> get educationalBackgrounds => _educationalBackgrounds;

  String? _selectedEducationalBackground;

  String? get selectedEducationalBackground => _selectedEducationalBackground;

  // Gender
  final List<String> _genders = [
    'Male',
    'Female',
  ];

  List<String> get genders => _genders;

  String? _selectedGender;

  String? get selectedGender => _selectedGender;

  // Birthday
  String? _selectedBirthday;

  String? get selectedBirthday => _selectedBirthday;

  // Age group
  final List<Map<String, dynamic>> _ageGroups = [
    {
      'Under 13': 'UNDER_13',
    },
    {'13-17': '13_17'},
    {
      '18-24': '18_24',
    },
    {
      '25-34': '25_34',
    },
    {
      '35-44': '35_44',
    },
    {
      '45-54': '45_54',
    },
    {'55-Plus': '55_PLUS'},
  ];

  List<Map<String, dynamic>> get ageGroups => _ageGroups;

  Map<String, dynamic>? _selectedAgeGroup;

  Map<String, dynamic>? get selectedAgeGroup => _selectedAgeGroup;

  // Occupation
  bool _focusOccupation = false;

  bool get focusOccupation => _focusOccupation;

  // Country
  String _selectedCountry = 'Ethiopia';

  String get selectedCountry => _selectedCountry;

  // Country
  String _selectedRegion = 'Addis Ababa';

  String get selectedRegion => _selectedRegion;

  // Learning goal
  String? _selectedLearningGoal;

  String? get selectedLearningGoal => _selectedLearningGoal;

  final List<Map<String, dynamic>> _learningGoals = [
    {
      'icon': 0,
      'title': 'Learn to Speak English',
      'subtitle': 'I know some English, but i want to learn to speak it',
    },
    {
      'icon': 1,
      'title': 'Practice Speaking English',
      'subtitle': 'I already speak English, but I want more practice.',
    },
    {
      'icon': 2,
      'title': 'Skill-based Courses',
      'subtitle': 'I want courses for IELTS, TOEFL, Duolingo, or work.',
    },
  ];

  List<Map<String, dynamic>> get learningGoals => _learningGoals;

  // Learning reason
  bool _showLanguageGoalTextBox = false;

  bool get showLanguageGoalTextBox => _showLanguageGoalTextBox;

  bool _focusLanguageGoal = false;

  bool get focusLanguageGoal => _focusLanguageGoal;

  String? _selectedLanguageGoal;

  String? get selectedLanguageGoal => _selectedLanguageGoal;

  final List<String> _languageGoals = [
    'Speak confidently at work or school',
    'Travel or handle daily situations',
    'Connect with family or friends',
    'General skills expansion',
    'Other'
  ];

  List<String> get languageGoals => _languageGoals;

  // Challenges
  bool _showChallengeTextBox = false;

  bool get showChallengeTextBox => _showChallengeTextBox;

  bool _focusChallenge = false;

  bool get focusChallenge => _focusChallenge;

  String? _selectedChallenge;

  String? get selectedChallenge => _selectedChallenge;

  final List<String> _challenges = [
    'Pronunciation',
    'Finding words or grammar quickly',
    'Feeling nervous or lacking confidence',
    'Understanding accents or fast speech',
    'Other'
  ];

  List<String> get challenges => _challenges;

  // Topic
  bool _showTopicTextBox = false;

  bool get showTopicTextBox => _showTopicTextBox;

  bool _focusTopic = false;

  bool get focusTopic => _focusTopic;

  String? _selectedTopic;

  String? get selectedTopic => _selectedTopic;

  final List<String> _topics = [
    'Food & Cooking',
    ' Hobbies, Sports, Music',
    'Tech, News, Business',
    'Travel, Places, Culture',
    'Other'
  ];

  List<String> get topics => _topics;

  // Languages
  final List<Map<String, dynamic>> _languages = [
    {'code': 'አማ', 'language': 'አማርኛ'},
    {'code': 'EN', 'language': 'English'},
  ];

  List<Map<String, dynamic>> get languages => _languages;

  Map<String, dynamic> _selectedLanguage = {
    'code': 'EN',
    'language': 'English'
  };

  Map<String, dynamic> get selectedLanguage => _selectedLanguage;

  // User data
  final Map<String, dynamic> _userData = {};

  Map<String, dynamic> get userData => _userData;

  // Full name
  void setFullNameFocus() {
    _focusFullName = true;
    rebuildUi();
  }

  // Education background
  void setSelectedEducationalBackground(String value) {
    _selectedEducationalBackground = value;
    rebuildUi();
  }

  bool isSelectedEducationalBackground(String value) =>
      _selectedEducationalBackground == value;

  // Gender
  void setSelectedGender(String gender) {
    _selectedGender = gender;
    rebuildUi();
  }

  bool isSelectedGender(String value) => _selectedGender == value;

  // Birthday
  void setBirthday(String value) {
    _selectedBirthday = value;
    rebuildUi();
  }

  // Age group
  void setSelectedAgeGroup(Map<String, dynamic> value) {
    _selectedAgeGroup = value;

    rebuildUi();
  }

  bool isSelectedAgeGroup(Map<String, dynamic> value) =>
      _selectedAgeGroup == value;

  // Occupation
  void setOccupationFocus() {
    _focusOccupation = true;
    rebuildUi();
  }

  // Country
  List<String> getCountries() => ['Ethiopia', 'Other'];

  void setSelectedCountry(String value) {
    _selectedCountry = value;
    if (selectedCountry != 'Ethiopia') {
      _selectedRegion = 'Other';
    } else {
      _selectedRegion = 'Addis Ababa';
    }
    rebuildUi();
  }

  // Region
  List<String> getRegions(String country) {
    if (country == 'Ethiopia') {
      return [
        'Afar',
        'SNNPR',
        'Amhara',
        'Harari',
        'Oromia',
        'Sidama',
        'Somali',
        'Tigray',
        'Gambela',
        'Dire Dawa',
        'Addis Ababa',
        'Central Ethiopia',
        'Benishangul-Gumuz',
        'South West Ethiopia',
      ];
    } else {
      return ['Other'];
    }
  }

  void setSelectedRegion(String value) {
    _selectedRegion = value;
    rebuildUi();
  }

  // Learning goal
  void setSelectedLearningGoal(String value) {
    _selectedLearningGoal = value;
    rebuildUi();
  }

  bool isSelectedLearningGoal(String value) => _selectedLearningGoal == value;

  // Learning reason
  void setLanguageGoalFocus() {
    _focusLanguageGoal = true;
    rebuildUi();
  }

  void setSelectedLanguageGoal(String value) {
    _selectedLanguageGoal = value;
    if (value.toLowerCase() == 'other') {
      _showLanguageGoalTextBox = true;
    } else {
      if (_showLanguageGoalTextBox) {
        _showLanguageGoalTextBox = false;
        _focusLanguageGoal = false;
      }
    }
    rebuildUi();
  }

  bool isSelectedLanguageGoal(String value) => _selectedLanguageGoal == value;

  // Challenges
  void setChallengesFocus() {
    _focusChallenge = true;
    rebuildUi();
  }

  void setSelectedChallenge(String value) {
    _selectedChallenge = value;
    if (value.toLowerCase() == 'other') {
      _showChallengeTextBox = true;
    } else {
      if (_showChallengeTextBox) {
        _showChallengeTextBox = false;
        _focusChallenge = false;
      }
    }
    rebuildUi();
  }

  bool isSelectedChallenge(String value) => _selectedChallenge == value;

  // Topics
  void setTopicsFocus() {
    _focusTopic = true;
    rebuildUi();
  }

  void setSelectedTopic(String value) {
    _selectedTopic = value;
    if (value.toLowerCase() == 'other') {
      _showTopicTextBox = true;
    } else {
      if (_showTopicTextBox) {
        _showTopicTextBox = false;
        _focusTopic = false;
      }
    }
    rebuildUi();
  }

  bool isSelectedTopic(String value) => _selectedTopic == value;

  // Language
  void setSelectedLanguage(Map<String, dynamic> value) {
    _selectedLanguage = value;
    rebuildUi();
  }

  bool isSelectedLanguage(String value) =>
      _selectedLanguage['language'] == value;

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

  // Reset birthday form screen
  void resetBirthdayFormScreen() {
    _selectedBirthday = null;
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
    _focusOccupation = false;
    rebuildUi();
  }

  // Reset country region form screen
  void resetCountryRegionFormScreen() {
    _selectedCountry = 'Ethiopia';
    _selectedRegion = 'Addis Ababa';
    rebuildUi();
  }

  // Reset learning goal form screen
  void resetLearningGoalFormScreen() {
    _selectedLearningGoal = null;
    rebuildUi();
  }

  // Reset language goal form screen
  void resetLanguageGoalFormScreen() {
    _focusLanguageGoal = false;
    _selectedLanguageGoal = null;
    _showLanguageGoalTextBox = false;
    rebuildUi();
  }

  // Reset challenge form screen
  void resetChallengeFormScreen() {
    _focusChallenge = false;
    _selectedChallenge = null;
    _showChallengeTextBox = false;

    rebuildUi();
  }

  // Reset topic form screen
  void resetTopicFormScreen() {
    _focusTopic = false;
    _selectedTopic = null;
    _showTopicTextBox = false;
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

  Future<void> replaceWithHome() async =>
      await _navigationService.clearStackAndShow(Routes.homeView);
}
