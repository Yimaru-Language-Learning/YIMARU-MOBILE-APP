import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class CustomSmallRadioButton extends StatelessWidget {
  final String title;
  final bool selected;
  final GestureTapCallback? onTap;

  const CustomSmallRadioButton(
      {super.key, required this.title, required this.selected, this.onTap});

  @override
  Widget build(BuildContext context) => _buildButtonWrapper();

  Widget _buildButtonWrapper() => Container(
        height: 50,
        width: double.maxFinite,
        margin: const EdgeInsets.only(bottom: 15),
        child: _buildContainerWrapper(),
      );

  Widget _buildContainerWrapper() => GestureDetector(
        onTap: onTap,
        child: _buildContainer(),
      );

  Widget _buildContainer() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: selected ? kcPrimaryColor.withValues(alpha: 0.1) : kcWhite,
          border: Border.all(
            color: selected ? kcPrimaryColor : kcPrimaryColor.withValues(alpha: 0.75),
          ),
        ),
        child: _buildButtonRowWrapper(),
      );

  Widget _buildButtonRowWrapper() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildButtonRowChildren(),
      );

  List<Widget> _buildButtonRowChildren() =>
      [_buildTextWrapper(), if (selected) _buildIcon()];

  Widget _buildTextWrapper() => Expanded(
        child: _buildText(),
      );

  Widget _buildText() => Text(
        title,
        maxLines: 2,
        style: const TextStyle(color: kcDarkGrey),
      );

  Widget _buildIcon() => const Icon(
        Icons.check_circle,
        color: kcPrimaryColor,
      );
}
