import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class ProfileImage extends StatelessWidget {
  final String? profileImage;
  const ProfileImage({super.key, required this.profileImage});

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

  Widget _buildProfileImage() => CircleAvatar(
        radius: 50,
        backgroundColor: kcPrimaryColor,
        backgroundImage: profileImage != null
            ? CachedNetworkImageProvider(profileImage!)
            : null,
        child: _buildImageBuilder(),
      );

  Widget? _buildImageBuilder() =>
      profileImage == null ? _buildPersonIcon() : null;

  Widget _buildPersonIcon() => const Icon(
        Icons.person,
        size: 50,
        color: kcWhite,
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
