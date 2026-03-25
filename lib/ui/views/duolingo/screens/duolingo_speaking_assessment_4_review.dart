import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/duolingo_assessment_app_bar.dart';
import '../../../widgets/speaking_assessment_review_section.dart';
import '../../../widgets/dwarf_tile.dart';
import '../duolingo_viewmodel.dart';

class DuolingoSpeakingAssessment4Review
    extends ViewModelWidget<DuolingoViewModel> {
  const DuolingoSpeakingAssessment4Review({super.key});

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

  Widget _buildAssessmentReviewSection(DuolingoViewModel viewModel) =>
      SpeakingAssessmentReviewSection(onTap: () => viewModel.goTo(5));
}
