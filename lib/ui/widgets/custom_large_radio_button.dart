import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class CustomLargeRadioButton extends StatelessWidget {
  final String title;
  final bool selected;
  final IconData icon;
  final String subtitle;
  final GestureTapCallback? onTap;

  const CustomLargeRadioButton(
      {super.key,
      this.onTap,
      required this.title,
      required this.icon,
      required this.selected,
      required this.subtitle});

  @override
  Widget build(BuildContext context) => _buildButtonWrapper();

  Widget _buildButtonWrapper() => Container(
        height: 125,
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
        child: _buildButtonColumnWrapper(),
      );

  Widget _buildButtonColumnWrapper() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildButtonRowChildren(),
      );

  List<Widget> _buildButtonRowChildren() =>
      [_buildIconSectionWrapper(), _buildTitle(), _buildSubTitle()];

  Widget _buildIconSectionWrapper() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildIconSectionChildren(),
      );

  List<Widget> _buildIconSectionChildren() =>
      [_buildLeadingIcon(), _buildSelectedCheckBox()];

  Widget _buildLeadingIcon() => Icon(
        icon,
        size: 25,
        color: kcPrimaryColor,
      );

  Widget _buildTitle() => Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: kcDarkGrey,
          fontWeight: FontWeight.w500,
        ),
      );

  Widget _buildSubTitle() => Text(
        subtitle,
        style: const TextStyle(color: kcMediumGrey),
      );

  Widget _buildSelectedCheckBox() => Checkbox(
      value: selected,
      activeColor: kcPrimaryColor,
      onChanged: (value) => onTap);
}
