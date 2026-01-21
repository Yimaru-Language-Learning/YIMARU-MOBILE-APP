import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) => _buildSizedBox();

  Widget _buildSizedBox() => SizedBox(
        height: 125,
        width: 125,
        child: _buildStack(),
      );

  Widget _buildStack() => Stack(
        children: [_buildProfileImageWrapper(), _buildCameraButtonWrapper()],
      );

  Widget _buildProfileImageWrapper() => Align(
        alignment: Alignment.center,
        child: _buildProfileImage(),
      );

  Widget _buildProfileImage() => const CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage('assets/images/profile.png'),
      );

  Widget _buildCameraButtonWrapper() => Align(
        alignment: Alignment.bottomCenter,
        child: _buildCameraButton(),
      );

  Widget _buildCameraButton() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        decoration: BoxDecoration(
            color: kcPrimaryColor, borderRadius: BorderRadius.circular(25)),
        child: _buildCameraIcon(),
      );

  Widget _buildCameraIcon() => const Icon(
        Icons.camera_alt_outlined,
        size: 18,
        color: kcWhite,
      );
}
