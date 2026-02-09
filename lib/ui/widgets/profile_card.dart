import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String subtitle;
  final GestureTapCallback? onTap;

  const ProfileCard(
      {super.key,
      this.onTap,
      required this.icon,
      required this.title,
      required this.subtitle});

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
        _buildSubtitle()
      ];

  Widget _buildIcon() => Icon(
        icon,
        size: 35,
        color: kcPrimaryColor,
      );

  Widget _buildTitle() => Text(
        title,
        style: style16DG600,
      );

  Widget _buildSubtitle() => Text(
        subtitle,
        style: style14MG400,
      );
}
