import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_bottom_sheet.dart';

import 'custom_elevated_button.dart';

class FinishPracticeSheet extends StatelessWidget {
  final PracticeReason practice;
  final GestureTapCallback? onTap;

  const FinishPracticeSheet({super.key, this.onTap, required this.practice});

  String getWarning() {
    if (practice == PracticeReason.lesson) {
      return LocaleKeys.finish_all_practice_lesson.tr();
    } else if (practice == PracticeReason.module) {
      return LocaleKeys.finish_all_practice_module.tr();
    } else if (practice == PracticeReason.previousUnit) {
      return LocaleKeys.finish_all_practice_previouse_module.tr();
    }
    if (practice == PracticeReason.previousModule) {
      return LocaleKeys.finish_all_practice_previouse_module.tr();
    } else if (practice == PracticeReason.previousCourse) {
      return LocaleKeys.finish_all_practice_previouse_course.tr();
    } else {
      return LocaleKeys.finish_all_practice_course.tr();
    }
  }

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
        getWarning(),
        style: style16DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildContinueButton() => CustomElevatedButton(
        height: 55,
        onTap: onTap,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: LocaleKeys.cont.tr(),
        backgroundColor: kcPrimaryColor,
      );
}
