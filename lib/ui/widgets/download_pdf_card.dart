import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

import '../common/app_colors.dart';
import 'custom_elevated_button.dart';

class DownloadPdfCard extends StatelessWidget {
  final GestureTapCallback? onTap;
  const DownloadPdfCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) => _buildContainer();
  Widget _buildContainer() => Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kcPrimaryColor.withValues(alpha: 0.1),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: _buildColumn(),
      );

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() => [
        verticalSpaceSmall,
        _buildRow(),
        verticalSpaceMedium,
        _buildContinueButton(),
        verticalSpaceSmall,
      ];

  Widget _buildRow() => Row(
        children: [_buildIconWrapper(), horizontalSpaceSmall, _buildSubtitle()],
      );

  Widget _buildIconWrapper() => Container(
        width: 45,
        height: 35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kcPrimaryColor.withValues(alpha: 0.1),
        ),
        child: _buildIcon(),
      );

  Widget _buildIcon() => const Icon(
        Icons.picture_as_pdf_outlined,
        size: 35,
        color: kcPrimaryColor,
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.download_answer.tr(),
        style: style14MG400,
      );

  Widget _buildContinueButton() => CustomElevatedButton(
        height: 55,
        onTap: onTap,
        borderRadius: 12,
        foregroundColor: kcWhite,
        leadingIcon: Icons.download,
        backgroundColor: kcPrimaryColor,
        text: LocaleKeys.download_feedback_pdf.tr(),
      );
}
