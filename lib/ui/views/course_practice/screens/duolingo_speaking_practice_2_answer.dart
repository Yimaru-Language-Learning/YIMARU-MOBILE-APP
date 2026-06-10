import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/duolingo_practice_question_card.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/duolingo_practice_app_bar.dart';
import '../../../widgets/countdown_timer.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/speaking_indicator.dart';
import '../../../widgets/speaking_label.dart';
import '../course_practice_viewmodel.dart';

class DuolingoSpeakingPractice2Answer
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoSpeakingPractice2Answer({super.key});

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
        _buildSpeakingIndicatorWrapper(viewModel),
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(CoursePracticeViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceSmall,
          _buildCountdownWrapper(),
        ],
      );

  Widget _buildAppBar(CoursePracticeViewModel viewModel) =>
      DuolingoPracticeAppBar(
        title: 'Speaking practice',
        onClose: () => viewModel.goTo(0),
      );

  Widget _buildSpeakingIndicatorWrapper(CoursePracticeViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildSpeakingIndicatorChildren(),
      );

  List<Widget> _buildSpeakingIndicatorChildren() => [
        _buildTitle(),
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildQuestion(),
        verticalSpaceSmall,
        _buildSpeakerLabel(),
        verticalSpaceSmall,
        _buildSpeakingIndicator()
      ];

  Widget _buildCountdownWrapper() =>
      const Align(alignment: Alignment.centerRight, child: CountdownTimer());

  Widget _buildTitle() => Text(
        'Speak about the topic below',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => Text(
        'You will have 90 seconds to speak',
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestion() => const DuolingoPracticeQuestionCard(
        title: 'How has growing up in your hometown influenced you?',
        subtitle:
            'What values of beliefs did you learn from living in your hometown? How will your hometown influence your future?',
      );

  Widget _buildSpeakerLabel() => const SpeakingLabel();

  Widget _buildSpeakingIndicator() => const SpeakingIndicator(
        size: 25,
      );

  Widget _buildContinueButtonWrapper(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(CoursePracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Submit',
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: () => viewModel.goTo(4),
        backgroundColor: kcPrimaryColor,
      );
}
