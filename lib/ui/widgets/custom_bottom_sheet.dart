import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child;
  final GestureTapCallback? onTap;

  const CustomBottomSheet({super.key, this.onTap, required this.child});

  @override
  Widget build(BuildContext context) => _buildStackWrapper();

  Widget _buildStackWrapper() => Container(
        height: 400,
        color: kcTransparent,
        width: double.maxFinite,
        child: _buildStack(),
      );

  Widget _buildStack() => Stack(
        children: [_buildCloseButtonWrapper(), _buildSheetWrapper()],
      );

  Widget _buildCloseButtonWrapper() => Padding(
        padding: const EdgeInsets.only(right: 15),
        child: _buildCloseButtonAligner(),
      );

  Widget _buildCloseButtonAligner() => Align(
        alignment: Alignment.topRight,
        child: _buildCloseButtonDetector(),
      );

  Widget _buildCloseButtonDetector() => GestureDetector(
        onTap: onTap,
        child: _buildCloseButton(),
      );

  Widget _buildCloseButton() => CircleAvatar(
        radius: 14,
        backgroundColor: kcBackgroundColor,
        child: _buildCloseIcon(),
      );

  Widget _buildCloseIcon() => const Icon(
        Icons.close,
        size: 14,
        color: kcMediumGrey,
      );

  Widget _buildSheetWrapper() => Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          color: kcBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        margin: const EdgeInsets.only(top: 50),
        child: child,
      );
}
