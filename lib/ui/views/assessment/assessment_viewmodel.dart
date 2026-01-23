import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../app/app.dialogs.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/assessment.dart';
import '../../../models/user_model.dart';
import '../../../services/api_service.dart';
import '../../../services/authentication_service.dart';
import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../home/home_view.dart';

class AssessmentViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  int _currentPage = 0;

  int get currentPage => _currentPage;

  final PageController _pageController = PageController();

  PageController get pageController => _pageController;

  int _previousPage = 0;

  int get previousPage => _previousPage;

  // Assessment

  int _currentQuestion = 0;

  int get currentQuestion => _currentQuestion;

  ProficiencyLevels _proficiencyLevel = ProficiencyLevels.none;

  ProficiencyLevels get proficiencyLevel => _proficiencyLevel;

  List<Assessment> _assessments = [];

  List<Assessment> get assessments => _assessments;

  final Map<String, dynamic> _selectedAnswers = {};

  Map<String, dynamic> get selectedAnswers => _selectedAnswers;

  // User data
  final Map<String, dynamic> _userData = {};

  Map<String, dynamic> get userData => _userData;

  //  Assessment

  int countCorrectAnswersUntil(int untilQuestion) {
    int count = 0;

    for (int i = 1; i <= untilQuestion; i++) {
      final answer = _selectedAnswers[i.toString()];

      if (answer is Map<String, dynamic> && answer['correct'] == true) {
        count++;
      }
    }

    return count;
  }

  Map<String, dynamic> evaluateAssessment() {
    if (_currentQuestion == 5) {
      // A1
      final correctCount = countCorrectAnswersUntil(5);

      if (correctCount > 3) {
        return {'continue': true, 'level': ProficiencyLevels.a1};
      } else {
        return {'continue': false, 'level': ProficiencyLevels.a1};
      }
    } else if (_currentQuestion == 10) {
      // A2

      final correctCount = countCorrectAnswersUntil(10);

      if (correctCount > 3) {
        return {'continue': true, 'level': ProficiencyLevels.a2};
      } else {
        return {'continue': false, 'level': ProficiencyLevels.a2};
      }
    } else if (_currentQuestion == 16) {
      // B1
      final correctCount = countCorrectAnswersUntil(16);

      if (correctCount > 4) {
        return {'continue': true, 'level': ProficiencyLevels.b1};
      } else {
        return {'continue': false, 'level': ProficiencyLevels.b1};
      }
    } else if (_currentQuestion == 22) {
      final correctCount = countCorrectAnswersUntil(16);

      if (correctCount > 4) {
        return {'continue': true, 'level': ProficiencyLevels.b2};
      } else {
        return {'continue': false, 'level': ProficiencyLevels.b2};
      }
    } else {
      return {'continue': true, 'level': ProficiencyLevels.none};
    }
  }

  void setSelectedAnswer({required int question, required String option}) {
    bool correct = false;
    final generator = Random();
    int random = generator.nextInt(4);
    if (option == _assessments[question - 1].options?[random].optionText) {
      correct = true;
    }
    final data = {
      question.toString(): {
        'option': option,
        'correct': correct,
        'answer': _assessments[question - 1].options?[random].optionText
      }
    };

    _selectedAnswers.addAll(data);

    rebuildUi();
  }

  bool isSelectedAnswer({required int question, required String answer}) {
    return _selectedAnswers[question.toString()]?['option'] == answer;
  }

  Future<void> getAssessments() async {
    _assessments = await runBusyFuture<List<Assessment>>(_getAssessments());
  }

  Future<List<Assessment>> _getAssessments() async {
    List<Assessment> response = await _apiService.getAssessments();

    for (int i = 0; i < 6; i++) {
      final generator = Random();
      int random = generator.nextInt(15);
      response.add(response[random]);
    }

    return response;
  }

  // Add user data
  void initUserData(Map<String, dynamic> data) {
    clearUserData();
    _userData.addAll(data);
  }

  void addUserData(Map<String, dynamic> data) {
    _userData.addAll(data);
  }

  void clearUserData() {
    _userData.clear();
  }

  // Complete profile

  Future<void> completeProfile() async =>
      await runBusyFuture<Map<String, dynamic>>(_completeProfile());

  Future<Map<String, dynamic>> _completeProfile() async {
    UserModel? user = await _authenticationService.getUser();
    Map<String, dynamic> response =
        await _apiService.updateProfile(data: _userData, user: user);
    if (response['status'] == ResponseStatus.success) {
      showSuccessToast(response['message']);
      await replaceWithHome();
    } else {
      showErrorToast(response['message']);
    }
    return response;
  }

  // Navigation

  void nextQuestion() {
    _currentQuestion++;
    Map<String, dynamic> response = evaluateAssessment();

    if (response['level'] == ProficiencyLevels.none) {
      _pageController.jumpToPage(_currentQuestion);
    } else {
      if (response['continue']) {
        _pageController.jumpToPage(_currentQuestion);
      } else {
        _proficiencyLevel = response['level'];
        next();
      }
    }
    rebuildUi();
  }

  void previousQuestion() {
    if (_currentQuestion != 0) {
      _currentQuestion--;
      _pageController.previousPage(
          duration: const Duration(microseconds: 100), curve: Curves.linear);
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

  void pop() {
    if (_currentPage == 3 /*7*/) {
      _navigationService.back();
    } else if (_currentPage != 0 && _currentPage != 3) {
      _currentPage--;
      rebuildUi();
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

  Future<void> abort() async {
    bool? response = await showAbortDialog();
    if (response != null && response) {
      next(page: 3);
    }
  }

  Future<void> navigateToLanguage() async =>
      await _navigationService.navigateToLanguageView();

  Future<void> replaceWithHome() async =>
      await _navigationService.clearStackAndShowView(const HomeView());
}
