import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_constants.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/enmus.dart';
import '../../../../common/ui_helpers.dart';
import '../../../../widgets/cancel_practice_sheet.dart';
import '../../../../widgets/countdown_timer.dart';
import '../../../../widgets/course_practice_app_bar.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/ielts_practice_review_section.dart';
import '../../../../widgets/page_loading_indicator.dart';
import '../../course_practice_viewmodel.dart';

class IeltsListeningPractice5Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  const IeltsListeningPractice5Question({super.key});

  void _setShowAnswer(CoursePracticeViewModel viewModel) {
    viewModel.setShowAnswer();
  }

  Future<void> _nextScreen(
      {required BuildContext context,
      required CoursePracticeViewModel viewModel}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (viewModel.showAnswer) {
      viewModel.clearAnswer();
      if (viewModel.currentQuestion == viewModel.questions.length - 1) {
        viewModel.setSectionEnd(true);
        viewModel.nextScreen();
      } else {
        if (viewModel
                .questions[viewModel.currentQuestion + 1].stimulusBlockKey ==
            null) {
          viewModel.setSectionEnd(true);
          viewModel.nextScreen();
        } else {
          viewModel.nextQuestion(context);
        }
      }
    } else {
      _setShowAnswer(viewModel);
      for (int i = 0;
          i <
              (viewModel.questions[viewModel.currentQuestion].dynamicPayload
                      ?.response?[1].value['pairs'] as List)
                  .length;
          i++) {
        await viewModel.setListeningAnswer(
          sample: (viewModel.questions[viewModel.currentQuestion].dynamicPayload
                  ?.stimulus?[1].value['right'] as List)
              .firstWhere((e) =>
                  e['id'] ==
                  (viewModel.questions[viewModel.currentQuestion].dynamicPayload
                      ?.response?[1].value['pairs'] as List)[i]['right_id'])['text'],
        );
      }
    }
  }

  Future<void> _cancel(CoursePracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    //viewModel.resetValues();
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
        body: _buildScaffoldStack(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldStack(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Stack(
        children: [
          _buildScaffold(context: context, viewModel: viewModel),
          _buildBodyState(viewModel)
        ],
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
          _buildCountdownWrapper(context: context, viewModel: viewModel),
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
            'Listening practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildTitle() => Text(
        'Map/Plan/Diagram Completion',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildCountdownWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Align(
          alignment: Alignment.centerRight,
          child: _buildCountdownState(context: context, viewModel: viewModel));

  Widget _buildCountdownState(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      viewModel.busy(StateObjects.coursePractice)
          ? const CountdownTimer(time: '00:00')
          : _buildCountdown(context: context, viewModel: viewModel);

  Widget _buildCountdown(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CountdownTimer(
        duration: viewModel.countdown,
        key: ValueKey(viewModel.countdown),
        onEnd: ()async =>await  _nextScreen(context: context, viewModel: viewModel),
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
        _buildImageContainer(viewModel),
        verticalSpaceMedium,
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildQuestionColumns(viewModel),
        verticalSpaceLarge,
        _buildContinueButtonState(context: context, viewModel: viewModel),
      ];

  Widget _buildImageContainer(CoursePracticeViewModel viewModel) => SizedBox(
        width: 250,
        height: 300,
        child: _buildImageWrapper(viewModel),
      );

  Widget _buildImageWrapper(CoursePracticeViewModel viewModel) => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: _buildImage(viewModel),
      );

  Widget _buildImage(CoursePracticeViewModel viewModel) => CachedNetworkImage(
        fit: BoxFit.fill,
        width: double.maxFinite,
        imageUrl: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?.first.value,
      );

  Widget _buildSubtitle() => Text(
        'Label the map below. Write the correct letter, A-H, next to Questions 31-36',
        style: style14MG400,
      );

  Widget _buildQuestionColumns(CoursePracticeViewModel viewModel) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildQuestionColumnChildren(viewModel),
      );

  List<Widget> _buildQuestionColumnChildren(
          CoursePracticeViewModel viewModel) =>
      [
        _buildColumnAExpandedWrapper(viewModel),
        _buildAnswerColumnWrapper(viewModel),
      ];

  Widget _buildColumnAExpandedWrapper(CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildColumnA(viewModel));

  Widget _buildColumnA(CoursePracticeViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?.last.value['left'].length,
        itemBuilder: (context, index) => _buildColumnItemWrapper(
            '${index + 1}. ${viewModel.questions[viewModel.currentQuestion].dynamicPayload?.stimulus?.last.value['left'][index]['text']}'),
      );

  Widget _buildAnswerColumnWrapper(CoursePracticeViewModel viewModel) =>
      Expanded(
        child: _buildAnswerColumn(viewModel),
      );

  Widget _buildAnswerColumn(CoursePracticeViewModel viewModel) =>
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => SizedBox(height: 20),
        itemCount: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?.last.value['left'].length,
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
              const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        ),
        dropdownMenuEntries: (viewModel.questions[viewModel.currentQuestion]
                .dynamicPayload?.stimulus?.last.value['right'] as List)
            .map((e) => e['text'])
            .map(
              (option) => DropdownMenuEntry<String>(
                value: option,
                label: option,
              ),
            )
            .toList(),
      );

  Widget _buildColumnItemWrapper(String title) => SizedBox(
        height: 50,
        child: _buildColumnItem(title),
      );

  Widget _buildColumnItem(String title) => Text(
        title,
        style: style14MG400,
      );


  Widget _buildContinueButtonState(
      {required BuildContext context,
        required CoursePracticeViewModel viewModel}) =>
      viewModel.showAnswer
          ? _buildReviewSection(context: context,viewModel: viewModel)
          : _buildContinueButtonWrapper(context: context, viewModel: viewModel);

  Widget _buildReviewSection(       {required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      IeltsPracticeReviewSection(review: viewModel.answers,onTap: ()async =>await  _nextScreen(context: context, viewModel: viewModel),);

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
        backgroundColor: kcPrimaryColor,
        onTap: ()async =>await  _nextScreen(context: context, viewModel: viewModel),
      );

  Widget _buildBodyState(CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.coursePracticePrompt)
          ? const PageLoadingIndicator()
          : Container();
}
