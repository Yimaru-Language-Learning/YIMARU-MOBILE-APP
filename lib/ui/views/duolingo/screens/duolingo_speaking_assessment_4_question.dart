import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/dwarf_tile.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/duolingo_assessment_app_bar.dart';
import '../../../widgets/countdown_timer.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/speaking_indicator.dart';
import '../duolingo_viewmodel.dart';

class DuolingoSpeakingAssessment4Question
    extends ViewModelWidget<DuolingoViewModel> {
  const DuolingoSpeakingAssessment4Question({super.key});

  void _goTo(DuolingoViewModel viewModel) {
    viewModel.setSpeakingState();
    if (!viewModel.isSpeaking) {
      viewModel.goTo(3);
    }
  }

  @override
  Widget build(BuildContext context, DuolingoViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(DuolingoViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(DuolingoViewModel viewModel) =>
      SafeArea(child: _buildBodyColumnWrapper(viewModel));

  Widget _buildBodyColumnWrapper(DuolingoViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBodyColumn(viewModel),
      );

  Widget _buildBodyColumn(DuolingoViewModel viewModel) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(DuolingoViewModel viewModel) => [
        _buildAppBarWrapper(viewModel),
        _buildSpeakingIndicatorState(viewModel),
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(DuolingoViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceSmall,
        ],
      );

  Widget _buildAppBar(DuolingoViewModel viewModel) => DuolingoAssessmentAppBar(
        title: 'Speaking Assessment',
        onClose: () => viewModel.goTo(0),
      );

  Widget _buildSpeakingIndicatorState(DuolingoViewModel viewModel) =>
      viewModel.isSpeaking
          ? _buildSpeakingState()
          : _buildQuestionSectionWrapper(viewModel);

  Widget _buildQuestionSectionWrapper(DuolingoViewModel viewModel) => Column(
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

  Widget _buildContinueButtonWrapper(DuolingoViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(DuolingoViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Start',
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: () => _goTo(viewModel),
        backgroundColor: kcPrimaryColor,
      );
}
