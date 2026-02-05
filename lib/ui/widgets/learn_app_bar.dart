import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

import '../common/app_colors.dart';

class LearnAppBar extends StatelessWidget {
  final String? name;
  final String? profileImage;

  const LearnAppBar(
      {super.key, required this.name, required this.profileImage});

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
        backgroundColor: kcPrimaryColor,
        backgroundImage:
            profileImage != null || (profileImage?.contains('.') ?? false)
                ? FileImage(
                    File(profileImage!),
                  )
                : null,
        child: _buildImageBuilder(),
      );

  Widget? _buildImageBuilder() =>
      profileImage == null || !(profileImage?.contains('.') ?? false)
          ? _buildPersonIcon()
          : null;

  Widget _buildPersonIcon() => const Icon(
        Icons.person,
        size: 30,
        color: kcWhite,
      );

  Widget _buildGreetingTextColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildGreetingChildren(),
      );

  List<Widget> _buildGreetingChildren() =>
      [_buildGreetingTitle(), _buildSubTitle()];

  Widget _buildGreetingTitle() => Text.rich(
        TextSpan(text: 'Hello,', style: style14DG600, children: [
          TextSpan(
            text: ' $name!',
            style: style14P600,
          )
        ]),
      );

  Widget _buildSubTitle() => Text(
        'Ready to keep learning English today?',
        textAlign: TextAlign.center,
        style: style14DG400,
      );

  Widget _buildNotificationIconWrapper() =>
      Align(alignment: Alignment.bottomRight, child: _buildNotificationIcon());

  Widget _buildNotificationIcon() => const Icon(
        Icons.notifications_none,
        color: kcDarkGrey,
      );
}
