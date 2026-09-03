import 'package:easy_localization/easy_localization.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/course_missing_word_question.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/ui_helpers.dart';
import '../../../../widgets/cancel_practice_sheet.dart';
import '../../../../widgets/course_practice_app_bar.dart';
import '../../../../widgets/duolingo_practice_review_section.dart';
import '../../../../widgets/reading_practice_option_card.dart';
import '../../course_practice_viewmodel.dart';

class DuolingoReadingPractice3Review
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoReadingPractice3Review({super.key});

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
        _buildQuestionExpandedWrapper(context: context, viewModel: viewModel),
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
            '${LocaleKeys.reading_practice.tr()} (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );


  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
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
          child: _buildQuestionColumn(context: context, viewModel: viewModel));

  Widget _buildQuestionColumn(
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
        _buildTitleWrapper(viewModel),
        verticalSpaceSmall,
        _buildQuestionWrapper(viewModel),
        verticalSpaceMedium,
        _buildPracticeOptionsWrapper(viewModel),
        verticalSpaceMedium,
        _buildPracticeReviewSection(context: context, viewModel: viewModel)
      ];

  Widget _buildTitleWrapper(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildTitle(viewModel),
      );

  Widget _buildTitle(CoursePracticeViewModel viewModel) => Text(
        LocaleKeys.complete_sentence_correct_word.tr(),
        style: style18DG700,
        textAlign: TextAlign.center,
      );


  Widget _buildQuestionWrapper(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildQuestion(viewModel),
      );

  Widget _buildQuestion(CoursePracticeViewModel viewModel) =>
      CourseMissingWordQuestion(
        showNumber: true,
        segment: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?.last.value['segments'],
      );

  Widget _buildPracticeOptionsWrapper(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildPracticeOptions(viewModel),
      );

  Widget _buildPracticeOptions(CoursePracticeViewModel viewModel) =>
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (viewModel.questions[viewModel.currentQuestion]
                .dynamicPayload?.stimulus?.last.value['segments'] as List)
            .where((e) => e['type'] == 'blank')
            .toList()
            .length,
        itemBuilder: (context, index) =>
            _buildPracticeCard(index: index, viewModel: viewModel),
      );

  Widget _buildPracticeCard(
          {required int index, required CoursePracticeViewModel viewModel}) =>
      ReadingPracticeOptionCard(
        enabled: false,
        number: (index + 1).toString(),
        options: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?.last.value['word_bank'],
      );

  Widget _buildPracticeReviewSection(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      DuolingoPracticeReviewSection(
        onTap: viewModel.currentQuestion == viewModel.questions.length - 1
            ? viewModel.nextScreen
            : () async => await viewModel.nextQuestion(context),
        review: viewModel.answers,
      );
}
