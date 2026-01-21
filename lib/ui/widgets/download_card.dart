import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

import '../common/app_colors.dart';
import 'custom_elevated_button.dart';

class DownloadCard extends StatelessWidget {
  final String size;
  final String title;
  final String duration;
  final String thumbnail;

  const DownloadCard(
      {super.key,
      required this.size,
      required this.title,
      required this.thumbnail,
      required this.duration});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        height: 75,
        width: double.maxFinite,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: kcPrimaryColor.withOpacity(0.1),
        ),
        child: _buildRow(),
      );

  Widget _buildRow() => Row(
        children: [
          _buildLeadingWrapper(),
          const SizedBox(width: 10),
          _buildCourseInfo(),
          const SizedBox(width: 10),
          _buildRemoveButtonWrapper(),
        ],
      );

  Widget _buildLeadingWrapper() => SizedBox(
        width: 50,
        height: double.maxFinite,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: _buildLeadingStack(),
        ),
      );

  Widget _buildLeadingStack() => Stack(
        alignment: Alignment.center,
        children: [_buildImageWrapper(), _buildPlayButtonWrapper()],
      );

  Widget _buildImageWrapper() =>
      Align(alignment: Alignment.center, child: _buildImage());

  Widget _buildImage() => Image.asset(
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

  Widget _buildCourseInfo() => Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildCourseInfoChildren(),
        ),
      );

  List<Widget> _buildCourseInfoChildren() => [_buildTitle(), _buildMiddleRow()];

  Widget _buildTitle() => Text(
        title,
        style: style16DG600,
      );

  Widget _buildMiddleRow() => Row(
        children: [
          _buildSize(),
          const SizedBox(width: 10),
          _buildDot(),
          const SizedBox(width: 10),
          _buildDuration()
        ],
      );

  Widget _buildDuration() => Text(
        duration,
        style: style14P400,
      );

  Widget _buildDot() => Text(
        '-',
        style: style14P400,
      );

  Widget _buildSize() => Text(
        size,
        style: style14P400,
      );

  Widget _buildRemoveButtonWrapper() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: _buildRemoveButton(),
      );

  Widget _buildRemoveButton() => CustomElevatedButton(
        width: 110,
        height: 15,
        text: 'Remove',
        borderRadius: 12,
        foregroundColor: kcRed,
        backgroundColor: kcRed.withOpacity(0.25),
      );
}
