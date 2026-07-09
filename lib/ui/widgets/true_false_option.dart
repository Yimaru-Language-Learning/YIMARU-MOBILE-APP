import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class TrueFalseOption extends StatelessWidget {
  final String title;
  final bool selected;
  final GestureTapCallback onTap;

  const TrueFalseOption({
    super.key,
    required this.onTap,
    required this.title,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) => _buildContainerWrapper();

  Widget _buildContainerWrapper() => GestureDetector(
        onTap: onTap,
        child: _buildContainer(),
      );
  Widget _buildContainer() => Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color:
              selected ? kcPrimaryColor.withValues(alpha: 0.1) : kcTransparent,
          border: Border.all(
            color:
                selected ? kcPrimaryColor : kcDarkGrey.withValues(alpha: 0.1),
          ),
        ),
        child: _buildLabel(),
      );

  Widget _buildLabel() => Text(
        title,
        style: selected ? style14P400 : style14DG400,
      );
}
