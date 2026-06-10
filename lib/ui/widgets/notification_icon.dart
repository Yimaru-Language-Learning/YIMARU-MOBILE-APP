import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import '../common/app_colors.dart';

class NotificationIcon extends StatelessWidget {
  final String count;
  final GestureTapCallback? onTap;
  const NotificationIcon({super.key, this.onTap, required this.count});

  @override
  Widget build(BuildContext context) => _buildNotificationIconWrapper();

  Widget _buildNotificationIconWrapper() => Align(
      alignment: Alignment.bottomRight, child: _buildNotificationButton());

  Widget _buildNotificationButton() => GestureDetector(
        onTap: onTap,
        child: _buildNotificationBadge(),
      );

  Widget _buildNotificationBadge() => badges.Badge(
        badgeContent: Text(
          count,
          style: style12W600,
        ),
        child: _buildNotificationIcon(),
      );
  Widget _buildNotificationIcon() => const Icon(
        Icons.notifications_none,
        color: kcDarkGrey,
      );
}
