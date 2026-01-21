import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String subTitle;
  final GestureTapCallback? onTap;

  const ProfileCard(
      {super.key,
      this.onTap,
      required this.icon,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) => _buildContainerWrapper();

  Widget _buildContainerWrapper() => GestureDetector(
        onTap: onTap,
        child: _buildContainer(),
      );

  Widget _buildContainer() => Container(
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
        verticalSpaceSmall,
        _buildSubTitle()
      ];

  Widget _buildIcon() => Icon(
        icon,
        size: 35,
        color: kcPrimaryColor,
      );

  Widget _buildTitle() => Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: kcDarkGrey,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildSubTitle() => Text(
        subTitle,
        style: const TextStyle(color: kcMediumGrey),
      );
}
