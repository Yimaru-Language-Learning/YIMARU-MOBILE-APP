import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/duolingo_assessment_app_bar.dart';
import '../../../widgets/speaking_assessment_review_section.dart';
import '../../../widgets/duolingo_assessment_question_card.dart';
import '../duolingo_viewmodel.dart';

class DuolingoSpeakingAssessment3Review
    extends ViewModelWidget<DuolingoViewModel> {
  const DuolingoSpeakingAssessment3Review({super.key});

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
        _buildQuestionIndenter(viewModel),
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
        ],
      );

  Widget _buildAppBar(DuolingoViewModel viewModel) => DuolingoAssessmentAppBar(
        title: 'Feedback',
        onClose: () => viewModel.goTo(0),
      );

  Widget _buildQuestionIndenter(DuolingoViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildQuestion(),
      );

  Widget _buildQuestion() => const DuolingoAssessmentQuestionCard(
        subtitle:
            'What values of beliefs did you learn from living in your hometown? How will your hometown influence your future?',
      );

  Widget _buildAssessmentReviewSection(DuolingoViewModel viewModel) =>
      SpeakingAssessmentReviewSection(onTap: () => viewModel.goTo(5));
}
