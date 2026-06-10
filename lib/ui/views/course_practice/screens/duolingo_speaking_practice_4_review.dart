import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/duolingo_practice_app_bar.dart';
import '../../../widgets/speaking_practice_review_section.dart';
import '../../../widgets/dwarf_tile.dart';
import '../course_practice_viewmodel.dart';

class DuolingoSpeakingPractice4Review
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoSpeakingPractice4Review({super.key});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(CoursePracticeViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CoursePracticeViewModel viewModel) =>
      SafeArea(child: _buildBodyColumn(viewModel));

  Widget _buildBodyColumn(CoursePracticeViewModel viewModel) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(CoursePracticeViewModel viewModel) => [
        _buildAppBarIndenter(viewModel),
        _buildQuestionIndenter(viewModel),
        _buildAssessmentReviewSection(viewModel)
      ];

  Widget _buildAppBarIndenter(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppBarWrapper(viewModel),
      );

  Widget _buildAppBarWrapper(CoursePracticeViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceSmall,
        ],
      );

  Widget _buildAppBar(CoursePracticeViewModel viewModel) =>
      DuolingoPracticeAppBar(
        title: 'Feedback',
        onClose: () => viewModel.goTo(0),
      );

  Widget _buildQuestionIndenter(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildDwarfWrapper(),
      );

  Widget _buildDwarfWrapper() => DwarfTile(
        child: _buildQuestionWrapper(),
      );

  Widget _buildQuestionWrapper() => Expanded(child: _buildQuestion());

  Widget _buildQuestion() => Text(
        'What’s your favorite season and why?',
        style: style16DG600,
      );

  Widget _buildAssessmentReviewSection(CoursePracticeViewModel viewModel) =>
      SpeakingPracticeReviewSection(onTap: () => viewModel.goTo(5));
}
