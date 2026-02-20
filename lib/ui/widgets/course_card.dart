import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final GestureTapCallback? onTap;

  const CourseCard(
      {super.key, this.onTap, required this.title, required this.subtitle});

  Color _getColor() {
    if (title == 'English Proficiency Exams') {
      return kcRed.withValues(alpha: 0.2);
    } else {
      return kcAquamarine.withValues(alpha: 0.2);
    }
  }

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        height: 200,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: _getColor(),
          borderRadius: BorderRadius.circular(5),
        ),
        child: _buildColumn(),
      );

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() => [
        _buildTitle(),
        verticalSpaceTiny,
        _buildSubtitle(),
        verticalSpaceMedium,
        __buildStartButtonWrapper(),
      ];

  Widget _buildTitle() => Text(
        title,
        style: style18DG700,
      );

  Widget _buildSubtitle() => Text(
        subtitle,
        style: style16DG400,
      );

  Widget __buildStartButtonWrapper() => SizedBox(
        height: 40,
        child: _buildStartButton(),
      );

  Widget _buildStartButton() => CustomElevatedButton(
        height: 50,
        width: 200,
        onTap: onTap,
        borderRadius: 12,
        text: 'Start Course',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );
}
