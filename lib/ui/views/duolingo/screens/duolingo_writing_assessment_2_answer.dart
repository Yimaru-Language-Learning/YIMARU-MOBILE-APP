import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/duolingo/duolingo_view.form.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/duolingo_assessment_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/duolingo_assessment_question_card.dart';
import '../duolingo_viewmodel.dart';

class DuolingoWritingAssessment2Answer
    extends ViewModelWidget<DuolingoViewModel> {
  final TextEditingController assessmentController;

  const DuolingoWritingAssessment2Answer(
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
        verticalSpaceMedium,
        _buildQuestion(),
        verticalSpaceMedium,
        _buildAssessmentFormField(viewModel),
        if (viewModel.hasAssessmentValidationMessage &&
            viewModel.focusAssessment)
          verticalSpaceTiny,
        if (viewModel.hasAssessmentValidationMessage &&
            viewModel.focusAssessment)
          _buildAssessmentWrapper(viewModel),
      ];

  Widget _buildTitle() => Text(
        'Write about the topic below for 5 minutes',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestion() => const DuolingoAssessmentQuestionCard(
      subtitle:
          'Describe a memorable experience from your school or work life and explain why it was meaningful to you.');

  Widget _buildAssessmentFormField(DuolingoViewModel viewModel) =>
      TextFormField(
        maxLines: 5,
        maxLength: 250,
        controller: assessmentController,
        onTap: viewModel.setAssessmentFocus,
        decoration: inputDecoration(
            focus: true,
            hint: 'Start writing here...',
            filled: assessmentController.text.isNotEmpty),
      );

  Widget _buildAssessmentWrapper(DuolingoViewModel viewModel) =>
      viewModel.hasAssessmentValidationMessage
          ? _buildAssessmentValidator(viewModel)
          : Container();

  Widget _buildAssessmentValidator(DuolingoViewModel viewModel) => Text(
        viewModel.assessmentValidationMessage!,
        style: style12R700,
      );

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
        onTap: () => viewModel.goTo(4),
        backgroundColor: kcPrimaryColor,
      );
}
