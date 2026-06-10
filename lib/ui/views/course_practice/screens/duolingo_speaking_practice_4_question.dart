import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/dwarf_tile.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/duolingo_practice_app_bar.dart';
import '../../../widgets/countdown_timer.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/speaking_indicator.dart';
import '../course_practice_viewmodel.dart';

class DuolingoSpeakingPractice4Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoSpeakingPractice4Question({super.key});

  void _goTo(CoursePracticeViewModel viewModel) {
    viewModel.setSpeakingState();
    if (!viewModel.isSpeaking) {
      viewModel.goTo(3);
    }
  }

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(CoursePracticeViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CoursePracticeViewModel viewModel) =>
      SafeArea(child: _buildBodyColumnWrapper(viewModel));

  Widget _buildBodyColumnWrapper(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBodyColumn(viewModel),
      );

  Widget _buildBodyColumn(CoursePracticeViewModel viewModel) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(CoursePracticeViewModel viewModel) => [
        _buildAppBarWrapper(viewModel),
        _buildSpeakingIndicatorState(viewModel),
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(CoursePracticeViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceSmall,
        ],
      );

  Widget _buildAppBar(CoursePracticeViewModel viewModel) =>
      DuolingoPracticeAppBar(
        title: 'Speaking practice',
        onClose: () => viewModel.goTo(0),
      );

  Widget _buildSpeakingIndicatorState(CoursePracticeViewModel viewModel) =>
      // viewModel.isSpeaking
      //     ? _buildSpeakingState()
      //     :
      _buildQuestionSectionWrapper(viewModel);

  Widget _buildQuestionSectionWrapper(CoursePracticeViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildQuestionSectionChildren(),
      );

  List<Widget> _buildQuestionSectionChildren() => [
        _buildTitle(),
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildQuestion(),
      ];

  Widget _buildCountdownWrapper() =>
      const Align(alignment: Alignment.centerRight, child: CountdownTimer());

  Widget _buildTitle() => Text(
        'Prepare to have a conversation',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => Text(
        'You will listen to 3 questions and have 35 seconds to answer each',
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestion() => Image.asset('assets/icons/dwarf.png');

  Widget _buildSpeakingState() => DwarfTile(
        child: _buildSpeakingIndicator(),
      );

  Widget _buildSpeakingIndicator() => const SpeakingIndicator(
        size: 75,
      );

  Widget _buildContinueButtonWrapper(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(CoursePracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Start',
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: () => _goTo(viewModel),
        backgroundColor: kcPrimaryColor,
      );
}
