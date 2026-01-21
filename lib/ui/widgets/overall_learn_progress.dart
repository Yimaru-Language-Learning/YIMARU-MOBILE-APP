import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';

class OverallLearnProgress extends StatelessWidget {
  const OverallLearnProgress({super.key});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: kcPrimaryColor.withOpacity(0.1),
        ),
        child: _buildProgressSection(),
      );

  Widget _buildProgressSection() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildProgressSectionChildren(),
      );

  List<Widget> _buildProgressSectionChildren() => [
        _buildProgressInfoWrapper(),
        verticalSpaceSmall,
        _buildProgressIndicator(),
        verticalSpaceSmall,
        _buildSubtitle()
      ];

  Widget _buildProgressInfoWrapper() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildProgressInfoChildren(),
      );

  List<Widget> _buildProgressInfoChildren() =>
      [_buildProgressInfo(), _buildProgress()];

  Widget _buildProgressInfo() => const Text(
        'Overall Progress',
        style: TextStyle(
          fontSize: 16,
          color: kcDarkGrey,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildProgress() => const Text(
        '35%',
        style: TextStyle(
          color: kcPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildProgressIndicator() => const CustomLinearProgressIndicator(
        progress: 0.75,
        activeColor: kcPrimaryColor,
        backgroundColor: kcVeryLightGrey,
      );

  Widget _buildSubtitle() => const Text(
        'Keep up the great work! You\'re doing amazing.',
        style: TextStyle(color: kcDarkGrey),
      );
}
