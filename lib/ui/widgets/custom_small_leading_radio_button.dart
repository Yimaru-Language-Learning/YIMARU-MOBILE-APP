import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class CustomSmallLeadingRadioButton extends StatelessWidget {
  final String title;
  final bool selected;
  final Color color;
  final GestureTapCallback? onTap;

  const CustomSmallLeadingRadioButton(
      {super.key,
      required this.title,
      required this.color,
      required this.selected,
      this.onTap});

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
          color: color,
          border: Border.all(
            color: selected
                ? kcPrimaryColor.withValues(alpha: 0.5)
                : kcPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
        child: _buildButtonRowWrapper(),
      );

  Widget _buildButtonRowWrapper() => Row(
        children: _buildButtonRowChildren(),
      );

  List<Widget> _buildButtonRowChildren() =>
      [_buildIconState(), horizontalSpaceSmall, _buildTextWrapper()];

  Widget _buildTextWrapper() => Expanded(
        child: _buildText(),
      );

  Widget _buildText() => Text(
        title,
        maxLines: 2,
        style: const TextStyle(color: kcDarkGrey),
      );

  Widget _buildIconState() =>
      selected ? _buildFilledIcon() : _buildUnfilledIcon();

  Widget _buildFilledIcon() => const Icon(
        Icons.check_circle,
        color: kcPrimaryColor,
      );

  Widget _buildUnfilledIcon() => Icon(
        Icons.circle_outlined,
        color: kcMediumGrey.withValues(alpha: 0.5),
      );
}
