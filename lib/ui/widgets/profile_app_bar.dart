import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_constants.dart';

import '../common/app_colors.dart';
import '../common/translations/locale_keys.g.dart';
import 'notification_icon.dart';

class ProfileAppBar extends StatelessWidget {
  final String? name;
  final String unreadCount;
  final String? profileImage;
  final GestureTapCallback? onTap;

  const ProfileAppBar(
      {super.key,
      this.onTap,
      required this.name,
      required this.unreadCount,
      required this.profileImage});

  @override
  Widget build(BuildContext context) => _buildStack();

  Widget _buildStack() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: _buildProfileRow()),
          const SizedBox(width: 12),
          _buildNotificationIconWrapper(),
        ],
      );

  Widget _buildProfileRow() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProfileImage(),
          const SizedBox(width: 12),
          Expanded(child: _buildGreetingTextColumn()),
        ],
      );

  Widget _buildProfileImage() => Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.yellow62,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.yellow62.withValues(alpha: 0.25),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: profileImage != null &&
                (profileImage?.contains('.') ?? false) &&
                profileImage != kEmptyImagePath
            ? Image.file(
                File(profileImage!),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildPersonIcon(),
              )
            : _buildPersonIcon(),
      );

  Widget _buildPersonIcon() => const Center(
        child: Icon(
          Icons.person_rounded,
          size: 30,
          color: AppColors.neutral14,
        ),
      );

  Widget _buildGreetingTextColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGreetingTitle(),
          const SizedBox(height: 2),
          _buildSubtitle(),
        ],
      );

  Widget _buildGreetingTitle() => Text(
        LocaleKeys.hello_user.tr(args: [name ?? '']),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: AppColors.neutral14,
          fontFamily: 'Aeonik',
          letterSpacing: -0.3,
        ),
        overflow: TextOverflow.ellipsis,
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.ready_to_learn.tr(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.neutral40,
          fontFamily: 'Aeonik',
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  Widget _buildNotificationIconWrapper() => NotificationIcon(
        count: unreadCount,
        onTap: onTap,
      );
}
