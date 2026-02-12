import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yimaru_app/ui/widgets/progress_status.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';

class CourseLevelCard extends StatelessWidget {
  final Color color;
  final String icon;
  final String title;
  final String status;
  final String subtitle;
  final bool isCompleted;
  final GestureTapCallback? onTap;

  const CourseLevelCard({
    super.key,
    this.onTap,
    required this.icon,
    required this.title,
    required this.color,
    required this.status,
    required this.subtitle,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) => _buildContainerWrapper();

  Widget _buildContainerWrapper() => GestureDetector(
        onTap: onTap,
        child: _buildContainer(),
      );

  Widget _buildContainer() => Container(
        width: 200,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(left: 15),
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
        _buildIconSection(),
        verticalSpaceSmall,
        _buildTitle(),
        verticalSpaceSmall,
        _buildSubTitle(),
        verticalSpaceSmall,
        _buildActionButton()
      ];

  Widget _buildIconSection() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildIconSectionChildren(),
      );

  List<Widget> _buildIconSectionChildren() =>
      [_buildIcon(), _buildProgressStatus()];

  Widget _buildIcon() => SvgPicture.asset(
        icon,
        height: 50,
        width: 50,
      );

  Widget _buildProgressStatus() => ProgressStatus(
        color: color,
        status: status,
      );

  Widget _buildTitle() => Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: kcDarkGrey,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildSubTitle() => Expanded(
        child: Text(
          subtitle,
          maxLines: 3,
          style: const TextStyle(color: kcMediumGrey),
        ),
      );

  Widget _buildActionButton() => CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        text: isCompleted ? 'Review Course' : 'Continue Learning',
      );
}
