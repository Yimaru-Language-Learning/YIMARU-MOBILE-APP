import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class CustomLargeRadioButton extends StatelessWidget {
  final String title;
  final bool selected;
  final GestureTapCallback? onTap;

  const CustomLargeRadioButton({
    super.key,
    this.onTap,
    required this.title,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) => _buildButtonWrapper();

  Widget _buildButtonWrapper() => Container(
        height: 75,
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
          color: selected ? kcPrimaryColor.withOpacity(0.1) : kcWhite,
          border: Border.all(
            color: selected ? kcPrimaryColor : kcPrimaryColor.withOpacity(0.75),
          ),
        ),
        child: _buildButtonRowWrapper(),
      );

  Widget _buildButtonRowWrapper() => Row(
        children: _buildButtonRowChildren(),
      );

  List<Widget> _buildButtonRowChildren() =>
      [_buildTitleWrapper(), _buildSelectedCheckBox()];

  Widget _buildTitleWrapper() => Expanded(
        child: _buildTitle(),
      );

  Widget _buildTitle() => Text(
        title,
        maxLines: 1,
        style: style16DG400,
      );

  Widget _buildSelectedCheckBox() => Checkbox(
      value: selected,
      activeColor: kcPrimaryColor,
      onChanged: onTap != null ? (value) => onTap!() : null);
}
