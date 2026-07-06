import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_constants.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/countdown_timer.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../course_practice_viewmodel.dart';

class IeltsSpeakingPractice8Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  const IeltsSpeakingPractice8Question({super.key});

  void _nextScreen(CoursePracticeViewModel viewModel) {
    FocusManager.instance.primaryFocus?.unfocus();
    viewModel.pop();
  }

  Future<void> _cancel(CoursePracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.resetValues();
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
        _buildQuestionExpandedWrapper(viewModel),
      ];

  Widget _buildAppBarWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context: context, viewModel: viewModel),
          verticalSpaceSmall,
        //  _buildCountdownWrapper(viewModel),
          verticalSpaceSmall,
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
            'Writing practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildTitle() => Text(
        'Diagram Labeling',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildCountdownWrapper(CoursePracticeViewModel viewModel) => Align(
      alignment: Alignment.centerRight, child: _buildCountdown(viewModel));

  Widget _buildCountdown(CoursePracticeViewModel viewModel) => CountdownTimer(
        onEnd: () => _nextScreen(viewModel),
        duration: viewModel.countdown,
      );

  Widget _buildQuestionExpandedWrapper(CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildQuestionScrollerWrapper(viewModel));

  Widget _buildQuestionScrollerWrapper(CoursePracticeViewModel viewModel) =>
      SingleChildScrollView(child: _buildQuestionWrapper(viewModel));

  Widget _buildQuestionWrapper(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildQuestionChildren(viewModel),
      );

  List<Widget> _buildQuestionChildren(CoursePracticeViewModel viewModel) => [
    verticalSpaceMedium,
    _buildQuestion(viewModel),
        verticalSpaceMedium,
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildAnswerColumns(viewModel),
        verticalSpaceLarge,
        _buildContinueButtonWrapper(viewModel),
      ];

  Widget _buildQuestion(CoursePracticeViewModel viewModel) => Container(
    padding: const EdgeInsets.all(15),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: kcPrimaryColor.withValues(alpha: 0.1)),
    ),
    child: _buildTopColumn(viewModel),
  );

  Widget _buildTopColumn(CoursePracticeViewModel viewModel) => ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: viewModel.questions[viewModel.currentQuestion].dynamicPayload
        ?.stimulus?.first.value['left'].length,
    itemBuilder: (context, index) => _buildColumnItemWrapper('${alphabet[index+1]}. ${viewModel
        .questions[viewModel.currentQuestion]
        .dynamicPayload
        ?.stimulus
        ?.first
        .value['left'][index]['text']}'),
  );




  Widget _buildSubtitle() => Text(
        'Label the diagram below. Write the letter from the second column for each answer',
        style: style14MG400,
      );

  Widget _buildAnswerColumns(CoursePracticeViewModel viewModel) => Row(
        children: _buildQuestionColumnChildren(viewModel),
      );

  List<Widget> _buildQuestionColumnChildren(
          CoursePracticeViewModel viewModel) =>
      [
        _buildColumnBottomExpandedWrapper(viewModel),
        _buildAnswerColumnWrapper(viewModel),
      ];


  Widget _buildColumnBottomExpandedWrapper(CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildColumnB(viewModel));





  Widget _buildColumnB(CoursePracticeViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?.first.value['right'].length,
        itemBuilder: (context, index) => _buildColumnItemWrapper('${index+1}. ${viewModel
            .questions[viewModel.currentQuestion]
            .dynamicPayload
            ?.stimulus
            ?.first
            .value['right'][index]['text']}'),
      );

  Widget _buildColumnItemWrapper(String title) => Container(
        height: 50,
        alignment: Alignment.center,
        child: _buildColumnItem(title),
      );

  Widget _buildColumnItem(String title) => Text(
        title,
        style: style14MG400,
      );





  Widget _buildAnswerColumnWrapper(CoursePracticeViewModel viewModel) =>
      Expanded(
        child: _buildAnswerColumn(viewModel),
      );

  Widget _buildAnswerColumn(CoursePracticeViewModel viewModel) =>
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => verticalSpaceSmall,
        itemCount: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?.first.value['left'].length,
        itemBuilder: (context, index) => _buildDropdown(
            viewModel: viewModel, question: (index + 1).toString()),
      );

  //Widget _build

  Widget _buildDropdown(
      {required String question,
        required CoursePracticeViewModel viewModel}) =>
      DropdownMenu<String?>(
        width: 100,
        textStyle: style14MG400,
        initialSelection: viewModel.selectedOption.isNotEmpty
            ? viewModel.selectedOption.containsKey(question)
            ? viewModel.selectedOption[question][question]
            : ''
            : '',
        onSelected: (value) {
          Map<String, dynamic> answer = {question: value};
          viewModel.setSelectedChoice(number: question, answer: answer);
        },
        showTrailingIcon: false,
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          border: dropdownBorder,
          enabledBorder: dropdownBorder,
          focusedBorder: dropdownBorder,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 5, vertical: 7.5),
        ),
        dropdownMenuEntries:
          alphabet.entries.take(viewModel.questions[viewModel.currentQuestion].dynamicPayload
              ?.stimulus?.first.value['left'].length)

            .map((k)=> k.value)
            .map(
              (option) => DropdownMenuEntry<String>(

            value: option,
            label: option,
          ),
        )
            .toList(),
      );

  Widget _buildContinueButtonWrapper(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(CoursePracticeViewModel viewModel) =>
      CustomElevatedButton(
          height: 55,
          borderRadius: 12,
          text: 'Submit Task',
          foregroundColor: kcWhite,
          backgroundColor: kcPrimaryColor,
          onTap: () => _nextScreen(viewModel));
}
