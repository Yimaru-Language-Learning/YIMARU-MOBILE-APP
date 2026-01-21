import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/widgets/language_button.dart';

class LargeAppBar extends StatelessWidget {
  final bool showBackButton;
  final GestureTapCallback? onPop;
  final bool showLanguageSelection;
  final GestureTapCallback? onLanguage;

  const LargeAppBar(
      {super.key,
      this.onPop,
      this.onLanguage,
      required this.showBackButton,
      required this.showLanguageSelection});

  @override
  Widget build(BuildContext context) => _buildAppBarWrapper();

  Widget _buildAppBarWrapper() => Container(
        height: 125,
        width: double.maxFinite,
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(
          color: kcPrimaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.only(bottom: 25, right: 15),
        child: _buildAppBarItems(),
      );

  Widget _buildAppBarItems() => Stack(
        children: _buildAppBarItemChildren(),
      );

  List<Widget> _buildAppBarItemChildren() =>
      [if (showBackButton) _buildBackButtonWrapper(), _buildRightButton()];

  Widget _buildBackButtonWrapper() => Align(
        alignment: Alignment.bottomLeft,
        child: _buildBackButton(),
      );

  Widget _buildBackButton() => BackButton(
        onPressed: onPop,
        style:
            const ButtonStyle(foregroundColor: WidgetStatePropertyAll(kcWhite)),
      );

  Widget _buildRightButton() => Align(
      alignment: Alignment.bottomRight,
      child: showLanguageSelection ? _buildLanguageSelector() : Container()
      //  _buildCloseButton()
      );

  Widget _buildLanguageSelector() => LanguageButton(
        language: 'EN',
        onTap: onLanguage,
      );

  Widget _buildCloseButton() => IconButton(
        onPressed: () {},
        icon: _buildCloseIcon(),
      );

  Widget _buildCloseIcon() => const Icon(
        Icons.close,
        color: kcWhite,
      );
}
