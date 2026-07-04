import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/progress_status.dart';

import '../../models/learn_program.dart';
import '../common/app_colors.dart';
import '../views/learn_program/learn_program_viewmodel.dart';
import 'custom_elevated_button.dart';

class LearnProgramTile extends ViewModelWidget<LearnProgramViewModel> {
  final LearnProgram program;
  final GestureTapCallback? onTap;

  const LearnProgramTile({super.key, this.onTap, required this.program});

  @override
  Widget build(BuildContext context, LearnProgramViewModel viewModel) =>
      _buildExpansionTileCard(viewModel);

  Widget _buildExpansionTileCard(LearnProgramViewModel viewModel) => Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kcPrimaryColor.withValues(alpha: 0.1)),
        ),
        child: _buildExpansionTile(viewModel),
      );

  Widget _buildExpansionTile(LearnProgramViewModel viewModel) => ExpansionTile(
        textColor: kcDarkGrey,
        subtitle: _buildContent(),
        title: _buildTitleWrapper(),
        collapsedIconColor: kcDarkGrey,
        collapsedTextColor: kcDarkGrey,
        shape: Border.all(color: kcTransparent),
        expandedAlignment: Alignment.centerLeft,
        enabled: (program.access?.isAccessible ?? false),
        backgroundColor: kcPrimaryColor.withValues(alpha: 0.1),
        controlAffinity: ListTileControlAffinity.trailing,
        tilePadding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        showTrailingIcon: (program.access?.isAccessible ?? false),
        initiallyExpanded: (program.access?.isAccessible ?? false),
        collapsedBackgroundColor: (program.access?.isAccessible ?? false)
            ? kcPrimaryColor.withValues(alpha: 0.1)
            : kcBackgroundColor,
        children: _buildExpansionTileChildren(viewModel),
      );

  List<Widget> _buildExpansionTileChildren(LearnProgramViewModel viewModel) => [
        _buildDivider(),
        verticalSpaceSmall,
        _buildActionButtonWrapper(viewModel),
        verticalSpaceMedium,
      ];

  Widget _buildTitleWrapper() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: _buildTitleState(),
      );

  Widget _buildTitleState() => (program.access?.isAccessible ?? false)
      ? _buildActiveTitleWrapper()
      : _buildInactiveTitleWrapper();

  Widget _buildInactiveTitleWrapper() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildInactiveTitleChildren(),
      );

  List<Widget> _buildInactiveTitleChildren() => [
        _buildLockIcon(),
        verticalSpaceSmall,
        _buildTitle(),
      ];

  Widget _buildLockIcon() => const Icon(
        Icons.lock_outline_rounded,
        color: kcLightGrey,
      );

  Widget _buildActiveTitleWrapper() => Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildActiveTitleChildren(),
      );

  List<Widget> _buildActiveTitleChildren() =>
      [_buildTitle(), horizontalSpaceSmall, _buildProgressStatus()];

  Widget _buildTitle() => Text(
        program.name ?? '',
        style: (program.access?.isAccessible ?? false)
            ? style16P600
            : style16DG600,
      );

  Widget _buildProgressStatus() => ProgressStatus(
        color: kcPrimaryColor,
        status: (program.access?.isCompleted ?? false)
            ? LocaleKeys.completed.tr()
            : LocaleKeys.in_progress.tr(),
      );

  Widget _buildContent() => Text(
        program.description ?? '',
        maxLines: 2,
        style: style14DG400,
      );

  Widget _buildDivider() => const Divider(color: kcVeryLightGrey);

  Widget _buildActionButtonWrapper(LearnProgramViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildActionButton(viewModel),
      );

  Widget _buildActionButton(LearnProgramViewModel viewModel) =>
      CustomElevatedButton(
        height: 15,
        onTap: onTap,
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        text: program.access?.progressPercent == 0
            ? LocaleKeys.start_learning.tr()
            : LocaleKeys.continue_learning.tr(),
      );
}
