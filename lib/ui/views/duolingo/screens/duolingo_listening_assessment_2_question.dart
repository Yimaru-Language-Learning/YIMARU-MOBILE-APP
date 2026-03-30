import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/duolingo/duolingo_view.form.dart';
import 'package:yimaru_app/ui/widgets/listenable_assessment_card.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/duolingo_assessment_app_bar.dart';
import '../duolingo_viewmodel.dart';

class DuolingoListeningAssessment2Question
    extends ViewModelWidget<DuolingoViewModel> {
  final TextEditingController assessmentController;

  const DuolingoListeningAssessment2Question(
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
        title: 'Listening Assessment',
        onClose: () => viewModel.goTo(0),
      );

  Widget _buildQuestionWrapper(DuolingoViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildQuestionChildren(viewModel),
      );

  List<Widget> _buildQuestionChildren(DuolingoViewModel viewModel) => [
        _buildTitle(),
        verticalSpaceMedium,
        _buildQuestion(),
        verticalSpaceLarge,
        _buildLabel('1. Focus of the conference:'),
        verticalSpaceTiny,
        _buildAssessmentFormField(viewModel),
        if (viewModel.hasAssessmentValidationMessage &&
            viewModel.focusAssessment)
          verticalSpaceTiny,
        if (viewModel.hasAssessmentValidationMessage &&
            viewModel.focusAssessment)
          _buildAssessmentWrapper(viewModel),
        verticalSpaceSmall,
        _buildLabel('2. Number of presentations:'),
        verticalSpaceTiny,
        _buildAssessmentFormField(viewModel),
        if (viewModel.hasAssessmentValidationMessage &&
            viewModel.focusAssessment)
          verticalSpaceTiny,
        if (viewModel.hasAssessmentValidationMessage &&
            viewModel.focusAssessment)
          _buildAssessmentWrapper(viewModel),
        verticalSpaceSmall,
        _buildLabel('3. Keynote speaker’s field:'),
        verticalSpaceTiny,
        _buildAssessmentFormField(viewModel),
        if (viewModel.hasAssessmentValidationMessage &&
            viewModel.focusAssessment)
          verticalSpaceTiny,
        if (viewModel.hasAssessmentValidationMessage &&
            viewModel.focusAssessment)
          _buildAssessmentWrapper(viewModel),
      ];

  Widget _buildTitle() => Text(
        'Listen to the audio message and type your response.',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestion() => const ListenableAssessmentCard();

  Widget _buildLabel(String question) => Text(
        question,
        style: style14MG400,
        textAlign: TextAlign.center,
      );

  Widget _buildAssessmentFormField(DuolingoViewModel viewModel) =>
      TextFormField(
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
