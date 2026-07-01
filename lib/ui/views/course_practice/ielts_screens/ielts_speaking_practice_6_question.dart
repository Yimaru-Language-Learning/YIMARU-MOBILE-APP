import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_constants.dart';

import '../../../common/app_colors.dart';
import '../../../common/helper_functions.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/countdown_timer.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/course_practice_question_card.dart';
import '../course_practice_viewmodel.dart';
import '../course_practice_view.form.dart';

class IeltsSpeakingPractice6Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  const IeltsSpeakingPractice6Question({super.key});

  void _nextScreen(CoursePracticeViewModel viewModel) {
    FocusManager.instance.primaryFocus?.unfocus();
    viewModel.nextQuestion();
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
          _buildCountdownWrapper(viewModel),
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
        _buildImageContainer(viewModel),
        verticalSpaceMedium,
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildQuestionColumns(viewModel),
        verticalSpaceLarge,
        _buildContinueButtonWrapper(viewModel),
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
        imageUrl: viewModel.cachedImage ?? '',
      );

  Widget _buildSubtitle() => Text(
        'Label the diagram below. Write the letter from the second column for each answer',
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
        _buildColumnBExpandedWrapper(viewModel)
      ];

  Widget _buildColumnAExpandedWrapper(CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildColumnAWrapper(viewModel));

  Widget _buildColumnAWrapper(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnAChildren(viewModel),
      );

  List<Widget> _buildColumnAChildren(CoursePracticeViewModel viewModel) =>
      [_buildColumnATitle(), verticalSpaceSmall, _buildColumnA(viewModel)];

  Widget _buildColumnATitle() => Text(
        'Column A',
        style: style16DG600,
      );

  Widget _buildColumnA(CoursePracticeViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?.last.value['left'].length,
        itemBuilder: (context, index) => _buildColumnItemWrapper('${index+1}. ${viewModel
            .questions[viewModel.currentQuestion]
            .dynamicPayload
            ?.stimulus
            ?.last
            .value['left'][index]['text']}'),
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
          viewModel.setSelectedChoice(question: question, answer: answer);
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
        dropdownMenuEntries: (viewModel.questions[viewModel.currentQuestion]
                .dynamicPayload?.stimulus?.last.value['left'] as List)
            .map((e) => e['text'])
            .map(
              (option) => DropdownMenuEntry<String>(

                value: option,
                label: option,
              ),
            )
            .toList(),
      );

  Widget _buildColumnBExpandedWrapper(CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildColumnBWrapper(viewModel));

  Widget _buildColumnBWrapper(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnBChildren(viewModel),
      );

  List<Widget> _buildColumnBChildren(CoursePracticeViewModel viewModel) =>
      [_buildColumnBTitle(), verticalSpaceSmall, _buildColumnB(viewModel)];

  Widget _buildColumnBTitle() => Text(
        'Column B',
        style: style16DG600,
      );

  Widget _buildColumnB(CoursePracticeViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?.last.value['right'].length,
        itemBuilder: (context, index) => _buildColumnItemWrapper('${alphabet[index+1]}. ${viewModel
            .questions[viewModel.currentQuestion]
            .dynamicPayload
            ?.stimulus
            ?.last
            .value['right'][index]['text']}'),
      );

  Widget _buildColumnItemWrapper(String title) => SizedBox(
        height: 50,
        child: _buildColumnItem(title),
      );

  Widget _buildColumnItem(String title) => Text(
        title,
        style: style14MG400,
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
