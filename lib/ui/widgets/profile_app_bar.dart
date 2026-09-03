import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_constants.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

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

  Widget _buildStack() => Stack(
        alignment: Alignment.center,
        children: _buildStackChildren(),
      );

  List<Widget> _buildStackChildren() =>
      [_buildProfileWrapper(), _buildNotificationIconWrapper()];

  Widget _buildProfileWrapper() => Align(
        alignment: Alignment.centerLeft,
        child: _buildProfileRow(),
      );

  Widget _buildProfileRow() => Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildProfileRowChildren(),
      );

  List<Widget> _buildProfileRowChildren() =>
      [_buildProfileImage(), horizontalSpaceSmall, _buildGreetingTextColumn()];

  Widget _buildProfileImage() => CircleAvatar(
        radius: 25,
        backgroundColor: kcViolet,
        backgroundImage: profileImage != null ||
                (profileImage?.contains('.') ?? false) ||
                profileImage == kEmptyImagePath
            ? FileImage(
                File(profileImage!),
              )
            : null,
        child: _buildImageBuilder(),
      );

  Widget? _buildImageBuilder() => profileImage == null ||
          !(profileImage?.contains('.') ?? false) ||
          profileImage == kEmptyImagePath
      ? _buildPersonIcon()
      : null;

  Widget _buildPersonIcon() => const Icon(
        Icons.person,
        size: 30,
        color: kcPrimaryColor,
      );

  Widget _buildGreetingTextColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildGreetingChildren(),
      );

  List<Widget> _buildGreetingChildren() =>
      [_buildGreetingTitle(), _buildSubtitle()];

  Widget _buildGreetingTitle() => Text(
        LocaleKeys.hello_user.tr(args: [name ?? '']),
        style: style14DG600,
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.ready_to_learn.tr(),
        textAlign: TextAlign.center,
        style: style14DG400,
      );

  Widget _buildNotificationIconWrapper() => NotificationIcon(
        count: unreadCount,
        onTap: onTap,
      );
}
