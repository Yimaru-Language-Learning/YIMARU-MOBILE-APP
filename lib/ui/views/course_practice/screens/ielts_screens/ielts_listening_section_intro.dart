import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/ielts_listening_instruction_card.dart';
import 'package:yimaru_app/ui/widgets/ielts_listening_section_play_button.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/enmus.dart';
import '../../../../common/ui_helpers.dart';
import '../../../../widgets/cancel_practice_sheet.dart';
import '../../../../widgets/course_practice_app_bar.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_linear_progress_indicator.dart';
import '../../../../widgets/page_loading_indicator.dart';
import '../../../../widgets/progress_status.dart';
import '../../../../widgets/speaking_indicator.dart';
import '../../course_practice_viewmodel.dart';

class IeltsListeningSectionIntro
    extends ViewModelWidget<CoursePracticeViewModel> {
  final String title;

  const IeltsListeningSectionIntro({super.key, required this.title});

  Future<void> _next(CoursePracticeViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await viewModel.stopAudio();
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
        _buildSpeakingIndicatorWrapper(viewModel),
        _buildContinueButtonSection(context: context, viewModel: viewModel)
      ];

  Widget _buildAppBarWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context: context, viewModel: viewModel),
          verticalSpaceMedium,
          _buildInstructionCard()
        ],
      );

  Widget _buildAppBar(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CoursePracticeAppBar(
        onClose: () async =>
            await _showSheet(context: context, viewModel: viewModel),
        title:
            '${LocaleKeys.listening_practice.tr()} (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildInstructionCard() => const IeltsListeningInstructionCard();

  Widget _buildSpeakingIndicatorWrapper(CoursePracticeViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildSpeakingIndicatorChildren(viewModel),
      );

  List<Widget> _buildSpeakingIndicatorChildren(
          CoursePracticeViewModel viewModel) =>
      [
        _buildTitle(),
        verticalSpaceSmall,
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildSpeakingIndicator(),
        verticalSpaceMedium,
        _buildLinearProgressIndicator(viewModel),
        verticalSpaceMedium,
        _buildPlayButton(),
        verticalSpaceMedium,
        _buildInstruction(),
      ];

  Widget _buildTitle() => Text(
        title,
        style: style18P600,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => ProgressStatus(
        color: kcPrimaryColor,
        status: LocaleKeys.ready_to_listen_status.tr(),
      );

  Widget _buildSpeakingIndicator() => const SpeakingIndicator(size: 50);

  Widget _buildLinearProgressIndicator(CoursePracticeViewModel viewModel) =>
      CustomLinearProgressIndicator(
          activeColor: kcPrimaryColor,
          progress: viewModel.progress,
          backgroundColor: kcVeryLightGrey);

  Widget _buildPlayButton() => const IeltsListeningSectionPlayButton();

  Widget _buildInstruction() => Text(
        LocaleKeys.cannot_stop_restart_audio_info.tr(),
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildWarning() => Text(
        LocaleKeys.complete_audio_to_proceed_warning.tr(),
        style: style12DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildContinueButtonSection(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child:
            _buildContinueButtonColumn(context: context, viewModel: viewModel),
      );

  Widget _buildContinueButtonColumn(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildContinueButtonChildren(
            context: context, viewModel: viewModel),
      );

  List<Widget> _buildContinueButtonChildren(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      [
        _buildContinueButton(context: context, viewModel: viewModel),
        verticalSpaceTiny,
        _buildWarning(),
      ];

  Widget _buildContinueButton(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CustomElevatedButton(
        height: 55,
        text: LocaleKeys.cont.tr(),
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: () async => await _next(viewModel),
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildBodyState(CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.coursePractice) ||
              viewModel.busy(StateObjects.stopAudio)
          ? const PageLoadingIndicator()
          : Container();
}
