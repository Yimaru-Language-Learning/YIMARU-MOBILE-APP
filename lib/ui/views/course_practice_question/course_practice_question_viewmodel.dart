import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/option.dart';
import '../../../models/assessment_question.dart';
import '../../../services/api_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/app_colors.dart';
import '../../common/enmus.dart';

class CoursePracticeQuestionViewModel extends FormViewModel {
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

  // Course practice questions
  bool _focusAnswer = false;

  bool get focusAnswer => _focusAnswer;

  AssessmentQuestion? _currentQuestion;

  AssessmentQuestion? get currentQuestion => _currentQuestion;

  List<AssessmentQuestion> _coursePracticeQuestions = [];

  List<AssessmentQuestion> get coursePracticeQuestions =>
      _coursePracticeQuestions;

  int _currentQuestionIndex = 0;

  int get currentQuestionIndex => _currentQuestionIndex;

  final Map<String, dynamic> _selectedAnswers = {};

  Map<String, dynamic> get selectedAnswers => _selectedAnswers;

  // Question navigation
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
      pop();
    } else {
      _currentPage = 0;
      rebuildUi();
    }
  }

  void goTo(int page) {
    _currentPage = page;
    rebuildUi();
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

  // Answer
  void reset() {
    _selectedAnswers.clear();
    rebuildUi();
  }

  void setAnswerFocus() {
    _focusAnswer = true;
    rebuildUi();
  }

  Future<void> abort() async {
    bool? response = await showAbortDialog();
    if (response != null && response) {
      next(page: 1);
    }
  }

  Future<bool?> showAbortDialog() async {
    DialogResponse? response = await _dialogService.showDialog(
      cancelTitle: 'No',
      buttonTitle: 'Yes',
      title: 'Abort Practice',
      barrierDismissible: true,
      cancelTitleColor: kcDarkGrey,
      buttonTitleColor: kcPrimaryColor,
      description: 'Are you sure to abort the practice ?',
    );
    return response?.confirmed;
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
        'answer': _currentQuestion?.options
            ?.firstWhere((e) => e.isCorrect ?? false)
            .optionText
      }
    };

    _selectedAnswers.addAll(data);

    rebuildUi();
  }

  // Navigation
  void pop() => _navigationService.back();

  // Remote api call

  // Question navigation
  Future<void> _nextQuestion(int id) async {
    _currentQuestionIndex++;

    if (_currentQuestionIndex == _coursePracticeQuestions.length) {
      next();
    } else {
      if (await _statusChecker.checkConnection()) {
        _currentQuestion = await _apiService.getCoursePracticeQuestion(id);
        _pageController.jumpToPage(_currentQuestionIndex);
      }
    }
  }

  Future<void> nextQuestion(int id) async =>
      await runBusyFuture(_nextQuestion(id),
          busyObject: StateObjects.coursePractice);

  // Course practice questions
  Future<void> getCoursePracticeQuestions(int id) async =>
      await runBusyFuture(_getCoursePracticeQuestions(id),
          busyObject: StateObjects.coursePracticeQuestions);

  Future<void> _getCoursePracticeQuestions(int id) async {
    if (await _statusChecker.checkConnection()) {
      _coursePracticeQuestions =
          await _apiService.getCoursePracticeQuestions(id);
      if (_coursePracticeQuestions.isNotEmpty) {
        _currentQuestion = await _apiService
            .getCoursePracticeQuestion(coursePracticeQuestions.first.id ?? 0);
      }
    }
  }

  // Course practice question
  Future<void> getCoursePracticeQuestion(int id) async =>
      await runBusyFuture(_getCoursePracticeQuestion(id),
          busyObject: StateObjects.coursePractice);

  Future<void> _getCoursePracticeQuestion(int id) async {
    if (await _statusChecker.checkConnection()) {
      _currentQuestion = await _apiService.getCoursePracticeQuestion(id);
    }
  }
}
