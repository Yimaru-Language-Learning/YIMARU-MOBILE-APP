import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/enmus.dart';
import '../../../../common/translations/locale_keys.g.dart';
import '../../../../common/ui_helpers.dart';
import '../../../../widgets/cancel_practice_sheet.dart';
import '../../../../widgets/course_practice_app_bar.dart';
import '../../../../widgets/listenable_review_practice_card.dart';
import '../../../../widgets/page_loading_indicator.dart';
import '../../../../widgets/speaking_practice_review_section.dart';
import '../../course_practice_viewmodel.dart';

class IeltsSpeakingPractice4Review
    extends ViewModelWidget<CoursePracticeViewModel> {
  const IeltsSpeakingPractice4Review({super.key});

  String getQuestion(
      {required int index, required CoursePracticeViewModel viewModel}) {
    if (index >= viewModel.answers.length) return '';
    return viewModel.answers[index]['question_text']?.toString() ?? '';
  }

  Future<void> _next(
      {required BuildContext context,
      required CoursePracticeViewModel viewModel}) async {
    await viewModel.stopAudio();

    if (viewModel.currentQuestion == viewModel.questions.length - 1) {
      viewModel.pop();
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
        resizeToAvoidBottomInset: true,
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
        _buildExpandedBody(context: context, viewModel: viewModel),
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
        ],
      );

  Widget _buildAppBar(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CoursePracticeAppBar(
        onClose: () async =>
            await _showSheet(context: context, viewModel: viewModel),
        title:
            '${LocaleKeys.speaking_practice.tr()} (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildExpandedBody(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Expanded(
          child: _buildBodyScroller(context: context, viewModel: viewModel));

  Widget _buildBodyScroller(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      SingleChildScrollView(
        child: _buildQuestionSectionWrapper(
            context: context, viewModel: viewModel),
      );

  Widget _buildQuestionSectionWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildQuestionQuestionSectionChildren(
            context: context, viewModel: viewModel),
      );

  List<Widget> _buildQuestionQuestionSectionChildren(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      [
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceMedium,
        _buildQuestionRowWrapper(
            number: '1', question: getQuestion(index: 0, viewModel: viewModel)),
        verticalSpaceMedium,
        _buildQuestionRowWrapper(
            number: '2', question: getQuestion(index: 1, viewModel: viewModel)),
        verticalSpaceMedium,
        _buildQuestionRowWrapper(
            number: '3', question: getQuestion(index: 2, viewModel: viewModel)),
        verticalSpaceMedium,
        _buildQuestionRowWrapper(
            number: '4', question: getQuestion(index: 3, viewModel: viewModel)),
        verticalSpaceMedium,
        _buildQuestionRowWrapper(
            number: '5', question: getQuestion(index: 4, viewModel: viewModel)),
        verticalSpaceMedium,
        _buildQuestionRowWrapper(
            number: '6', question: getQuestion(index: 5, viewModel: viewModel)),
        verticalSpaceMedium,
        _buildQuestionRowWrapper(
            number: '7', question: getQuestion(index: 6, viewModel: viewModel)),
        verticalSpaceMedium,
        _buildQuestionRowWrapper(
            number: '8', question: getQuestion(index: 7, viewModel: viewModel)),
        verticalSpaceLarge,
        _buildPracticeReviewSection(context: context, viewModel: viewModel),
      ];

  Widget _buildTitle() => Text(
        LocaleKeys.interview.tr(),
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestionRowWrapper(
          {required String question, required String number}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildQuestion(question: question, number: number),
      );
  Widget _buildQuestion( {required String question, required String number}) => Text(
    '$number. $question',
    style: style14DG400,
    textAlign: TextAlign.center,
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
