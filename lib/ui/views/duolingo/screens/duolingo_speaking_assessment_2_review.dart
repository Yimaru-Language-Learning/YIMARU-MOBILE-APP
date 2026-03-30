import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/countdown_timer.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/duolingo_assessment_app_bar.dart';
import '../../../widgets/speaking_assessment_review_section.dart';
import '../../../widgets/duolingo_assessment_question_card.dart';
import '../duolingo_viewmodel.dart';

class DuolingoSpeakingAssessment2Review
    extends ViewModelWidget<DuolingoViewModel> {
  const DuolingoSpeakingAssessment2Review({super.key});

  @override
  Widget build(BuildContext context, DuolingoViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(DuolingoViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(DuolingoViewModel viewModel) =>
      SafeArea(child: _buildBodyColumn(viewModel));

  Widget _buildBodyColumn(DuolingoViewModel viewModel) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(DuolingoViewModel viewModel) => [
        _buildAppBarIndenter(viewModel),
        _buildImageSectionIndenter(viewModel),
        _buildAssessmentReviewSection(viewModel)
      ];

  Widget _buildAppBarIndenter(DuolingoViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppBarWrapper(viewModel),
      );

  Widget _buildAppBarWrapper(DuolingoViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceSmall,
          _buildCountdownWrapper(),
        ],
      );

  Widget _buildAppBar(DuolingoViewModel viewModel) => DuolingoAssessmentAppBar(
        title: 'Feedback',
        onClose: () => viewModel.goTo(0),
      );

  Widget _buildImageSectionIndenter(DuolingoViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildImageSectionWrapper(viewModel),
      );

  Widget _buildImageSectionWrapper(DuolingoViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildImageSectionChildren(),
      );

  List<Widget> _buildImageSectionChildren() => [
        _buildTitle(),
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildQuestion(),
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

  Widget _buildQuestion() => const DuolingoAssessmentQuestionCard(
        title: 'How has growing up in your hometown influenced you?',
        subtitle:
            'What values of beliefs did you learn from living in your hometown? How will your hometown influence your future?',
      );

  Widget _buildAssessmentReviewSection(DuolingoViewModel viewModel) =>
      SpeakingAssessmentReviewSection(onTap: () => viewModel.goTo(5));
}
