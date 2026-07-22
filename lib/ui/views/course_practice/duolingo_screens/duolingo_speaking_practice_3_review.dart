import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/countdown_timer.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../../../widgets/page_loading_indicator.dart';
import '../../../widgets/speaking_practice_review_section.dart';
import '../../../widgets/course_practice_text_card.dart';
import '../course_practice_viewmodel.dart';

class DuolingoSpeakingPractice3Review
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoSpeakingPractice3Review({super.key});

  Future<void> _next(
      {required BuildContext context,
      required CoursePracticeViewModel viewModel}) async {
    await viewModel.stopAudio();

    if (viewModel.currentQuestion == viewModel.questions.length - 1) {
      viewModel.nextScreen();
    } else {
      await viewModel.nextQuestion(context);
    }
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
          _buildStopRecState(viewModel)
        ],
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
        _buildAppBarIndenter(context: context, viewModel: viewModel),
        _buildQuestionSectionWrapperExpandedWrapper(viewModel),
        _buildPracticeReviewSection(context: context, viewModel: viewModel)
      ];

  Widget _buildAppBarIndenter(
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
          _buildCountdownWrapper(viewModel),
          verticalSpaceSmall
        ],
      );

  Widget _buildAppBar(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CoursePracticeAppBar(
        onClose: () async =>
            await _showSheet(context: context, viewModel: viewModel),
        title:
            'Speaking practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildCountdownWrapper(CoursePracticeViewModel viewModel) => Align(
        alignment: Alignment.centerRight,
        child: _buildCountdown(viewModel),
      );

  Widget _buildCountdown(CoursePracticeViewModel viewModel) =>
      const CountdownTimer(time: '00:00');

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildQuestionSectionWrapperExpandedWrapper(
          CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildQuestionWrapperScrollerWrapper(viewModel));

  Widget _buildQuestionWrapperScrollerWrapper(
          CoursePracticeViewModel viewModel) =>
      SingleChildScrollView(child: _buildQuestionIndenter(viewModel));

  Widget _buildQuestionIndenter(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildQuestionColumn(viewModel),
      );

  Widget _buildQuestionColumn(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: __buildQuestionColumnChildren(viewModel),
      );

  List<Widget> __buildQuestionColumnChildren(
          CoursePracticeViewModel viewModel) =>
      [verticalSpaceMedium, _buildQuestion(viewModel), verticalSpaceMedium];

  Widget _buildQuestion(CoursePracticeViewModel viewModel) =>
      CoursePracticeTextCard(
        subtitle: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?.last.value,
      );

  Widget _buildPracticeReviewSection(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      SpeakingPracticeReviewSection(
        answers: viewModel.answers,
        onTap: () async => await _next(context: context, viewModel: viewModel),
      );

  Widget _buildStopRecState(CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.stopAudio)
          ? const PageLoadingIndicator()
          : Container();
}
