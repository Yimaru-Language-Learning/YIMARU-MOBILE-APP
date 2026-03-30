import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/learn_module/learn_module_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';
import 'package:yimaru_app/ui/widgets/finish_practice_sheet.dart';

import '../common/app_colors.dart';
import '../common/enmus.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';

class LearnModuleTile extends ViewModelWidget<LearnModuleViewModel> {
  final String title;
  final String topics;
  final String subtitle;
  final String description;
  final ProgressStatuses status;
  final List<Map<String, dynamic>> practices;

  const LearnModuleTile(
      {super.key,
      required this.title,
      required this.topics,
      required this.status,
      required this.subtitle,
      required this.practices,
      required this.description});

  Future<void> _showSheet(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        backgroundColor: kcTransparent,
        builder: (_) => _buildSheet(viewModel),
      );

  @override
  Widget build(BuildContext context, LearnModuleViewModel viewModel) =>
      _buildExpansionTileCard(context: context, viewModel: viewModel);

  Widget _buildExpansionTileCard(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kcVeryLightGrey),
        ),
        child: _buildTileStack(context: context, viewModel: viewModel),
      );

  Widget _buildTileStack(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      Stack(
        children: [
          _buildExpansionTile(context: context, viewModel: viewModel),
          _buildContainerShaderState()
        ],
      );

  Widget _buildExpansionTile(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      ExpansionTile(
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
        children:
            _buildExpansionTileChildren(context: context, viewModel: viewModel),
      );

  Widget _buildIconWrapper() => CircleAvatar(
        backgroundColor: kcPrimaryColor.withOpacity(0.1),
        child: _buildIcon(),
      );

  Widget _buildIcon() => const Icon(
        Icons.lightbulb_outline,
        color: kcPrimaryColor,
      );

  Widget _buildTitle() => Text(
        title,
        style: style16P600,
      );

  Widget _buildContent() => Text(
        subtitle,
        style: style14DG400,
      );

  List<Widget> _buildExpansionTileChildren(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      [_buildExpansionTileItem(context: context, viewModel: viewModel)];

  Widget _buildExpansionTileItem(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildExpansionTileItemChildren(
            context: context, viewModel: viewModel),
      );

  List<Widget> _buildExpansionTileItemChildren(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      [
        // _buildProgressRow(),
        // verticalSpaceSmall,
        _buildActionButtonWrapper(context: context, viewModel: viewModel)
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

  Widget _buildActionButtonWrapper(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      SizedBox(
        height: 40,
        child: _buildActionButtons(context: context, viewModel: viewModel),
      );

  Widget _buildActionButtons(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      Row(
        children: [
          _buildLessonButtonWrapper(viewModel),
          horizontalSpaceSmall,
          _buildPracticeButtonWrapper(context: context, viewModel: viewModel)
        ],
      );

  Widget _buildLessonButtonWrapper(LearnModuleViewModel viewModel) => Expanded(
        child: _buildLessonButton(viewModel),
      );

  Widget _buildLessonButton(LearnModuleViewModel viewModel) =>
      CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        text: 'View Lessons',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: () async => await viewModel.navigateToLearnLesson(
            title: title,
            topics: topics,
            subtitle: subtitle,
            practices: practices,
            description: description),
      );

  Widget _buildPracticeButtonWrapper(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      Expanded(
        child: _buildPracticeButton(context: context, viewModel: viewModel),
      );

  Widget _buildPracticeButton(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        text: 'View Practices',
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
        onTap: () async => await viewModel.navigateToLearnPractice(practices),
      );

  Widget _buildSheet(LearnModuleViewModel viewModel) => FinishPracticeSheet(
        onTap: viewModel.pop,
      );

  Widget _buildContainerShaderState() => status == ProgressStatuses.pending
      ? _buildContainerShaderWrapper()
      : Container();

  Widget _buildContainerShaderWrapper() => Positioned.fill(
        child: _buildContainerShader(),
      );

  Widget _buildContainerShader() => Container(
        decoration: BoxDecoration(
          color: kcWhite.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5),
        ),
      );
}
