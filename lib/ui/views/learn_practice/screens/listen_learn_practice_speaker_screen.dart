import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/cancel_learn_practice_sheet.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';
import 'package:yimaru_app/ui/widgets/wave_wrapper.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_column_button.dart';
import '../../../widgets/small_app_bar.dart';

class ListenLearnPracticeSpeakerScreen
    extends ViewModelWidget<LearnPracticeViewModel> {
  const ListenLearnPracticeSpeakerScreen({super.key});

  Future<void> _showSheet(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: kcTransparent,
        builder: (_) => _buildSheet(viewModel),
      );

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) =>
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(context: context, viewModel: viewModel),
      );

  Widget _buildScaffold(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      SafeArea(
          child:
              _buildBodyColumnWrapper(context: context, viewModel: viewModel));

  Widget _buildBodyColumnWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBodyStack(context: context, viewModel: viewModel),
      );

  Widget _buildBodyStack(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Stack(
        children: [
          _buildBodyColumn(context: context, viewModel: viewModel),
          _buildProgressIndicatorWrapper()
        ],
      );

  Widget _buildBodyColumn(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            _buildBodyColumnChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyColumnChildren(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      [
        _buildAppBarWrapper(viewModel),
        _buildSpeakingIndicatorWrapper(viewModel),
        _buildLowerButtonsSectionWrapper(context: context, viewModel: viewModel)
      ];

  Widget _buildAppBarWrapper(LearnPracticeViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
        ],
      );

  Widget _buildAppBar(LearnPracticeViewModel viewModel) => SmallAppBar(
        showBackButton: true,
        onTap: viewModel.goBack,
        title: 'Practice Speaking',
      );

  Widget _buildSpeakingIndicatorWrapper(LearnPracticeViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildSpeakingIndicatorChildren(),
      );

  List<Widget> _buildSpeakingIndicatorChildren() =>
      [_buildSpeakerLabel(), verticalSpaceMedium, _buildSpeakingIndicator()];

  Widget _buildSpeakerLabel() => Text(
        'Daniel is speaking...',
        style: style14P400,
        textAlign: TextAlign.center,
      );

  Widget _buildSpeakingIndicator() =>
      WaveWrapper(height: 200, child: _buildSpinner());

  Widget _buildSpinner() => const SpinKitWave(
        size: 20,
        color: kcPrimaryColor,
        type: SpinKitWaveType.center,
      );

  Widget _buildLowerButtonsSectionWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child:
            _buildLowerButtonsSection(context: context, viewModel: viewModel),
      );

  Widget _buildLowerButtonsSection(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildLowerButtonsSectionChildren(
            context: context, viewModel: viewModel),
      );

  List<Widget> _buildLowerButtonsSectionChildren(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      [
        _buildActionLabel(),
        verticalSpaceMedium,
        _buildButtonsRowWrapper(context: context, viewModel: viewModel),
        verticalSpaceMedium,
      ];

  Widget _buildActionLabel() => Text(
        'Tap the microphone to speak',
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildButtonsRowWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            _buildButtonsRowChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildButtonsRowChildren(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      [
        _buildReplyButtonWrapper(),
        _buildMicButtonWrapper(viewModel),
        _buildCancelButtonWrapper(context: context, viewModel: viewModel)
      ];

  Widget _buildReplyButtonWrapper() => Expanded(child: _buildReplyButton());

  Widget _buildReplyButton() => const CustomColumnButton(
      icon: Icons.replay, label: 'Reply', color: kcPrimaryColor);

  Widget _buildMicButtonWrapper(LearnPracticeViewModel viewModel) =>
      Expanded(child: _buildMicButton(viewModel));

  Widget _buildMicButton(LearnPracticeViewModel viewModel) => ElevatedButton(
        onPressed: () => viewModel.goTo(3),
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(CircleBorder()),
          padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
          shadowColor: WidgetStatePropertyAll(kcPrimaryColor),
          backgroundColor: WidgetStatePropertyAll(kcPrimaryColor),
        ),
        child: _buildMicIcon(),
      );

  Widget _buildMicIcon() => const Icon(
        Icons.mic,
        size: 35,
        color: kcWhite,
      );

  Widget _buildCancelButtonWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Expanded(
          child: _buildCancelButton(context: context, viewModel: viewModel));

  Widget _buildCancelButton(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      CustomColumnButton(
        color: kcRed,
        label: 'Cancel',
        icon: Icons.close,
        onTap: () async =>
            await _showSheet(context: context, viewModel: viewModel),
      );

  Widget _buildSheet(LearnPracticeViewModel viewModel) =>
      CancelLearnPracticeSheet(
        onTap: viewModel.pop,
      );

  Widget _buildProgressIndicatorWrapper() => Positioned(
        top: 75,
        left: 0,
        right: 0,
        child: _buildProgressIndicator(),
      );

  Widget _buildProgressIndicator() => const CustomLinearProgressIndicator(
      progress: 0.7,
      activeColor: kcPrimaryColor,
      backgroundColor: kcVeryLightGrey);
}
