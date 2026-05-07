import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/models/assessment_question.dart';
import 'package:yimaru_app/models/option.dart';
import 'package:yimaru_app/services/status_checker_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/assessment.dart';
import '../../../services/api_service.dart';
import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';

class AssessmentViewModel extends BaseViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();
  final _dialogService = locator<DialogService>();
  final _statusChecker = locator<StatusCheckerService>();
  final _navigationService = locator<NavigationService>();

  // In-app navigation
  int _currentPage = 0;

  int get currentPage => _currentPage;

  int _previousPage = 0;

  int get previousPage => _previousPage;

  final PageController _pageController = PageController();

  PageController get pageController => _pageController;

  // Assessment

  List<Assessment> _assessments = [];

  List<Assessment> get assessments => _assessments;

  Assessment? _currentAssessment;

  Assessment? get currentAssessment => _currentAssessment;

  int _currentQuestionIndex = 0;

  int get currentQuestionIndex => _currentQuestionIndex;

  int _currentAssessmentIndex = 0;

  int get currentAssessmentIndex => _currentAssessmentIndex;

  String? _proficiencyLevel;

  String? get proficiencyLevel => _proficiencyLevel;

  final Map<String, dynamic> _selectedAnswers = {};

  Map<String, dynamic> get selectedAnswers => _selectedAnswers;

  List<AssessmentQuestion> _assessmentQuestions = [];

  List<AssessmentQuestion> get assessmentQuestions => _assessmentQuestions;

  // User data
  final Map<String, dynamic> _userData = {};

  Map<String, dynamic> get userData => _userData;

  //  Assessment
  Future<void> setFirstAssessment() async {
    _proficiencyLevel = null;
    _selectedAnswers.clear();
    _currentQuestionIndex = 0;
    _pageController.jumpToPage(_currentQuestionIndex);
    _currentAssessment = assessments[currentAssessmentIndex];
    await getAssessmentQuestions(_currentAssessment?.id ?? 0);

    next();
  }

  Map<String, dynamic> evaluateAssessment() {
    bool levelPassed = canPassLevel();
    if (levelPassed) {
      return {'passed': true, 'level': _currentAssessment?.description};
    } else {
      return {'passed': false, 'level': _currentAssessment?.description};
    }
  }

  bool canPassLevel() {
    int count = 0;

    for (int i = 1; i <= _assessmentQuestions.length; i++) {
      final answer = _selectedAnswers[i.toString()];

      if (answer is Map<String, dynamic> && answer['correct'] == true) {
        count++;
      }
    }

    if (count >= (_currentAssessment?.passingScore ?? 0)) {
      return true;
    }

    return false;
  }

  bool isSelectedAnswer({required int question, required String answer}) {
    return _selectedAnswers[question.toString()]?['option'] == answer;
  }

  void setSelectedAnswer({required int question, required Option? option}) {
    bool correct = false;
    if (option?.isCorrect ?? false) {
      correct = true;
    }

    final data = {
      question.toString(): {
        'correct': correct,
        'option': option?.optionText,
        'answer': _assessmentQuestions[question - 1]
            .options
            ?.firstWhere((e) => e.isCorrect ?? false)
            .optionText
      }
    };

    _selectedAnswers.addAll(data);

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

  // Question navigation
  Future<void> nextQuestion() async {
    _currentQuestionIndex++;
    Map<String, dynamic> response = evaluateAssessment();

    if (_currentQuestionIndex == _assessmentQuestions.length) {
      _currentAssessmentIndex = _currentAssessmentIndex + 1;
      if (_currentAssessmentIndex == _assessments.length) {
        _proficiencyLevel = response['level'];
        next();
      } else {
        if (response['passed']) {
          _selectedAnswers.clear();
          _currentQuestionIndex = 0;
          _proficiencyLevel = response['level'];
          _currentAssessment = assessments[currentAssessmentIndex];
          await getAssessmentQuestions(_currentAssessment?.id ?? 0);
          _pageController.jumpToPage(_currentQuestionIndex);
        } else {
          _proficiencyLevel = response['level'];
          next();
        }
      }
    } else {
      _pageController.jumpToPage(_currentQuestionIndex);
    }

    rebuildUi();
  }

  void previousQuestion() {
    if (_currentQuestionIndex != 0) {
      _currentQuestionIndex--;
      _pageController.previousPage(
          duration: const Duration(microseconds: 100), curve: Curves.linear);
      rebuildUi();
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
      cancelTitle: 'No',
      buttonTitle: 'Yes',
      barrierDismissible: true,
      title: 'Abort Assessment',
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

  // Assessments
  Future<void> getAssessments() async => await runBusyFuture(_getAssessments(),
      busyObject: StateObjects.assessments);

  Future<void> _getAssessments() async {
    if (await _statusChecker.checkConnection()) {
      _assessments = await _apiService.getAssessments();
    }
  }

  Future<void> getAssessmentQuestions(int id) async =>
      await runBusyFuture(_getAssessmentQuestions(id),
          busyObject: StateObjects.assessmentQuestions);

  Future<void> _getAssessmentQuestions(int id) async {
    if (await _statusChecker.checkConnection()) {
      _assessmentQuestions = await _apiService.getAssessmentQuestions(id);
      _assessmentQuestions
          .removeWhere((question) => question.questionType != 'MCQ');
    }
  }
}
