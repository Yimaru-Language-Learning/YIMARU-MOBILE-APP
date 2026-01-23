import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class ImagePickerOption extends StatelessWidget {
  final GestureTapCallback? onCameraTap;
  final GestureTapCallback? onGalleryTap;

  const ImagePickerOption({super.key, this.onCameraTap, this.onGalleryTap});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        height: 200,
        decoration: const BoxDecoration(
          color: kcBackgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        child: _buildCameraOptionWrapper(),
      );

  Widget _buildCameraOptionWrapper() => Center(
        child: _buildCameraOption(),
      );

  Widget _buildCameraOption() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _buildCameraOptionChildren(),
      );

  List<Widget> _buildCameraOptionChildren() =>
      [_buildCameraButton(), _buildGalleryButton()];

  Widget _buildCameraButton() => GestureDetector(
        onTap: onCameraTap,
        child: _buildCamera(),
      );

  Widget _buildCamera() => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildCameraChildren(),
      );

  List<Widget> _buildCameraChildren() =>
      [_buildCameraIcon(), verticalSpaceTiny, _buildCameraTitle()];

  Widget _buildCameraIcon() => const Icon(
        Icons.camera_alt_rounded,
        size: 60,
        color: kcPrimaryColor,
      );

  Widget _buildCameraTitle() => Text(
        'Camera',
        style: style18P600,
      );

  Widget _buildGalleryButton() => GestureDetector(
        onTap: onGalleryTap,
        child: _buildGallery(),
      );
  Widget _buildGallery() => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildGalleryChildren(),
      );

  Widget _buildGalleryIcon() => const Icon(
        Icons.photo,
        size: 60,
        color: kcPrimaryColor,
      );

  Widget _buildGalleryText() => Text(
        'Gallery',
        style: style18P600,
      );

  List<Widget> _buildGalleryChildren() =>
      [_buildGalleryIcon(), verticalSpaceTiny, _buildGalleryText()];
}
