import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/countdown_timer.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/course_practice_question_card.dart';
import '../course_practice_viewmodel.dart';
import '../course_practice_view.form.dart';

class IeltsListeningPractice3Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  final TextEditingController practiceController;

  const IeltsListeningPractice3Question(
      {super.key, required this.practiceController});

  void _reset(CoursePracticeViewModel viewModel) {
    practiceController.clear();
    viewModel.resetValues();
  }

  void _nextScreen(
      {required BuildContext context,
      required CoursePracticeViewModel viewModel}) {
    FocusManager.instance.primaryFocus?.unfocus();
    _reset(viewModel);
    viewModel.nextQuestion(context);
  }

  Future<void> _cancel(CoursePracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    _reset(viewModel);
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
        _buildQuestionExpandedWrapper(context: context, viewModel: viewModel),
      ];

  Widget _buildAppBarWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context: context, viewModel: viewModel),
          verticalSpaceSmall,
          /*_buildCountdownWrapper(viewModel),
          verticalSpaceSmall,*/
          _buildTitle(),
          verticalSpaceSmall,
        ],
      );

  Widget _buildAppBar(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CoursePracticeAppBar(
        onClose: () async =>
            await _showSheet(context: context, viewModel: viewModel),
        title:
            'Listening practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildTitle() => Text(
        'Short Answer',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildCountdownWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Align(
          alignment: Alignment.centerRight,
          child: _buildCountdown(context: context, viewModel: viewModel));

  Widget _buildCountdown(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CountdownTimer(
        onEnd: () => _nextScreen(context: context, viewModel: viewModel),
        duration: viewModel.countdown,
      );
  Widget _buildQuestionExpandedWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Expanded(
          child: _buildQuestionScrollerWrapper(
              context: context, viewModel: viewModel));

  Widget _buildQuestionScrollerWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      SingleChildScrollView(
          child: _buildQuestionWrapper(context: context, viewModel: viewModel));

  Widget _buildQuestionWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children:
            _buildQuestionChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildQuestionChildren(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      [
        verticalSpaceMedium,
        _buildQuestion(viewModel),
        verticalSpaceMedium,
        _buildPracticeFormField(viewModel),
        if (viewModel.hasPracticeValidationMessage && viewModel.focusPractice)
          verticalSpaceTiny,
        if (viewModel.hasPracticeValidationMessage && viewModel.focusPractice)
          _buildPracticeWrapper(viewModel),
        verticalSpaceLarge,
        _buildContinueButtonWrapper(context: context, viewModel: viewModel)
      ];

  Widget _buildQuestion(CoursePracticeViewModel viewModel) =>
      CoursePracticeQuestionCard(
        subtitle:
            viewModel.questions[viewModel.currentQuestion].questionText ?? '',
      );

  Widget _buildPracticeFormField(CoursePracticeViewModel viewModel) =>
      TextFormField(
        maxLines: 5,
        maxLength: 250,
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

  Widget _buildContinueButtonWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(context: context, viewModel: viewModel),
      );

  Widget _buildContinueButton(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
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
            ? () => _nextScreen(context: context, viewModel: viewModel)
            : null,
      );
}
