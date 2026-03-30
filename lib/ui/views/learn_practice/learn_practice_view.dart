import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/finish_learn_practice_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/learn_practice_completion_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/learn_practice_result_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/learn_practices_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/interact_learn_practice_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/learn_practice_intro_screen.dart';
import 'package:yimaru_app/ui/views/learn_practice/screens/start_learn_practice_screen.dart';

import '../../common/app_colors.dart';
import '../../widgets/cancel_learn_practice_sheet.dart';
import 'learn_practice_viewmodel.dart';

class LearnPracticeView extends StackedView<LearnPracticeViewModel> {
  final String title;
  final String subtitle;
  final String buttonLabel;
  final List<Map<String, dynamic>> practices;

  const LearnPracticeView(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.practices,
      required this.buttonLabel})
      : super(key: key);

  Future<void> _cancel(LearnPracticeViewModel viewModel) async {
    viewModel.pop();
    viewModel.goTo(0);
    viewModel.stopRecording();
  }

  Future<void> _pop(
      {required BuildContext context,
      required LearnPracticeViewModel viewModel}) async {
    {
      if (viewModel.currentPage == 3) {
        await _showSheet(context: context, viewModel: viewModel);
      } else {
        viewModel.goBack();
      }
    }
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
          canPop: viewModel.currentPage == 0 ? true : false,
          onPopInvokedWithResult: (value, data) async =>
              await _pop(context: context, viewModel: viewModel),
          child: _buildScaffoldWrapper(viewModel));

  Widget _buildSheet(LearnPracticeViewModel viewModel) =>
      CancelLearnPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildScaffoldWrapper(LearnPracticeViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildBody(viewModel),
      );

  Widget _buildBody(LearnPracticeViewModel viewModel) =>
      IndexedStack(index: viewModel.currentPage, children: _buildScreens());

  List<Widget> _buildScreens() => [
        _buildLearnPracticesScreen(),
        _buildLearnPracticeIntroScreen(),
        _buildStartLearnPracticeScreen(),
        _buildInteractLearnPracticeScreen(),
        _buildFinishLearnPracticeScreen(),
        _buildLearnPracticeResultScreen(),
        _buildLearnPracticeCompletionScreen()
      ];

  Widget _buildLearnPracticesScreen() => LearnPracticesScreen(
        practices: practices,
      );

  Widget _buildLearnPracticeIntroScreen() => LearnPracticeIntroScreen(
        title: title,
        subtitle: subtitle,
        buttonLabel: buttonLabel,
      );

  Widget _buildStartLearnPracticeScreen() => const StartLearnPracticeScreen();

  Widget _buildInteractLearnPracticeScreen() =>
      const InteractLearnPracticeScreen();

  Widget _buildFinishLearnPracticeScreen() => const FinishLearnPracticeScreen();

  Widget _buildLearnPracticeResultScreen() => const LearnPracticeResultScreen();

  Widget _buildLearnPracticeCompletionScreen() =>
      const LearnPracticeCompletionScreen();
}
