import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/speaking_partner_image.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_bottom_sheet.dart';
import 'custom_elevated_button.dart';

class CancelLearnPracticeSheet extends StatelessWidget {
  final String user;
  final GestureTapCallback? onClose;
  final GestureTapCallback? onCancel;
  final GestureTapCallback? onContinue;

  const CancelLearnPracticeSheet(
      {super.key,
      this.onClose,
      this.onCancel,
      this.onContinue,
      required this.user});

  @override
  Widget build(BuildContext context) => _buildSheetWrapper();

  Widget _buildSheetWrapper() => CustomBottomSheet(
      height: 500, onTap: onClose, child: _buildColumnWrapper());

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
        TextSpan(
            text: '${LocaleKeys.almost_there.tr()},',
            style: style18DG700,
            children: [
              TextSpan(
                text: '  $user',
                style: style18P600,
              )
            ]),
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.finish_session.tr(),
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildContinueButton() => CustomElevatedButton(
        height: 55,
        onTap: onContinue,
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        text: LocaleKeys.continue_practice.tr(),
      );

  Widget _buildEndButton() => CustomElevatedButton(
        height: 55,
        onTap: onCancel,
        borderRadius: 12,
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
        text: LocaleKeys.end_session.tr(),
      );
}
