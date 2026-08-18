import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/learn_practice_finish_screen.dart';
import 'package:yimaru_app/ui/widgets/practice_loading_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/learn_practice_appreciation_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/learn_practice_completion_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/learn_practice_description_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/learn_practice_result_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/learn_practice_questions_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/learn_practice_intro_screen.dart';
import 'package:yimaru_app/ui/widgets/page_loading_indicator.dart';

import '../../common/app_colors.dart';
import '../../widgets/cancel_practice_sheet.dart';
import 'learn_practice_viewmodel.dart';

class LearnPracticeView extends StackedView<LearnPracticeViewModel> {
  final int id;
  final String label;
  final String title;
  final String? level;
  final String subtitle;
  final LearnPractices practice;

  const LearnPracticeView({
    Key? key,
    this.level,
    required this.id,
    required this.label,
    required this.title,
    required this.practice,
    required this.subtitle,
  }) : super(key: key);

  String _getErrorMessages() {
    if (practice == LearnPractices.course) {
      return LocaleKeys.no_practice_available_course.tr();
    } else if (practice == LearnPractices.module) {
      return LocaleKeys.no_practice_available_module.tr();
    } else {
      return LocaleKeys.no_practice_available_lesson.tr();
    }
  }

  Future<void> _cancel(LearnPracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.pop();
    viewModel.pop();
  }

  Future<void> _showSheet(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: kcTransparent,
        builder: (_) => _buildSheet(viewModel),
      );

  @override
  void onViewModelReady(LearnPracticeViewModel viewModel) async {
    await viewModel.getLearnPractices(id: id, practice: practice);
    super.onViewModelReady(viewModel);
  }

  @override
  LearnPracticeViewModel viewModelBuilder(BuildContext context) =>
      LearnPracticeViewModel();

  @override
  Widget builder(
    BuildContext context,
    LearnPracticeViewModel viewModel,
    Widget? child,
  ) =>
      _buildPracticeScreensWrapper(context: context, viewModel: viewModel);

  Widget _buildPracticeScreensWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, data) {
            if (!didPop) {
              Future.microtask(() async =>
                  await _showSheet(context: context, viewModel: viewModel));
            }
          },
          child: _buildScaffoldWrapper(viewModel));

  Widget _buildSheet(LearnPracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildScaffoldWrapper(LearnPracticeViewModel viewModel) => Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kcBackgroundColor,
        body: _buildBodyState(viewModel),
      );

  Widget _buildBodyState(LearnPracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.learnPractice)
          ? const PageLoadingIndicator()
          : viewModel.practices.isEmpty || viewModel.questions.isEmpty
              ? _buildPageLoadingIndicator(viewModel)
              : _buildBody(viewModel);

  Widget _buildPageLoadingIndicator(LearnPracticeViewModel viewModel) =>
      PracticeLoadingScreen(
        message: _getErrorMessages(),
        isLoading: viewModel.busy(StateObjects.learnPractice),
        onRetry: () async =>
            await viewModel.getLearnPractices(id: id, practice: practice),
        onPop: viewModel.practices.isEmpty || viewModel.questions.isEmpty
            ? viewModel.pop
            : null,
        isEmpty: viewModel.practices.isEmpty || viewModel.questions.isEmpty,
      );

  Widget _buildBody(LearnPracticeViewModel viewModel) => IndexedStack(
      index: viewModel.currentPage, children: _buildScreens(viewModel));

  List<Widget> _buildScreens(LearnPracticeViewModel viewModel) => [
        _buildLearnPracticeIntroScreen(),
        if (practice != LearnPractices.lesson)
          _buildLearnPracticeElementsScreen(),
        _buildLearnPracticeQuestionsScreen(),
        _buildLearnPracticeAppreciationScreen(),
        _buildLearnPracticeResultScreen(),
        _buildLearnPracticeFinishScreen(),
        if (practice == LearnPractices.course)
          _buildLearnPracticeCompletionScreen()
      ];

  Widget _buildLearnPracticeIntroScreen() => LearnPracticeIntroScreen(
        level: level,
        title: title,
        label: label,
        practice: practice,
        subtitle: subtitle,
      );

  Widget _buildLearnPracticeElementsScreen() =>
      const LearnPracticeDescriptionScreen();

  Widget _buildLearnPracticeQuestionsScreen() =>
      const LearnPracticeQuestionsScreen();

  Widget _buildLearnPracticeAppreciationScreen() =>
      const LearnPracticeAppreciationScreen();

  Widget _buildLearnPracticeResultScreen() =>
      LearnPracticeResultScreen(practice: practice);

  Widget _buildLearnPracticeFinishScreen() => const LearnPracticeFinishScreen();

  Widget _buildLearnPracticeCompletionScreen() =>
      LearnPracticeCompletionScreen(level: level ?? '');
}
