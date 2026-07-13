import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/dwarf_tile.dart';
import 'package:yimaru_app/ui/widgets/listenable_one_time_practice_card.dart';

import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/countdown_timer.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_small_trailing_radio_button.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../course_practice_viewmodel.dart';

class DuolingoReadingPractice1Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  final int duration;
  final List options;
  final String question;

  const DuolingoReadingPractice1Question({
    super.key,
    required this.options,
    required this.duration,
    required this.question,
  });

  Future<void> _next(CoursePracticeViewModel viewModel) async {
    await viewModel.setListeningAnswer3(
      question: question,
      duration: duration,
      answer: viewModel.selectedOption.toString(),
      sample: (viewModel.questions[viewModel.currentQuestion].dynamicPayload
              ?.response?.last.value['options'] as List)
          .firstWhere((e) => e['is_correct'])['text'],
    );
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
      SafeArea(child: _buildBodyColumn(context: context, viewModel: viewModel));

  Widget _buildBodyColumn(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children:
            _buildBodyColumnChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyColumnChildren(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      [
        _buildAppBarWrapper(context: context, viewModel: viewModel),
        _buildExpandedBody(viewModel),
      ];

  Widget _buildAppBarWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildAppBarChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildAppBarChildren(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      [
        verticalSpaceMedium,
        _buildAppBarIndenter(context: context, viewModel: viewModel),
        verticalSpaceSmall,
        _buildCountdownWrapper(viewModel),
        verticalSpaceSmall,
      ];

  Widget _buildAppBarIndenter(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppBar(context: context, viewModel: viewModel),
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

  Widget _buildCountdownWrapper(CoursePracticeViewModel viewModel) => Align(
      alignment: Alignment.centerRight, child: _buildCountdownState(viewModel));

  Widget _buildCountdownState(CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.reading1Variant)
          ? const CountdownTimer(time: '00:00')
          : _buildCountdown(viewModel);

  Widget _buildCountdown(CoursePracticeViewModel viewModel) => CountdownTimer(
        duration: viewModel.countdown,
        key: ValueKey(viewModel.countdown),
        onEnd: () async => await _next(viewModel),
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildExpandedBody(CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildBodyScroller(viewModel));

  Widget _buildBodyScroller(CoursePracticeViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildQuestionIndenter(viewModel),
      );

  Widget _buildQuestionIndenter(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildQuestionWrapper(viewModel),
      );

  Widget _buildQuestionWrapper(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildQuestionChildren(viewModel),
      );

  List<Widget> _buildQuestionChildren(CoursePracticeViewModel viewModel) => [
        verticalSpaceLarge,
        _buildQuestion(),
        verticalSpaceLarge,
        _buildPracticeQuestions(viewModel),
        verticalSpaceMedium,
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildQuestion() => Text(
        question,
        style: style14DG400,
      );

  Widget _buildPracticeQuestions(CoursePracticeViewModel viewModel) =>
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: options.length,
        itemBuilder: (context, index) => _buildPracticeCard(
          title: options[index]['text'],
          selected: viewModel.isSelectedOption(options[index]),
          onTap: () => _setOption(viewModel: viewModel, option: options[index]),
        ),
      );

  Widget _buildPracticeCard(
          {required String title,
          required bool selected,
          required GestureTapCallback onTap}) =>
      CustomSmallTrailingRadioButton(
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
        onTap: () async => await _next(viewModel),
      );
}
