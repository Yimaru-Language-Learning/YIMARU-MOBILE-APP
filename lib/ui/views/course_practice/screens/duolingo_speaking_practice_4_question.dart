import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/dwarf_tile.dart';

import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/duolingo_practice_app_bar.dart';
import '../../../widgets/countdown_timer.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/page_loading_indicator.dart';
import '../../../widgets/speaking_indicator.dart';
import '../course_practice_viewmodel.dart';

class DuolingoSpeakingPractice4Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoSpeakingPractice4Question({super.key});

  Future<void> _start(CoursePracticeViewModel viewModel) async {
    String stimulus = viewModel.questions[viewModel.currentQuestion]
            .dynamicPayload?.stimulus?.first.value ??
        '';
    viewModel.setCountdown(viewModel.questions[viewModel.currentQuestion]
        .dynamicPayload?.response?.first.value['seconds']);
    await viewModel.playVoicePrompt(stimulus);

  }

  Future<void> _cancel(CoursePracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.pop();
    viewModel.pop();
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
          _buildBodyState(viewModel)
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
        _buildSpeakingIndicatorState(viewModel),
        _buildContinueButtonState(viewModel)
      ];

  Widget _buildAppBarWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context: context, viewModel: viewModel),
          verticalSpaceSmall,
          _buildCountdownState(viewModel),
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

  Widget _buildSpeakingIndicatorState(CoursePracticeViewModel viewModel) =>
      viewModel.player.state == PlayerState.playing && viewModel.isSpeaking
          ? _buildSpeakingState()
          : _buildQuestionSectionWrapper(viewModel);

  Widget _buildQuestionSectionWrapper(CoursePracticeViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildQuestionSectionChildren(viewModel),
      );

  List<Widget> _buildQuestionSectionChildren(
          CoursePracticeViewModel viewModel) =>
      [
        _buildTitle(),
        _buildSubtitle(viewModel),
        verticalSpaceMedium,
        _buildQuestion(),
      ];

  Widget _buildCountdownState(CoursePracticeViewModel viewModel) =>
      viewModel.player.state == PlayerState.playing && viewModel.isSpeaking
          ? Container()
          : _buildCountdownWrapper(viewModel);

  Widget _buildCountdownWrapper(CoursePracticeViewModel viewModel) => Align(
      alignment: Alignment.centerRight, child: _buildCountdown(viewModel));

  Widget _buildCountdown(CoursePracticeViewModel viewModel) => CountdownTimer(
        duration: viewModel.countdown,
        onEnd: () => WidgetsBinding.instance
            .addPostFrameCallback((_) async => await _start(viewModel)),
      );

  Widget _buildTitle() => Text(
        'Prepare to have a conversation',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle(CoursePracticeViewModel viewModel) => Text(
        'You will listen to questions and have ${viewModel.questions[viewModel.currentQuestion].dynamicPayload?.stimulus?.last.value['seconds']} seconds to answer each',
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestion() => Image.asset('assets/icons/dwarf.png');

  Widget _buildSpeakingState() => DwarfTile(
        child: _buildSpeakingIndicator(),
      );

  Widget _buildSpeakingIndicator() => const SpeakingIndicator(size: 75);

  Widget _buildContinueButtonState(CoursePracticeViewModel viewModel) =>
      viewModel.player.state == PlayerState.playing && viewModel.isSpeaking
          ? _buildEmptyContainer()
          : _buildContinueButtonWrapper(viewModel);

  Widget _buildEmptyContainer() => const SizedBox(height: 100);

  Widget _buildContinueButtonWrapper(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(CoursePracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Start',
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: () => WidgetsBinding.instance
            .addPostFrameCallback((_) async => await _start(viewModel)),
      );

  Widget _buildBodyState(CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.coursePracticePrompt)
          ? const PageLoadingIndicator()
          : Container();
}
