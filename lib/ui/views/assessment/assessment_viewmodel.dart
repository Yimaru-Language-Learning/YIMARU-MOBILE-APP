import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/models/assessment_question.dart';
import 'package:yimaru_app/models/option.dart';
import 'package:yimaru_app/models/practice_question.dart';
import 'package:yimaru_app/services/status_checker_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/assessment.dart';
import '../../../models/assessment_session.dart';
import '../../../models/proficiency_level.dart';
import '../../../services/api_service.dart';
import '../../../services/localization_service.dart';
import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';

class AssessmentViewModel extends ReactiveViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();
  final _dialogService = locator<DialogService>();
  final _statusChecker = locator<StatusCheckerService>();
  final _navigationService = locator<NavigationService>();
  final _localizationService = locator<LocalizationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_localizationService];

  // Languages
  Map<String, dynamic> get _selectedLanguage =>
      _localizationService.selectedLanguage;

  Map<String, dynamic> get selectedLanguage => _selectedLanguage;

  // In-app navigation
  int _currentPage = 0;

  int get currentPage => _currentPage;

  int _previousPage = 0;

  int get previousPage => _previousPage;

  final PageController _pageController = PageController();

  PageController get pageController => _pageController;

  // Assessment
  ProficiencyLevel? _proficiencyLevel;

  ProficiencyLevel? get proficiencyLevel => _proficiencyLevel;

  List<PracticeQuestion> _questions = [];

  List<PracticeQuestion> get questions => _questions;

  AssessmentSession? _session;

  AssessmentSession? get session => _session;

  int _currentQuestionIndex = 0;

  int get currentQuestionIndex => _currentQuestionIndex;

  final Map<String, dynamic> _answers = {};

  Map<String, dynamic> get answers => _answers;

  final Map<String, dynamic> _selectedAnswers = {};

  Map<String, dynamic> get selectedAnswers => _selectedAnswers;

  // User data
  final Map<String, dynamic> _userData = {};

  Map<String, dynamic> get userData => _userData;

  bool isSelectedAnswer({required int question, required String answer}) {
    return _selectedAnswers[question.toString()]?['option'] == answer;
  }

  void setSelectedAnswer(
      {required int question, required Map<String, dynamic> option}) {
    bool correct = false;
    if (option['is_correct']) {
      correct = true;
    }

    final selectedAnswer = {
      question.toString(): {
        'correct': correct,
        'option': option['option_text'],
        'answer': (_questions[question - 1]
                .dynamicPayload
                ?.response
                ?.first
                .value as List)
            .firstWhere((e) => e['is_correct'])['option_text']
      }
    };

    final answer = {
      question.toString(): {
        'selected_option_ids': [option['id']],
        'question_id': _questions[question - 1].id,
      }
    };

    _answers.addAll(answer);
    _selectedAnswers.addAll(selectedAnswer);
    rebuildUi();
  }

  // User data
  void clearUserData() {
    _userData.clear();
  }

  void addUserData(Map<String, dynamic> data) {
    _userData.addAll(data);
  }

  void initUserData(Map<String, dynamic> data) {
    clearUserData();
    _userData.addAll(data);
  }

  void reset() {
    _answers.clear();
    _proficiencyLevel = null;
    _selectedAnswers.clear();
    _currentQuestionIndex = 0;
    _pageController.jumpToPage(0);
  }

  // Question navigation
  Future<void> nextQuestion() async {
    _currentQuestionIndex++;
    _pageController.nextPage(
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 350),
    );
  }

  void previousQuestion() {
    if (_currentQuestionIndex != 0) {
      _currentQuestionIndex--;
      _pageController.previousPage(
          duration: const Duration(microseconds: 100), curve: Curves.linear);
    }
  }

  // In-app navigation

  void goBack() {
    if (_currentPage == 0) {
      _navigationService.back();
    } else if (_currentPage == 2) {
      _currentPage = 0;
      rebuildUi();
    } else if (_currentPage == 3) {
      if (_proficiencyLevel != null) {
        _currentPage--;
      } else {
        _currentPage = 0;
      }
      rebuildUi();
    }
  }

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

  // Dialog
  Future<void> abort() async {
    bool? response = await showAbortDialog();
    if (response != null && response) {
      next(page: 3);
    }
  }

  Future<bool?> showAbortDialog() async {
    DialogResponse? response = await _dialogService.showDialog(
      cancelTitle: LocaleKeys.no.tr(),
      buttonTitle: LocaleKeys.yes.tr(),
      barrierDismissible: true,
      title: LocaleKeys.abort_assessment.tr(),
      cancelTitleColor: kcDarkGrey,
      buttonTitleColor: kcPrimaryColor,
      description: 'Are you sure to abort the assessment ?',
    );
    return response?.confirmed;
  }

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToLanguage() async =>
      await _navigationService.navigateToLanguageView();

  Future<void> replaceWittStartUp() async =>
      await _navigationService.clearStackAndShow(Routes.startupView);

  // Remote api call

  // Complete profile
  Future<void> completeProfile() async =>
      await runBusyFuture(_completeProfile(),
          busyObject: StateObjects.profileCompletion);

  Future<void> _completeProfile() async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> response =
          await _apiService.completeProfile(_userData);
      if (response['status'] == ResponseStatus.success) {
        clearUserData();
        await replaceWittStartUp();
        showSuccessToast(response['message']);
      } else {
        showErrorToast(response['message']);
      }
    }
  }

  // Get assessments
  Future<void> getInitialAssessment() async =>
      await runBusyFuture(_getInitialAssessment(),
          busyObject: StateObjects.getAssessments);

  Future<void> _getInitialAssessment() async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> response = await _apiService.getAssessmentSession();

      if (response['status'] == ResponseStatus.success) {
        _session = response['data'] as AssessmentSession;

        _questions =
            await _apiService.getInitialAssessment(_session?.nextLevel ?? 'A1');
      }
    }
  }

  // Finish assessment
  Future<void> finishAssessment() async =>
      await runBusyFuture(_finishAssessment(),
          busyObject: StateObjects.finishAssessment);

  Future<void> _finishAssessment() async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> data = {
        'level': _session?.nextLevel,
        'answers': _answers.values.toList()
      };

      Map<String, dynamic> response = await _apiService.finishAssessment(data);

      if (ResponseStatus.success == response['status']) {
        _proficiencyLevel = response['data'];
        if (_proficiencyLevel?.passed ?? false) {
          if (_proficiencyLevel?.completed ?? false) {
            next();
          } else {
            reset();
            await getInitialAssessment();
          }
        } else {
          next();
        }
      } else {
        showErrorToast(response['message']);
        next(page: 3);
      }
    }
  }

  //Update knowledge level
  Future<void> updateKnowledgeLevel() async =>
      await runBusyFuture(_updateKnowledgeLevel(),
          busyObject: StateObjects.finishAssessment);

  Future<void> _updateKnowledgeLevel() async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> data = {'knowledge_level': _proficiencyLevel?.level};

      await _apiService.updateKnowledgeLevel(data);
    }
  }
}
