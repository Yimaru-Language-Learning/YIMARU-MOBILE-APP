import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';

import '../../models/subcategory.dart';
import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';

class CourseSubcategoryTile extends StatelessWidget {
  final Subcategory subcategory;
  final GestureTapCallback? onCourseTap;
  final GestureTapCallback? onPracticeTap;

  const CourseSubcategoryTile({
    super.key,
    this.onCourseTap,
    this.onPracticeTap,
    required this.subcategory,
  });

  @override
  Widget build(BuildContext context) => _buildExpansionTileCard();

  Widget _buildExpansionTileCard() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: kcPrimaryColor.withOpacity(0.2),
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
        backgroundColor: kcPrimaryColor.withOpacity(0.1),
        controlAffinity: ListTileControlAffinity.trailing,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        collapsedBackgroundColor: kcPrimaryColor.withOpacity(0.1),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
        children: _buildExpansionTileChildren(),
      );

  List<Widget> _buildExpansionTileChildren() => [
        // _buildProgressRow(),
        // verticalSpaceSmall,
        _buildActionButtonWrapper(),
        verticalSpaceSmall
      ];

  Widget _buildTitle() => Text(
        (subcategory.name == null || subcategory.name!.isEmpty)
            ? 'Course ${subcategory.id}'
            : subcategory.name!,
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
      progress: 0.75,
      activeColor: kcPrimaryColor,
      backgroundColor: kcVeryLightGrey);

  Widget _buildProgress() => const Text(
        '75%',
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
        child: Container(),
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
