import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/countdown_timer.dart';
import '../../../widgets/custom_small_leading_radio_button.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../course_practice_viewmodel.dart';

class DuolingoReadingPractice6Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoReadingPractice6Question({super.key});


  Future<void> _next(CoursePracticeViewModel viewModel) async {
    if (viewModel.currentQuestion == viewModel.questions.length - 1) {
      viewModel.nextScreen();
    } else {
      await viewModel.nextQuestion();
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
        ],
      );

  Widget _buildAppBar(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CoursePracticeAppBar(
        onClose: () async =>
            await _showSheet(context: context, viewModel: viewModel),
        title:
            'Reading practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
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
        duration: viewModel.countdown,
        onEnd: () async=> await _next(viewModel),
      );

  Widget _buildQuestionExpandedWrapper(CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildQuestionScrollerWrapper(viewModel));

  Widget _buildQuestionScrollerWrapper(CoursePracticeViewModel viewModel) =>
      SingleChildScrollView(child: _buildQuestionWrapper(viewModel));

  Widget _buildQuestionWrapper(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildQuestionChildren(viewModel),
      );

  List<Widget> _buildQuestionChildren(CoursePracticeViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(viewModel),
        verticalSpaceSmall,
        _buildQuestion(viewModel),
        verticalSpaceMedium,
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildPracticeOptions(viewModel),
        verticalSpaceLarge,
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildTitle(CoursePracticeViewModel viewModel) => Text(
        'Passage',
        style: style16DG600,
      );

  Widget _buildQuestion(CoursePracticeViewModel viewModel) => Text(
        viewModel.questions[viewModel.currentQuestion].dynamicPayload?.stimulus
            ?.first.value,
        style: style14DG400,
      );

  Widget _buildSubtitle() => Text(
        'Select the best title for the passage',
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
        backgroundColor: kcPrimaryColor,
        onTap:  () async=> await _next(viewModel),
      );
}
