import 'package:flutter/material.dart';

import '../common/app_colors.dart';

class SpeakingPartnerImage extends StatelessWidget {
  final double radius;
  const SpeakingPartnerImage({super.key,required this.radius});

  @override
  Widget build(BuildContext context) => _buildProfileImage();


  Widget _buildProfileImage() => CircleAvatar(
    radius: radius,
    backgroundColor: kcViolet,
    backgroundImage: _buildImageBuilder(),
  );

  AssetImage? _buildImageBuilder() => const AssetImage('assets/images/profile.png');
}
