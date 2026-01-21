import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/learn_module/learn_module_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';

import '../common/app_colors.dart';
import '../common/enmus.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';

class LearnModuleTile extends ViewModelWidget<LearnModuleViewModel> {
  final String title;
  final String subtitle;
  final ProgressStatuses status;

  const LearnModuleTile({
    super.key,
    required this.title,
    required this.status,
    required this.subtitle,
  });

  IconData _getIcon() {
    if (title.contains('Module 1')) {
      return Iconsax.cake;
    } else if (title.contains('Module 2')) {
      return Icons.all_inbox;
    } else if (title.contains('Module 3')) {
      return Icons.lightbulb_outline;
    } else if (title.contains('Module 4')) {
      return Icons.search;
    } else {
      return Iconsax.pen_add;
    }
  }

  @override
  Widget build(BuildContext context, LearnModuleViewModel viewModel) =>
      _buildExpansionTileCard(viewModel);

  Widget _buildExpansionTileCard(LearnModuleViewModel viewModel) => Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kcVeryLightGrey),
        ),
        child: _buildTileStack(viewModel),
      );

  Widget _buildTileStack(LearnModuleViewModel viewModel) => Stack(
        children: [
          _buildExpansionTile(viewModel),
          _buildContainerShaderWrapper()
        ],
      );

  Widget _buildExpansionTile(LearnModuleViewModel viewModel) => ExpansionTile(
        textColor: kcDarkGrey,
        title: _buildTitle(),
        subtitle: _buildContent(),
        leading: _buildIconWrapper(),
        collapsedIconColor: kcDarkGrey,
        collapsedTextColor: kcDarkGrey,
        backgroundColor: kcBackgroundColor,
        shape: Border.all(color: kcTransparent),
        expandedAlignment: Alignment.centerLeft,
        collapsedBackgroundColor: kcBackgroundColor,
        enabled: status != ProgressStatuses.pending,
        controlAffinity: ListTileControlAffinity.trailing,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        tilePadding: const EdgeInsets.symmetric(horizontal: 15),
        childrenPadding: const EdgeInsets.fromLTRB(70, 15, 15, 15),
        showTrailingIcon: status != ProgressStatuses.pending ? true : false,
        initiallyExpanded: status == ProgressStatuses.started ? true : false,
        children: _buildExpansionTileChildren(viewModel),
      );

  Widget _buildIconWrapper() => CircleAvatar(
        backgroundColor: kcPrimaryColor.withOpacity(0.1),
        child: _buildIcon(),
      );

  Widget _buildIcon() => Icon(
        _getIcon(),
        color: kcPrimaryColor,
      );

  Widget _buildTitle() => Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: kcPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildContent() => Text(
        subtitle,
        style: const TextStyle(
          color: kcDarkGrey,
        ),
      );

  List<Widget> _buildExpansionTileChildren(LearnModuleViewModel viewModel) =>
      [_buildExpansionTileItem(viewModel)];

  Widget _buildExpansionTileItem(LearnModuleViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildExpansionTileItemChildren(viewModel),
      );

  List<Widget> _buildExpansionTileItemChildren(
          LearnModuleViewModel viewModel) =>
      [
        _buildProgressRow(),
        verticalSpaceSmall,
        _buildActionButtonWrapper(viewModel)
      ];

  Widget _buildProgressRow() => Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildProgressChildren(),
      );

  List<Widget> _buildProgressChildren() =>
      [_buildProgressStatusWrapper(), horizontalSpaceSmall, _buildProgress()];

  Widget _buildProgressStatusWrapper() => Expanded(
        child: _buildProgressStatus(),
      );

  Widget _buildProgressStatus() => const CustomLinearProgressIndicator(
      progress: 0.75,
      activeColor: kcPrimaryColor,
      backgroundColor: kcVeryLightGrey);

  Widget _buildProgress() => const Text(
        '2/3',
        style: TextStyle(color: kcDarkGrey),
      );

  Widget _buildActionButtonWrapper(LearnModuleViewModel viewModel) => SizedBox(
        height: 40,
        child: _buildActionButtons(viewModel),
      );

  Widget _buildActionButtons(LearnModuleViewModel viewModel) => Row(
        children: [
          _buildLessonButtonWrapper(viewModel),
          horizontalSpaceSmall,
          _buildPracticeButtonWrapper(viewModel)
        ],
      );

  Widget _buildLessonButtonWrapper(LearnModuleViewModel viewModel) => Expanded(
        child: _buildLessonButton(viewModel),
      );

  Widget _buildLessonButton(LearnModuleViewModel viewModel) =>
      const CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        text: 'View Lessons',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        //onTap: () async => await viewModel.navigateToLearnModule(),
      );

  Widget _buildPracticeButtonWrapper(LearnModuleViewModel viewModel) =>
      Expanded(
        child: _buildPracticeButton(viewModel),
      );

  Widget _buildPracticeButton(LearnModuleViewModel viewModel) =>
      const CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        text: 'View Practices',
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
        // onTap: () async => await viewModel.navigateToLearnLevel(),
      );

  Widget _buildContainerShaderWrapper() => Positioned.fill(
        child: _buildContainerShader(),
      );

  Widget _buildContainerShader() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kcWhite.withOpacity(0.75)),
        ),
      );
}
