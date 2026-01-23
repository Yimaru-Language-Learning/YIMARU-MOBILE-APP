import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class ProfileImage extends StatelessWidget {
  final bool loading;
  final String? profileImage;
  final GestureTapCallback? onTap;

  const ProfileImage(
      {super.key,
      this.onTap,
      this.loading = false,
      required this.profileImage});

  @override
  Widget build(BuildContext context) => _buildSizedBox();

  Widget _buildSizedBox() => SizedBox(
        width: 125,
        height: 125,
        child: _buildStack(),
      );

  Widget _buildStack() => Stack(
        children: [_buildProfileImageWrapper(), _buildCameraButtonWrapper()],
      );

  Widget _buildProfileImageWrapper() => Align(
        alignment: Alignment.center,
        child: _buildProfileImage(),
      );

  Widget _buildProfileImage() => CircleAvatar(
        radius: 50,
        backgroundColor: kcPrimaryColor,
        backgroundImage: loading
            ? null
            : profileImage != null
                ? FileImage(
                    File(profileImage!),
                  )
                : null,
        child: _buildImageBuilder(),
      );

  Widget? _buildImageBuilder() => loading
      ? null
      : profileImage == null
          ? _buildPersonIcon()
          : null;

  Widget _buildPersonIcon() => const Icon(
        Icons.person,
        size: 50,
        color: kcWhite,
      );

  Widget _buildCameraButtonWrapper() => Align(
        alignment: Alignment.bottomCenter,
        child: _buildCameraTapDetector(),
      );

  Widget _buildCameraTapDetector() => GestureDetector(
        onTap: onTap,
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
