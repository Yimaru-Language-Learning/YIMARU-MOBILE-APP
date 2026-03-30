import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../common/app_colors.dart';

class MiniThumbnail extends StatelessWidget {
  final String thumbnail;

  const MiniThumbnail({super.key, required this.thumbnail});

  @override
  Widget build(BuildContext context) => _buildWrapper();

  Widget _buildWrapper() => SizedBox(
        width: 75,
        height: double.maxFinite,
        child: _buildLeadingClipper(),
      );

  Widget _buildLeadingClipper() => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: _buildLeadingStack(),
      );

  Widget _buildLeadingStack() => Stack(
        alignment: Alignment.center,
        children: _buildLeadingChildren(),
      );

  List<Widget> _buildLeadingChildren() =>
      [_buildImageWrapper(), _buildPlayButtonWrapper()];

  Widget _buildImageWrapper() =>
      Align(alignment: Alignment.center, child: _buildImageBuilder());

  Widget _buildImageBuilder() => thumbnail.contains('assets/images')
      ? _buildLocalImage()
      : _buildNetworkImage();

  Widget _buildNetworkImage() => CachedNetworkImage(
        imageUrl: thumbnail,
        fit: BoxFit.fill,
        width: double.maxFinite,
      );

  Widget _buildLocalImage() => Image.asset(
        thumbnail,
        fit: BoxFit.fill,
        width: double.maxFinite,
      );

  Widget _buildPlayButtonWrapper() => Align(
        alignment: Alignment.center,
        child: _buildPlayButton(),
      );

  Widget _buildPlayButton() => CircleAvatar(
        radius: 14,
        backgroundColor: kcTransparent,
        child: _buildPlayIconClipper(),
      );

  Widget _buildPlayIconClipper() => ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: _buildPlayIconBlender(),
      );

  Widget _buildPlayIconBlender() => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: _buildPlayIcon(),
      );

  Widget _buildPlayIcon() => const Icon(
        Icons.play_arrow,
        color: kcWhite,
      );
}
