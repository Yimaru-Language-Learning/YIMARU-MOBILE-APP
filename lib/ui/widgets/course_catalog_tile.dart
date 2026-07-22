import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';

import '../../models/course_catalog.dart';
import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import '../views/course_catalog/course_catalog_viewmodel.dart';
import 'custom_elevated_button.dart';

class CourseCatalogTile extends ViewModelWidget<CourseCatalogViewModel> {
  final CourseCatalog catalog;
  final GestureTapCallback? onCourseTap;
  final GestureTapCallback? onPracticeTap;

  const CourseCatalogTile({
    super.key,
    this.onCourseTap,
    this.onPracticeTap,
    required this.catalog,
  });

  @override
  Widget build(BuildContext context, CourseCatalogViewModel viewModel) =>
      _buildExpansionTileCardWrapper(viewModel);

  Widget _buildExpansionTileCardWrapper(CourseCatalogViewModel viewModel) =>
      GestureDetector(
        onTap: !(catalog.access?.isAccessible ?? false) ? onPracticeTap : null,
        child: _buildExpansionTileCard(),
      );

  Widget _buildExpansionTileCard() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: kcPrimaryColor.withValues(alpha: 0.2),
          ),
        ),
        child: _buildExpansionTile(),
      );

  Widget _buildExpansionTile() => ExpansionTile(
        enabled: true,
        title: _buildTitle(),
        textColor: kcDarkGrey,
        showTrailingIcon: false,
        initiallyExpanded: false,
        collapsedIconColor: kcDarkGrey,
        collapsedTextColor: kcDarkGrey,
        shape: Border.all(color: kcTransparent),
        expandedAlignment: Alignment.centerLeft,
        backgroundColor: kcPrimaryColor.withValues(alpha: 0.1),
        controlAffinity: ListTileControlAffinity.trailing,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        collapsedBackgroundColor: kcPrimaryColor.withValues(alpha: 0.1),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
        children: _buildExpansionTileChildren(),
      );

  List<Widget> _buildExpansionTileChildren() => [
        _buildProgressRow(),
        verticalSpaceSmall,
        _buildActionButtonWrapper(),
        verticalSpaceSmall
      ];

  Widget _buildTitle() => Text(
        catalog.name ?? '',
        style: style16P600,
      );

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
      progress: 0,
      activeColor: kcPrimaryColor,
      backgroundColor: kcVeryLightGrey);

  Widget _buildProgress() => const Text(
        '0%',
        style: TextStyle(color: kcDarkGrey),
      );

  Widget _buildActionButtonWrapper() => SizedBox(
        height: 40,
        width: 300,
        child: _buildActionButtons(),
      );

  Widget _buildActionButtons() => Row(
        children: [
          _buildStartButtonWrapper(),
          horizontalSpaceSmall,
          _buildExamButtonWrapper()
        ],
      );

  Widget _buildStartButtonWrapper() => Expanded(
        child: _buildStartButton(),
      );

  Widget _buildStartButton() => CustomElevatedButton(
        height: 15,
        borderRadius: 8,
        onTap: onCourseTap,
        text: 'Start Course',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildExamButtonWrapper() => Expanded(
        child: _buildExamButton(),
      );

  Widget _buildExamButton() => CustomElevatedButton(
        height: 15,
        borderRadius: 8,
        onTap: onPracticeTap,
        text: 'Take Mock Exam',
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
      );
}
