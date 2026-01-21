import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class LanguageButton extends StatelessWidget {
  final String language;
  final GestureTapCallback? onTap;

  const LanguageButton({super.key, this.onTap, required this.language});

  @override
  Widget build(BuildContext context) => _buildContainerWrapper();

  Widget _buildContainerWrapper() =>
      GestureDetector(onTap: onTap, child: _buildContainer());

  Widget _buildContainer() => Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: kcPrimaryColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kcWhite)),
        child: _buildLanguage(),
      );

  Widget _buildLanguage() => Text(
        language,
        style: const TextStyle(color: kcWhite),
      );
}
