import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/duolingo_practice_question_card.dart';

import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/duolingo_practice_app_bar.dart';
import '../../../widgets/countdown_timer.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/page_loading_indicator.dart';
import '../course_practice_viewmodel.dart';

class DuolingoSpeakingPractice2Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoSpeakingPractice2Question({super.key});


  Future<void> _next(CoursePracticeViewModel viewModel) async {
    await viewModel.startRecording();
    viewModel.setCountdown(viewModel.questions[viewModel.currentQuestion]
        .dynamicPayload?.response?.first.value['seconds']);
    viewModel.nextScreen();
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
        body: _buildScaffoldStack(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldStack(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Stack(
        children: [
          _buildScaffold(context: context, viewModel: viewModel),
          _buildStartRecState(viewModel)
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
        _buildSpeakingIndicatorExpandedWrapper(viewModel),
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
          verticalSpaceSmall,
        ],
      );

  Widget _buildAppBar(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      DuolingoPracticeAppBar(
        onClose: () async =>
            await _showSheet(context: context, viewModel: viewModel),
        title:
            'Speaking practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildSpeakingIndicatorExpandedWrapper(
          CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildSpeakingIndicatorScrollerWrapper(viewModel));

  Widget _buildSpeakingIndicatorScrollerWrapper(
          CoursePracticeViewModel viewModel) =>
      SingleChildScrollView(child: _buildSpeakingIndicatorWrapper(viewModel));

  Widget _buildSpeakingIndicatorWrapper(CoursePracticeViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildSpeakingIndicatorChildren(viewModel),
      );

  List<Widget> _buildSpeakingIndicatorChildren(
          CoursePracticeViewModel viewModel) =>
      [
        verticalSpaceLarge,
        _buildTitle(),
        _buildSubtitle(viewModel),
        verticalSpaceMedium,
        _buildQuestion(viewModel),
      ];

  Widget _buildCountdownWrapper(CoursePracticeViewModel viewModel) => Align(
      alignment: Alignment.centerRight, child: _buildCountdown(viewModel));

  Widget _buildCountdown(CoursePracticeViewModel viewModel) => CountdownTimer(
        duration: viewModel.countdown,
        onEnd: () async => await _next(viewModel),
      );

  Widget _buildTitle() => Text(
        'Prepare to speak about the topic below',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle(CoursePracticeViewModel viewModel) => Text(
        'You will have ${viewModel.questions[viewModel.currentQuestion].dynamicPayload?.stimulus?.last.value['seconds']} seconds to speak',
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestion(CoursePracticeViewModel viewModel) =>
      DuolingoPracticeQuestionCard(
        title: '',
        subtitle: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?.first.value,
      );

  Widget _buildContinueButtonWrapper(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(top: 25, bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(CoursePracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        text: 'Start Speaking',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: () async => await _next(viewModel),
      );

  Widget _buildStartRecState(CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.recordCoursePracticeAnswer)
          ? const PageLoadingIndicator()
          : Container();
}
