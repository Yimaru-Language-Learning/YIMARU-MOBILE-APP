import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

import '../common/ui_helpers.dart';

class CoursePaymentCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String subtitle;

  const CoursePaymentCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) => _buildListTile();

  Widget _buildListTile() => ListTile(
        title: _buildTitle(),
        leading: _buildLeading(),
        subtitle: _buildSubtitle(),
        tileColor: kcPrimaryColor.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side:  BorderSide(color: kcPrimaryColor.withValues(alpha: 0.25)),
        ),
      );

  Widget _buildTitle() => Text(
        title,
        style: style16DG600,
      );

  Widget _buildSubtitle() => Text(
        subtitle,
        style: style14DG400,
      );

  Widget _buildLeading() => CircleAvatar(
    radius: 25,
        backgroundColor: kcPrimaryColor.withValues(alpha: 0.25),
        child: _buildIcon(),
      );

  Widget _buildIcon() => Icon(
        icon,
        size: 25,
        color: kcPrimaryColor,
      );
}
