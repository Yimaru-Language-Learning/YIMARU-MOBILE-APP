import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_column_button.dart';

import '../../../../models/learn_question.dart';
import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_learn_practice_sheet.dart';
import '../../../widgets/small_app_bar.dart';

class StartLearnPracticeScreen extends ViewModelWidget<LearnPracticeViewModel> {
  final int index;
  final LearnQuestion question;

  const StartLearnPracticeScreen(
      {super.key, required this.index, required this.question});

  Future<void> _cancel(LearnPracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.pop();
    viewModel.pop();

  }

  void _start(LearnPracticeViewModel viewModel) {
    viewModel.playVoicePrompt(question);
  }

  Future<void> _showSheet(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: kcTransparent,
        builder: (cxt) => _buildSheet(viewModel),
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
        child: _buildBodyColumn(context: context, viewModel: viewModel),
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
        _buildAppBarWrapper(context: context, viewModel: viewModel),
        _buildStartButtonWrapper(viewModel),
        _buildLowerButtonsSectionWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context: context, viewModel: viewModel),
          verticalSpaceMedium,
        ],
      );

  Widget _buildAppBar(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      SmallAppBar(
          showBackButton: true,
          onPop: () async =>
              await _showSheet(context: context, viewModel: viewModel),
          title: 'Practice Speaking ($index/${viewModel.questions.length})');

  Widget _buildSheet(LearnPracticeViewModel viewModel) =>
      CancelLearnPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: ()async  => await _cancel(viewModel),
      );

  Widget _buildStartButtonWrapper(LearnPracticeViewModel viewModel) => Expanded(
        child: _buildStartButtonContainer(viewModel),
      );

  Widget _buildStartButtonContainer(LearnPracticeViewModel viewModel) =>
      GestureDetector(
        onTap: () => _start(viewModel),
        child: _buildStartButton(),
      );

  Widget _buildStartButton() => Container(
        width: 150,
        height: 150,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: SweepGradient(
            stops: const [
              0.0,
              0.1,
              0.2,
              0.3,
              0.4,
              0.5,
              0.6,
              0.8,
              0.9,
              1,
            ],
            endAngle: 8,
            startAngle: 0.0,
            center: Alignment.center,
            colors: [
              kcPrimaryColor.withOpacity(0.3),
              kcIndigo.withOpacity(0.2),
              kcIndigo.withOpacity(0.3),
              kcIndigo.withOpacity(0.4),
              kcIndigo.withOpacity(0.5),
              kcPrimaryColor.withOpacity(0.5),
              kcPrimaryColor.withOpacity(0.4),
              kcPrimaryColor.withOpacity(0.3),
              kcPrimaryColor.withOpacity(0.2),
              kcPrimaryColor.withOpacity(0.5),
            ],
            // quarterly spread
          ),
        ),
        child: _buildStartText(),
      );

  Widget _buildStartText() => Text(
        'Start',
        style: style25W600,
      );

  Widget _buildLowerButtonsSectionWrapper(LearnPracticeViewModel viewMode) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: _buildLowerButtonsSection(viewMode),
      );

  Widget _buildLowerButtonsSection(LearnPracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildLowerButtonsSectionChildren(viewModel),
      );

  List<Widget> _buildLowerButtonsSectionChildren(
          LearnPracticeViewModel viewModel) =>
      [
        _buildActionLabel(),
        verticalSpaceMedium,
        _buildButtonsRowWrapper(viewModel),
        verticalSpaceMedium,
      ];

  Widget _buildActionLabel() => Text(
        'Tap the start button to listen',
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildButtonsRowWrapper(LearnPracticeViewModel viewModel) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildButtonsRowChildren(viewModel),
      );

  List<Widget> _buildButtonsRowChildren(LearnPracticeViewModel viewModel) => [
        _buildReplyButtonWrapper(),
        _buildMicButtonWrapper(viewModel),
        _buildEmptySpace()
      ];

  Widget _buildReplyButtonWrapper() => Expanded(child: _buildReplyButton());

  Widget _buildReplyButton() => const CustomColumnButton(
      icon: Icons.replay, label: 'Reply', color: kcLightGrey);

  Widget _buildMicButtonWrapper(LearnPracticeViewModel viewModel) =>
      Expanded(child: _buildMicButton(viewModel));

  Widget _buildMicButton(LearnPracticeViewModel viewModel) => ElevatedButton(
        onPressed: null,
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(CircleBorder()),
          padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
          shadowColor: WidgetStatePropertyAll(kcPrimaryColor),
          backgroundColor: WidgetStatePropertyAll(kcVeryLightGrey),
        ),
        child: _buildMicIcon(),
      );

  Widget _buildMicIcon() => const Icon(
        Icons.mic,
        size: 35,
        color: kcWhite,
      );

  Widget _buildEmptySpace() => Expanded(child: Container());
}
