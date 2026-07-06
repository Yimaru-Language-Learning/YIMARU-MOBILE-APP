import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/countdown_timer.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../../../widgets/speaking_practice_review_section.dart';
import '../../../widgets/course_practice_question_card.dart';
import '../course_practice_viewmodel.dart';

class DuolingoSpeakingPractice2Review
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoSpeakingPractice2Review({super.key});

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
        _buildTextSectionWrapperExpandedWrapper(viewModel),
        _buildPracticeReviewSection(viewModel)
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

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildTextSectionWrapperExpandedWrapper(
          CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildTextSectionWrapperScrollerWrapper(viewModel));

  Widget _buildTextSectionWrapperScrollerWrapper(
          CoursePracticeViewModel viewModel) =>
      SingleChildScrollView(child: _buildTextSectionIndenter(viewModel));

  Widget _buildTextSectionIndenter(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildTextSectionWrapper(viewModel),
      );

  Widget _buildTextSectionWrapper(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildTextSectionChildren(viewModel),
      );

  List<Widget> _buildTextSectionChildren(CoursePracticeViewModel viewModel) => [
        verticalSpaceLarge,
        _buildTitle(),
        _buildSubtitle(viewModel),
        verticalSpaceMedium,
        _buildQuestion(viewModel),
        verticalSpaceMedium
      ];

  Widget _buildCountdownWrapper(CoursePracticeViewModel viewModel) => Align(
        alignment: Alignment.centerRight,
        child: _buildCountdown(viewModel),
      );

  Widget _buildCountdown(CoursePracticeViewModel viewModel) =>
      const CountdownTimer(time: '00:00');

  Widget _buildTitle() => Text(
        'Speak about the topic below',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle(CoursePracticeViewModel viewModel) => Text(
        'You will have ${viewModel.questions[viewModel.currentQuestion].dynamicPayload?.response?.first.value['seconds']} seconds to speak',
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestion(CoursePracticeViewModel viewModel) =>
      CoursePracticeQuestionCard(
        title: '',
        subtitle: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?.last.value,
      );

  Widget _buildPracticeReviewSection(CoursePracticeViewModel viewModel) =>
      SpeakingPracticeReviewSection(
          answers:viewModel.answers,
          onTap: viewModel.currentQuestion == viewModel.questions.length - 1
              ? viewModel.nextScreen
              : () async => await viewModel.nextQuestion(),
         );
}
