import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class IeltsListeningInstructionCard extends StatelessWidget {
  const IeltsListeningInstructionCard({super.key});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        height: 175,
        width: double.maxFinite,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kcDarkGrey.withValues(alpha: 0.1)),
        ),
        child: _buildColumn(),
      );

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() =>
      [_buildInstructionWrapper(), _buildDividerWrapper(), _buildRow()];

  Widget _buildInstructionWrapper() => Row(
        children: [
          _buildWarningIconWrapper(),
          horizontalSpaceSmall,
          _buildInstructionExpandedWrapper()
        ],
      );

  Widget _buildWarningIconWrapper() => CircleAvatar(
        backgroundColor: kcPrimaryColor.withValues(alpha: 0.25),
        child: _buildWarningIcon(),
      );

  Widget _buildWarningIcon() => const Icon(
        Icons.warning_amber_rounded,
        color: kcPrimaryColor,
      );

  Widget _buildInstructionExpandedWrapper() =>
      Expanded(child: _buildInstruction());

  Widget _buildInstruction() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildInstructionChildren(),
      );

  List<Widget> _buildInstructionChildren() =>
      [_buildTitle(), verticalSpaceTiny, _buildSubtitle()];

  Widget _buildTitle() => Text(
        LocaleKeys.important_instruction.tr(),
        style: style16DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => RichText(
        text: TextSpan(
          style: style14DG400,
          children: [
            TextSpan(
              style: style14MG400,
              text: LocaleKeys.will_hear_audio.tr(),
            ),
            TextSpan(
              style: style12R700,
              text: LocaleKeys.one_time_only.tr(),
            ),
            TextSpan(
              style: style14MG400,
              text: LocaleKeys.replay_for_tutorial.tr(),
            ),
          ],
        ),
      );

  Widget _buildDividerWrapper() => Expanded(child: _buildDivider());

  Widget _buildDivider() => const Divider(color: kcVeryLightGrey);

  Widget _buildRow() => Row(
        children: [_buildHeadsetIcon(), horizontalSpaceSmall, _buildWarning()],
      );

  Widget _buildHeadsetIcon() => const Icon(
        Icons.headset_mic_rounded,
        color: kcPrimaryColor,
      );

  Widget _buildWarning() => Text(
        LocaleKeys.wear_headphones.tr(),
        style: style14P600,
      );
}
