import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/listenable_practice_card.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/duolingo_practice_app_bar.dart';
import '../course_practice_viewmodel.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_view.form.dart';


class DuolingoListeningPractice2Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  final TextEditingController practiceController;

  const DuolingoListeningPractice2Question(
      {super.key, required this.practiceController});

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
        _buildQuestionWrapper(viewModel),
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(CoursePracticeViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
        ],
      );

  Widget _buildAppBar(CoursePracticeViewModel viewModel) =>
      DuolingoPracticeAppBar(
        title: 'Listening practice',
        onClose: () => viewModel.goTo(0),
      );

  Widget _buildQuestionWrapper(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildQuestionChildren(viewModel),
      );

  List<Widget> _buildQuestionChildren(CoursePracticeViewModel viewModel) => [
        _buildTitle(),
        verticalSpaceMedium,
        _buildQuestion(),
        verticalSpaceLarge,
        _buildLabel('1. Focus of the conference:'),
        verticalSpaceTiny,
        _buildPracticeFormField(viewModel),
        if (viewModel.hasPracticeValidationMessage &&
            viewModel.focusPractice)
          verticalSpaceTiny,
        if (viewModel.hasPracticeValidationMessage &&
            viewModel.focusPractice)
          _buildPracticeWrapper(viewModel),
        verticalSpaceSmall,
        _buildLabel('2. Number of presentations:'),
        verticalSpaceTiny,
        _buildPracticeFormField(viewModel),
        if (viewModel.hasPracticeValidationMessage &&
            viewModel.focusPractice)
          verticalSpaceTiny,
        if (viewModel.hasPracticeValidationMessage &&
            viewModel.focusPractice)
          _buildPracticeWrapper(viewModel),
        verticalSpaceSmall,
        _buildLabel('3. Keynote speaker’s field:'),
        verticalSpaceTiny,
        _buildPracticeFormField(viewModel),
        if (viewModel.hasPracticeValidationMessage &&
            viewModel.focusPractice)
          verticalSpaceTiny,
        if (viewModel.hasPracticeValidationMessage &&
            viewModel.focusPractice)
          _buildPracticeWrapper(viewModel),
      ];

  Widget _buildTitle() => Text(
        'Listen to the audio message and type your response.',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestion() => const ListenablePracticeCard();

  Widget _buildLabel(String question) => Text(
        question,
        style: style14MG400,
        textAlign: TextAlign.center,
      );

  Widget _buildPracticeFormField(CoursePracticeViewModel viewModel) =>
      TextFormField(
        controller: practiceController,
        onTap: viewModel.setPracticeFocus,
        decoration: inputDecoration(
            focus: true,
            hint: 'Start writing here...',
            filled: practiceController.text.isNotEmpty),
      );

  Widget _buildPracticeWrapper(CoursePracticeViewModel viewModel) =>
      viewModel.hasPracticeValidationMessage
          ? _buildPracticeValidator(viewModel)
          : Container();

  Widget _buildPracticeValidator(CoursePracticeViewModel viewModel) => Text(
        viewModel.practiceValidationMessage!,
        style: style12R700,
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
