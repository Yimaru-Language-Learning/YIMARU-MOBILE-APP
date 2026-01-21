import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

import '../common/app_colors.dart';

class LearnAppBar extends StatelessWidget {
  const LearnAppBar({super.key});

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

  Widget _buildProfileImage() => const CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage('assets/images/profile.png'),
      );

  Widget _buildGreetingTextColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildGreetingChildren(),
      );

  List<Widget> _buildGreetingChildren() =>
      [_buildGreetingTitle(), _buildSubTitle()];

  Widget _buildGreetingTitle() => const Text.rich(
        TextSpan(
            text: 'Hello,',
            style: TextStyle(
              color: kcDarkGrey,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: ' Bisrat!',
                style: TextStyle(
                  color: kcPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              )
            ]),
      );

  Widget _buildSubTitle() => const Text(
        'Ready to keep learning English today?',
        textAlign: TextAlign.center,
        style: TextStyle(color: kcMediumGrey),
      );

  Widget _buildNotificationIconWrapper() =>
      Align(alignment: Alignment.bottomRight, child: _buildNotificationIcon());

  Widget _buildNotificationIcon() => const Icon(
        Icons.notifications_none,
        color: kcDarkGrey,
      );
}
