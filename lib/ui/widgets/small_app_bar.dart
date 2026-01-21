import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/widgets/custom_back_button.dart';

class SmallAppBar extends StatelessWidget {
  final String? title;
  final GestureTapCallback? onTap;

  const SmallAppBar({super.key, this.onTap, this.title});

  @override
  Widget build(BuildContext context) => _buildAppBar();

  Widget _buildAppBar() => Stack(
        alignment: Alignment.center,
        children: _buildAppBarChildren(),
      );

  List<Widget> _buildAppBarChildren() =>
      [_buildBackButtonWrapper(), if (title != null) _buildTitleWrapper()];

  Widget _buildBackButtonWrapper() => Align(
        alignment: Alignment.centerLeft,
        child: _buildBackButton(),
      );

  Widget _buildBackButton() => CustomBackButton(onTap: onTap);

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
