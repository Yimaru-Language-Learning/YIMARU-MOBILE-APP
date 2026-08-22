import 'package:easy_localization/easy_localization.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/ui_helpers.dart';
import '../../../../widgets/cancel_practice_sheet.dart';
import '../../../../widgets/countdown_timer.dart';
import '../../../../widgets/custom_small_leading_radio_button.dart';
import '../../../../widgets/course_practice_app_bar.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../course_practice_viewmodel.dart';

class DuolingoReadingPractice5Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoReadingPractice5Question({super.key});

  void _setShowAnswer(CoursePracticeViewModel viewModel) {
    viewModel.setShowAnswer();
  }

  Future<void> _next(
      {required BuildContext context,
      required CoursePracticeViewModel viewModel}) async {
    if (viewModel.showAnswer) {
      if (viewModel.currentQuestion == viewModel.questions.length - 1) {
        viewModel.nextScreen();
      } else {
        await viewModel.nextQuestion(context);
      }
    } else {
      _setShowAnswer(viewModel);
    }
  }

  void _setOption(
      {required Map<String, dynamic> option,
      required CoursePracticeViewModel viewModel}) {
    viewModel.setSelectedOption(option);
  }

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
        builder: (cxt) => _buildSheet(context: context, viewModel: viewModel),
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
      SafeArea(child: _buildBodyColumn(context: context, viewModel: viewModel));

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
        _buildAppBarPaddingWrapper(context: context, viewModel: viewModel),
        _buildQuestionExpandedWrapper(context: context, viewModel: viewModel),
        if (viewModel.showAnswer)
          _buildContainerWrapper(context: context, viewModel: viewModel)
      ];

  Widget _buildAppBarPaddingWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppBarWrapper(context: context, viewModel: viewModel),
      );

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
        ],
      );

  Widget _buildAppBar(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CoursePracticeAppBar(
        onClose: () async =>
            await _showSheet(context: context, viewModel: viewModel),
        title:
            '${LocaleKeys.reading_practice.tr()} (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );


  Widget _buildSheet(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
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
        duration: viewModel.countdown,
        onEnd: () => _setShowAnswer(viewModel),
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
          child: _buildQuestionPaddingWrapper(
              context: context, viewModel: viewModel));

  Widget _buildQuestionPaddingWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildQuestionWrapper(context: context, viewModel: viewModel),
      );
  Widget _buildQuestionWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            _buildQuestionChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildQuestionChildren(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      [
        verticalSpaceMedium,
        _buildTitle(viewModel),
        verticalSpaceSmall,
        _buildQuestion(viewModel),
        verticalSpaceMedium,
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildPracticeOptions(viewModel),
        verticalSpaceLarge,
        if (!viewModel.showAnswer)
          _buildContainerWrapper(context: context, viewModel: viewModel)
      ];

  Widget _buildTitle(CoursePracticeViewModel viewModel) => Text(
        LocaleKeys.passage_label.tr(),
        style: style16DG600,
      );


  Widget _buildQuestion(CoursePracticeViewModel viewModel) => Text(
        viewModel.questions[viewModel.currentQuestion].dynamicPayload?.stimulus
            ?.first.value,
        style: style14DG400,
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.select_idea_described_passage.tr(),
        style: style16DG600,
      );


  Widget _buildPracticeOptions(CoursePracticeViewModel viewModel) =>
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?.last.value['options'].length,
        itemBuilder: (context, index) => _buildPracticeCard(
          selected: viewModel.isSelectedOption(viewModel
              .questions[viewModel.currentQuestion]
              .dynamicPayload
              ?.response
              ?.last
              .value['options'][index]),
          onTap: () => _setOption(
              viewModel: viewModel,
              option: viewModel.questions[viewModel.currentQuestion]
                  .dynamicPayload?.response?.last.value['options'][index]),
          title: viewModel.questions[viewModel.currentQuestion].dynamicPayload
              ?.response?.last.value['options'][index]['text'],
        ),
      );

  Widget _buildPracticeCard(
          {required String title,
          required bool selected,
          required GestureTapCallback onTap}) =>
      CustomSmallLeadingRadioButton(
        title: title,
        onTap: onTap,
        selected: selected,
        color: kcBackgroundColor,
      );

  Widget _buildContainerWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Container(
        width: double.maxFinite,
        color: viewModel.showAnswer
            ? kcDeepGreen.withValues(alpha: 0.1)
            : kcTransparent,
        padding:
            EdgeInsets.symmetric(horizontal: viewModel.showAnswer ? 15 : 0),
        child:
            _buildContinueButtonWrapper(context: context, viewModel: viewModel),
      );

  Widget _buildContinueButtonWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child:
            _buildContinueButtonColumn(context: context, viewModel: viewModel),
      );

  Widget _buildContinueButtonColumn(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildContinueButtonChildren(
            context: context, viewModel: viewModel),
      );

  List<Widget> _buildContinueButtonChildren(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      [
        verticalSpaceSmall,
        if (viewModel.showAnswer) _buildCorrectAnswer(viewModel),
        verticalSpaceSmall,
        _buildContinueButton(context: context, viewModel: viewModel)
      ];

  Widget _buildCorrectAnswer(CoursePracticeViewModel viewModel) => Text(
        LocaleKeys.correct_answer_label.tr(args: [
          (viewModel.questions[viewModel.currentQuestion].dynamicPayload
                  ?.response?.last.value['options'] as List)
              .firstWhere((e) => e['is_correct'])['text']
        ]),
        style: style16DG400,
        textAlign: TextAlign.center,
      );


  Widget _buildContinueButton(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CustomElevatedButton(
        height: 55,
        text: LocaleKeys.submit.tr(),
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: () async => await _next(context: context, viewModel: viewModel),
      );
}
