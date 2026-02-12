import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_column_button.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/small_app_bar.dart';

class StartPracticeScreen extends ViewModelWidget<LearnPracticeViewModel> {
  const StartPracticeScreen({super.key});

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LearnPracticeViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(LearnPracticeViewModel viewModel) =>
      SafeArea(child: _buildBodyColumnWrapper(viewModel));

  Widget _buildBodyColumnWrapper(LearnPracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBodyColumn(viewModel),
      );

  Widget _buildBodyColumn(LearnPracticeViewModel viewModel) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(LearnPracticeViewModel viewModel) => [
        _buildAppBarWrapper(viewModel),
        _buildStartButtonWrapper(viewModel),
        _buildLowerButtonsSectionWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(LearnPracticeViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
        ],
      );

  Widget _buildAppBar(LearnPracticeViewModel viewModel) => SmallAppBar(
        onTap: viewModel.goBack,
        title: 'Practice Speaking',
      );

  Widget _buildStartButtonWrapper(LearnPracticeViewModel viewModel) => Expanded(
        child: _buildStartButtonContainer(viewModel),
      );

  Widget _buildStartButtonContainer(LearnPracticeViewModel viewModel) =>
      GestureDetector(
        onTap: () => viewModel.goTo(2),
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
        _buildButtonsRowWrapper(),
        verticalSpaceMedium,
      ];

  Widget _buildActionLabel() => Text(
        'Tap the microphone to speak',
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildButtonsRowWrapper() => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildButtonsRowChildren(),
      );

  List<Widget> _buildButtonsRowChildren() => [
        _buildReplyButtonWrapper(),
        _buildMicButtonWrapper(),
        _buildEmptySpace()
      ];

  Widget _buildReplyButtonWrapper() => Expanded(child: _buildReplyButton());

  Widget _buildReplyButton() => const CustomColumnButton(
      icon: Icons.replay, label: 'Reply', color: kcPrimaryColor);

  Widget _buildMicButtonWrapper() => Expanded(child: _buildMicButton());

  Widget _buildMicButton() => ElevatedButton(
        onPressed: () {},
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

  Widget _buildEmptySpace() => Expanded(child: Container());
}
