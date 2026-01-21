import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/widgets/custom_column.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';
import 'custom_linear_progress_indicator.dart';

class LearningProgressCard extends StatelessWidget {
  final GestureTapCallback? onTap;

  const LearningProgressCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) => _buildContainerWrapper();

  Widget _buildContainerWrapper() => GestureDetector(
        onTap: onTap,
        child: _buildContainer(),
      );

  Widget _buildContainer() => Container(
        height: 320,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: kcPrimaryColor.withOpacity(0.1),
        ),
        child: _buildColumn(),
      );

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() => [
        _buildIcon(),
        verticalSpaceSmall,
        _buildTitle(),
        verticalSpaceTiny,
        _buildSubtitle(),
        verticalSpaceSmall,
        _buildProgressIndicator(),
        verticalSpaceSmall,
        _buildLearningStatus(),
        verticalSpaceMedium,
        _buildActionButton(),
      ];

  Widget _buildIcon() => const Icon(
        Icons.menu_book_rounded,
        size: 50,
        color: kcPrimaryColor,
      );

  Widget _buildTitle() => const Text(
        'Learn English',
        style: TextStyle(
          fontSize: 16,
          color: kcDarkGrey,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildSubtitle() => const Text(
        'Great job! Keep the momentum.',
        maxLines: 2,
        style: TextStyle(color: kcMediumGrey),
      );

  Widget _buildProgressIndicator() => const CustomLinearProgressIndicator(
        progress: 0.5,
        activeColor: kcPrimaryColor,
        backgroundColor: kcVeryLightGrey,
      );

  Widget _buildLearningStatus() => Row(
        children: _buildLearningStatusChildren(),
      );

  List<Widget> _buildLearningStatusChildren() => [
        _buildWatchedVideos(),
        horizontalSpaceSmall,
        _buildCompletedPractices(),
        horizontalSpaceSmall,
        _buildTakenQuizzes()
      ];

  Widget _buildWatchedVideos() => const Expanded(
      child: CustomColumn(title: '120', subtitle: 'Videos Watched'));
  Widget _buildCompletedPractices() => const Expanded(
      child: CustomColumn(title: '85', subtitle: 'Practices Completed'));
  Widget _buildTakenQuizzes() => const Expanded(
      child: CustomColumn(title: '45', subtitle: 'Quizzes Taken'));

  Widget _buildActionButton() => const CustomElevatedButton(
        height: 15,
        width: 200,
        borderRadius: 12,
        text: 'Continue Learning',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );
}
