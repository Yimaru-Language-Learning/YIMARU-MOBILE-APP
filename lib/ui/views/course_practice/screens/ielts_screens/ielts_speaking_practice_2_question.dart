import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/translations/locale_keys.g.dart';
import '../../../../common/ui_helpers.dart';
import '../../../../widgets/cancel_practice_sheet.dart';
import '../../../../widgets/circular_countdown_timer.dart';
import '../../../../widgets/course_practice_app_bar.dart';
import '../../../../widgets/course_practice_text_card.dart';
import '../../course_practice_viewmodel.dart';

class IeltsSpeakingPractice2Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  const IeltsSpeakingPractice2Question({super.key});

  Future<void> _startRecording(CoursePracticeViewModel viewModel) async {
    int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
        .dynamicPayload?.response?.first.value['seconds'];
    await viewModel.startRecording();
    viewModel.nextScreen();
    viewModel.setCountdown(responseFirstSec);
  }

  Future<void> _cancel(CoursePracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    //  viewModel.resetValues();

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
        children:
            _buildBodyColumnChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyColumnChildren(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      [
        _buildAppBarWrapper(context: context, viewModel: viewModel),
        _buildAnswerSectionWrapper(viewModel),
        verticalSpaceMassive
      ];

  Widget _buildAppBarWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context: context, viewModel: viewModel),
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
            '${LocaleKeys.speaking_practice.tr()} (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildTitle() => Text(
        LocaleKeys.part1_cue_card.tr(),
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildAnswerSectionWrapper(CoursePracticeViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildAnswerSectionChildren(viewModel),
      );

  List<Widget> _buildAnswerSectionChildren(CoursePracticeViewModel viewModel) =>
      [
        verticalSpaceMedium,
        _buildQuestion(viewModel),
        verticalSpaceLarge,
        _buildTimerStackWrapper(viewModel),
        verticalSpaceSmall,
        _buildSubtitle(),
        verticalSpaceLarge,
        _buildActionLabel(),
        verticalSpaceMedium,
        _buildMicButton(viewModel)
      ];

  Widget _buildQuestion(CoursePracticeViewModel viewModel) =>
      CoursePracticeTextCard(
        subtitle: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?.last.value,
      );

  Widget _buildTimerStackWrapper(CoursePracticeViewModel viewModel) =>
      CircularCountdownTimer(
        onEnd: () async => await _startRecording(viewModel),
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.prep_time.tr(),
        style: style16DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildActionLabel() => Text(
        LocaleKeys.tap_microphone.tr(),
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildMicButton(CoursePracticeViewModel viewModel) => ElevatedButton(
        style: const ButtonStyle(
          shadowColor: WidgetStatePropertyAll(kcWhite),
          shape: WidgetStatePropertyAll(CircleBorder()),
          padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
          backgroundColor: WidgetStatePropertyAll(
            kcPrimaryColor,
          ),
        ),
        onPressed: () async => await _startRecording(viewModel),
        child: _buildMicIcon(),
      );

  Widget _buildMicIcon() => const Icon(
        Icons.mic,
        size: 50,
        color: kcWhite,
      );
}
