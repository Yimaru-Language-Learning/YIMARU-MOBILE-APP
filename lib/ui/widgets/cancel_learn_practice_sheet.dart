import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yimaru_app/ui/widgets/speaking_partner_image.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_bottom_sheet.dart';
import 'custom_elevated_button.dart';

class CancelLearnPracticeSheet extends StatelessWidget {
  final GestureTapCallback? onTap;

  const CancelLearnPracticeSheet({super.key, this.onTap});

  @override
  Widget build(BuildContext context) => _buildSheetWrapper();

  Widget _buildSheetWrapper() => CustomBottomSheet(
      height: 500, onTap: onTap, child: _buildColumnWrapper());

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
        _buildImage(),
        verticalSpaceMedium,
        _buildMessage(),
        _buildSubtitle(),
        verticalSpaceLarge,
        _buildContinueButton(),
        _buildEndButton(),

  ];

  Widget _buildImage() => const SpeakingPartnerImage(
        radius: 45,
      );

  Widget _buildMessage() => Text.rich(
        TextSpan(text: 'You’re almost there,', style: style18DG600, children: [
          TextSpan(
            text: '  Johnny!',
            style: style18P600,
          )
        ]),
      );

  Widget _buildSubtitle() => Text(
        'Finish this session to see your progress.',
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildContinueButton() => CustomElevatedButton(
        height: 55,
        onTap: onTap,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: 'Continue Practice',
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildEndButton() => CustomElevatedButton(
        height: 55,
        onTap: onTap,
        borderRadius: 12,
        text: 'End Session',
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
      );
}
