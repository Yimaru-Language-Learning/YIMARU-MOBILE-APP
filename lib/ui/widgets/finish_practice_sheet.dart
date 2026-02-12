import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_bottom_sheet.dart';

import 'custom_elevated_button.dart';

class FinishPracticeSheet extends StatelessWidget {
  final GestureTapCallback? onTap;
  const FinishPracticeSheet({super.key, this.onTap});

  @override
  Widget build(BuildContext context) => _buildSheetWrapper();

  Widget _buildSheetWrapper() => CustomBottomSheet(
      height: 400, onTap: onTap, child: _buildColumnWrapper());

  Widget _buildColumnWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(),
      );
  Widget _buildColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildSheetChildren(),
      );

  List<Widget> _buildSheetChildren() => [
        verticalSpaceLarge,
        _buildIcon(),
        verticalSpaceMedium,
        _buildMessage(),
        verticalSpaceLarge,
        _buildContinueButton()
      ];

  Widget _buildIcon() => SvgPicture.asset(
        'assets/icons/alert.svg',
        height: 75,
      );

  Widget _buildMessage() => Text(
        'Finish all the practices in the lessons to take this practice',
        style: style16DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildContinueButton() => CustomElevatedButton(
        height: 55,
        onTap: onTap,
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );
}
