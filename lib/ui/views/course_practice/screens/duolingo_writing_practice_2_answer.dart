import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/helper_functions.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/countdown_timer.dart';
import '../../../widgets/duolingo_practice_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/duolingo_practice_question_card.dart';
import '../course_practice_viewmodel.dart';
import '../course_practice_view.form.dart';

class DuolingoWritingPractice2Answer
    extends ViewModelWidget<CoursePracticeViewModel> {
  final TextEditingController practiceController;

  const DuolingoWritingPractice2Answer(
      {super.key, required this.practiceController});

  void _setButton(CoursePracticeViewModel viewModel) =>
      viewModel.setNextButton();

  Future<void> _cancel(CoursePracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.pop();
    viewModel.goBack();
  }

  Future<void> _showSheet(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: kcTransparent,
        builder: (cxt) => _buildSheet(viewModel),
      );

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(context: context, viewModel: viewModel),
      );

  Widget _buildScaffold(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      SafeArea(
          child:
              _buildBodyColumnWrapper(context: context, viewModel: viewModel));

  Widget _buildBodyColumnWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBodyColumn(context: context, viewModel: viewModel),
      );

  Widget _buildBodyColumn(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            _buildBodyColumnChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyColumnChildren(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      [
        _buildAppBarWrapper(context: context, viewModel: viewModel),
        _buildQuestionWrapper(viewModel),
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context: context, viewModel: viewModel),
          verticalSpaceSmall,
          _buildCountdownWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      DuolingoPracticeAppBar(
        onClose: () async =>
            await _showSheet(context: context, viewModel: viewModel),
        title:
            'Writing practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildCountdownWrapper(CoursePracticeViewModel viewModel) => Align(
      alignment: Alignment.centerRight, child: _buildCountdown(viewModel));

  Widget _buildCountdown(CoursePracticeViewModel viewModel) => CountdownTimer(
        onEnd: () => _setButton(viewModel),
        duration: viewModel.countdown,
      );

  Widget _buildQuestionWrapper(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildQuestionChildren(viewModel),
      );

  List<Widget> _buildQuestionChildren(CoursePracticeViewModel viewModel) => [
        _buildTitle(viewModel),
        verticalSpaceMedium,
        _buildQuestion(viewModel),
        verticalSpaceMedium,
        _buildPracticeFormField(viewModel),
        if (viewModel.hasPracticeValidationMessage && viewModel.focusPractice)
          verticalSpaceTiny,
        if (viewModel.hasPracticeValidationMessage && viewModel.focusPractice)
          _buildPracticeWrapper(viewModel),
      ];

  Widget _buildTitle(CoursePracticeViewModel viewModel) => Text(
        'Write about the topic below for ${getMinutes(viewModel.questions[viewModel.currentQuestion].dynamicPayload?.response?.last.value['seconds'])} minutes ${getSeconds(viewModel.questions[viewModel.currentQuestion].dynamicPayload?.response?.last.value['seconds'])} seconds.',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestion(CoursePracticeViewModel viewModel) =>
      DuolingoPracticeQuestionCard(
        title: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?.first.value,
      );

  Widget _buildPracticeFormField(CoursePracticeViewModel viewModel) =>
      TextFormField(
        maxLines: 5,
        maxLength: 250,
        controller: practiceController,
        enabled: !viewModel.buttonActive,
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
        backgroundColor: practiceController.text.isNotEmpty &&
                !viewModel.hasPracticeValidationMessage
            ? kcPrimaryColor
            : kcPrimaryColor.withValues(alpha: 0.1),
        onTap: practiceController.text.isNotEmpty &&
                !viewModel.hasPracticeValidationMessage
            ? viewModel.nextScreen
            : null,
      );
}
