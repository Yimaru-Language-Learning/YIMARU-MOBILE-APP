import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/progress/progress_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_column.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';
import 'custom_linear_progress_indicator.dart';

class LearningProgressCard extends ViewModelWidget<ProgressViewModel> {
  final GestureTapCallback? onTap;

  const LearningProgressCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context, ProgressViewModel viewModel) =>
      _buildContainerWrapper(viewModel);

  Widget _buildContainerWrapper(ProgressViewModel viewModel) => GestureDetector(
        onTap: onTap,
        child: _buildContainer(viewModel),
      );

  Widget _buildContainer(ProgressViewModel viewModel) => Container(
        height: 320,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: kcPrimaryColor.withValues(alpha: 0.1),
        ),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(ProgressViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(ProgressViewModel viewModel) => [
        _buildIcon(),
        verticalSpaceSmall,
        _buildTitle(),
        verticalSpaceTiny,
        _buildSubtitle(),
        verticalSpaceSmall,
        _buildProgressIndicator(viewModel),
        verticalSpaceSmall,
        _buildLearningStatus(viewModel),
        verticalSpaceMedium,
        _buildActionButton(),
      ];

  Widget _buildIcon() => const Icon(
        Icons.menu_book_rounded,
        size: 50,
        color: kcPrimaryColor,
      );

  Widget _buildTitle() => Text(
        LocaleKeys.learn_english.tr(),
        style: style16DG600,
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.keep_momentum.tr(),
        maxLines: 2,
        style: style14MG400,
      );

  Widget _buildProgressIndicator(ProgressViewModel viewModel) =>
      CustomLinearProgressIndicator(
        activeColor: kcPrimaryColor,
        backgroundColor: kcVeryLightGrey,
        progress: viewModel.busy(StateObjects.progressSummary)
            ? 0
            : viewModel.totalProgress / 100,
      );

  Widget _buildLearningStatus(ProgressViewModel viewModel) => Row(
        children: _buildLearningStatusChildren(viewModel),
      );

  List<Widget> _buildLearningStatusChildren(ProgressViewModel viewModel) => [
        _buildCompletedPractices(viewModel),
        horizontalSpaceSmall,
        _buildTotalPractices(viewModel),
        horizontalSpaceSmall,
        _buildProgressPercentage(viewModel),
      ];

  Widget _buildCompletedPractices(ProgressViewModel viewModel) => Expanded(
      child: CustomColumn(
          title: viewModel.busy(StateObjects.progressSummary)
              ? '-'
              : viewModel.completedCount.toString(),
          subtitle: LocaleKeys.completed_practices.tr()));

  Widget _buildTotalPractices(ProgressViewModel viewModel) => Expanded(
      child: CustomColumn(
          title: viewModel.busy(StateObjects.progressSummary)
              ? '-'
              : viewModel.totalCount.toString(),
          subtitle: LocaleKeys.total_practices.tr()));

  Widget _buildProgressPercentage(ProgressViewModel viewModel) => Expanded(
      child: CustomColumn(
          title: viewModel.busy(StateObjects.progressSummary)
              ? '-'
              : '${viewModel.totalProgress.toString()}%',
          subtitle: LocaleKeys.progress_percentage.tr()));

  Widget _buildActionButton() => CustomElevatedButton(
        height: 15,
        width: 200,
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        text: LocaleKeys.continue_learning.tr(),
      );
}
