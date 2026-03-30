import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/duolingo_assessment_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/duolingo_assessment_question_card.dart';
import '../duolingo_viewmodel.dart';

class DuolingoWritingAssessment2Question
    extends ViewModelWidget<DuolingoViewModel> {
  final TextEditingController assessmentController;

  const DuolingoWritingAssessment2Question(
      {super.key, required this.assessmentController});

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
        _buildQuestionWrapper(viewModel),
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(DuolingoViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
        ],
      );

  Widget _buildAppBar(DuolingoViewModel viewModel) => DuolingoAssessmentAppBar(
        title: 'Writing Assessment',
        onClose: () => viewModel.goTo(0),
      );

  Widget _buildQuestionWrapper(DuolingoViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildQuestionChildren(viewModel),
      );

  List<Widget> _buildQuestionChildren(DuolingoViewModel viewModel) => [
        _buildTitle(),
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildQuestion(),
        verticalSpaceMedium,
      ];

  Widget _buildTitle() => Text(
        'Prepare to write about the topic below',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => Text(
        'You will write for 5 minutes',
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestion() => const DuolingoAssessmentQuestionCard(
      subtitle:
          'Describe a memorable experience from your school or work life and explain why it was meaningful to you.');

  Widget _buildContinueButtonWrapper(DuolingoViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(DuolingoViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Submit',
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: () => viewModel.goTo(3),
        backgroundColor: kcPrimaryColor,
      );
}
