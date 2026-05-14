import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/widgets/app_bar_pattern.dart';
import 'package:yimaru_app/ui/widgets/language_button.dart';

class LargeAppBar extends StatelessWidget {
  final String? language;
  final bool showBackButton;
  final GestureTapCallback? onPop;
  final bool showLanguageSelection;
  final GestureTapCallback? onClose;
  final GestureTapCallback? onLanguage;

  const LargeAppBar(
      {super.key,
      this.onPop,
      this.onClose,
      this.language,
      this.onLanguage,
      required this.showBackButton,
      required this.showLanguageSelection});

  @override
  Widget build(BuildContext context) => _buildStackWrapper();

  Widget _buildStackWrapper() => Container(
        height: 125,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          color: kcPrimaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: _buildStack(),
      );

  Widget _buildStack() => Stack(
        children: [_buildPattern(), _buildAppBarWrapper()],
      );

  Widget _buildAppBarWrapper() => Container(
        color: kcTransparent,
        width: double.maxFinite,
        height: double.maxFinite,
        alignment: Alignment.bottomCenter,
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
      child: showLanguageSelection
          ? _buildLanguageSelector()
          : _buildCloseButton());

  Widget _buildLanguageSelector() => LanguageButton(
        onTap: onLanguage,
        language: language ?? '',
      );

  Widget _buildCloseButton() => IconButton(
        onPressed: onClose,
        icon: _buildCloseIcon(),
        padding: const EdgeInsets.only(top: 5),
      );

  Widget _buildCloseIcon() => const Icon(
        Icons.close,
        color: kcWhite,
      );

  Widget _buildPattern() => const AppBarPattern();
}
