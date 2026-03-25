import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class DuolingoAssessmentAppBar extends StatelessWidget {
  final String? title;
  final GestureTapCallback? onClose;

  const DuolingoAssessmentAppBar({super.key, this.onClose, this.title});

  @override
  Widget build(BuildContext context) => _buildAppBar();

  Widget _buildAppBar() => Stack(
        alignment: Alignment.center,
        children: _buildAppBarChildren(),
      );

  List<Widget> _buildAppBarChildren() => [
        if (title != null) _buildTitleWrapper(),
        _buildCloseButtonWrapper(),
      ];

  Widget _buildCloseButtonWrapper() => Align(
        alignment: Alignment.centerRight,
        child: _buildCloseButton(),
      );

  Widget _buildCloseButton() => IconButton(
        onPressed: onClose,
        icon: _buildCloseIcon(),
        padding: const EdgeInsets.only(top: 5),
      );

  Widget _buildCloseIcon() => const Icon(
        Icons.close,
        color: kcPrimaryColor,
      );

  Widget _buildTitleWrapper() => Align(
        alignment: Alignment.center,
        child: _buildTitle(),
      );

  Widget _buildTitle() => Text(
        title ?? '',
        style: const TextStyle(
          fontSize: 18,
          color: kcPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
      );
}
