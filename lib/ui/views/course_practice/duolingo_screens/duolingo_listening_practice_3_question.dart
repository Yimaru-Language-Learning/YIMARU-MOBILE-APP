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

class DuolingoListeningPractice3Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  final int duration;
  final List options;
  final String question;

  const DuolingoListeningPractice3Question({super.key,
    required this.options,
    required this.question,
    required this.duration});

  void _setShowAnswer(CoursePracticeViewModel viewModel) {
    viewModel.setShowAnswer();
  }

  Future<void> _next({required BuildContext context,
    required CoursePracticeViewModel viewModel}) async {
    if (viewModel.showAnswer) {
      await viewModel.setListeningAnswer3(
        context: context,
        question: question,
        duration: duration,
        answer: viewModel.selectedOption.toString(),
        sample: options.firstWhere((e) => e['is_correct'])['text'],
      );
    } else {
      _setShowAnswer(viewModel);
    }
  }

  void _setOption({required Map<String, dynamic> option,
    required CoursePracticeViewModel viewModel}) {
    viewModel.setSelectedOption(option);
  }

  Future<void> _cancel(CoursePracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.pop();
    viewModel.goBack();
  }

  Future<void> _showSheet({required BuildContext context,
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

  Widget _buildScaffoldWrapper({required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(context: context, viewModel: viewModel),
      );

  Widget _buildScaffold({required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      SafeArea(child: _buildBodyColumn(context: context, viewModel: viewModel));

  Widget _buildBodyColumn({required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children:
        _buildBodyColumnChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyColumnChildren({required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      [
        _buildAppBarWrapper(context: context, viewModel: viewModel),
        _buildExpandedBody(context: context, viewModel: viewModel),
      ];

  Widget _buildAppBarWrapper({required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildAppBarChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildAppBarChildren({required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      [
        verticalSpaceMedium,
        _buildAppBarIndenter(context: context, viewModel: viewModel),
        verticalSpaceSmall,
        _buildCountdownWrapper(viewModel),
        verticalSpaceSmall,
      ];

  Widget _buildAppBarIndenter({required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppBar(context: context, viewModel: viewModel),
      );

  Widget _buildAppBar({required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      CoursePracticeAppBar(
        onClose: () async =>
        await _showSheet(context: context, viewModel: viewModel),
        title:
        'Listening practice (${viewModel.currentQuestion + 1}/${viewModel
            .questions.length})',
      );

  Widget _buildCountdownWrapper(CoursePracticeViewModel viewModel) =>
      Align(
          alignment: Alignment.centerRight,
          child: _buildCountdownState(viewModel));

  Widget _buildCountdownState(CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.listening3Variant)
          ? const CountdownTimer(time: '00:00')
          : _buildCountdown(viewModel);

  Widget _buildCountdown(CoursePracticeViewModel viewModel) =>
      CountdownTimer(
        duration: viewModel.countdown,
        key: ValueKey(viewModel.countdown),
        onEnd: () => _setShowAnswer(viewModel),
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) =>
      CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildExpandedBody({required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      Expanded(child: _buildBodyScroller(context: context, viewModel: viewModel));

  Widget _buildBodyScroller({required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      SingleChildScrollView(
        child: _buildQuestionIndenter(context: context, viewModel: viewModel),
      );

  Widget _buildQuestionIndenter({required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildQuestionWrapper(context: context, viewModel: viewModel),
      );

  Widget _buildQuestionWrapper({required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildQuestionChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildQuestionChildren({required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      [
        verticalSpaceLarge,
        _buildTitle(),
        verticalSpaceMedium,
        _buildQuestion(),
        verticalSpaceLarge,
        _buildLabel(),
        verticalSpaceSmall,
        _buildPracticeQuestions(viewModel),
        verticalSpaceMedium,
        if(viewModel.showAnswer)
          _buildCorrectAnswer(),
        verticalSpaceSmall,
        _buildContinueButtonWrapper(context: context, viewModel: viewModel)
      ];

  Widget _buildTitle() =>
      Text(
        'Listen closely! Audio clips only play once',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestion() =>
      DwarfTile(small: true, child: _buildListenablePracticeCardWrapper());

  Widget _buildListenablePracticeCardWrapper() =>
      Expanded(
        child: _buildListenablePracticeCard(),
      );

  Widget _buildListenablePracticeCard() =>
      ListenableOneTimePracticeCard(question: question);

  Widget _buildLabel() =>
      Text(
        'Select the best response',
        style: style16DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildPracticeQuestions(CoursePracticeViewModel viewModel) =>
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: options.length,
        itemBuilder: (context, index) =>
            _buildPracticeCard(
              title: options[index]['text'],
              selected: viewModel.isSelectedOption(options[index]),
              onTap: () =>
                  _setOption(viewModel: viewModel, option: options[index]),
            ),
      );

  Widget _buildPracticeCard({required String title,
    required bool selected,
    required GestureTapCallback onTap}) =>
      CustomSmallTrailingRadioButton(
        title: title,
        onTap: onTap,
        selected: selected,
      );


  Widget _buildCorrectAnswer() =>
      Text(
        'Correct Answer: ${options.firstWhere((
            e) => e['is_correct'])['text']} ',
        style: style16DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildContinueButtonWrapper({required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(context: context, viewModel: viewModel),
      );

  Widget _buildContinueButton({required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      CustomElevatedButton(
        height: 55,
        text: 'Submit',
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: () async => await _next(context: context, viewModel: viewModel),
      );
}
