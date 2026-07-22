import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class IeltsListeningInstructionCard extends StatelessWidget {
  const IeltsListeningInstructionCard({super.key});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
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
        children: [_buildWarningIconWrapper(), _buildInstruction()],
      );

  Widget _buildWarningIconWrapper() => CircleAvatar(
        backgroundColor: kcPrimaryColor.withValues(alpha: 0.25),
        child: _buildWarningIcon(),
      );

  Widget _buildWarningIcon() => const Icon(
        Icons.warning_amber_rounded,
        color: kcPrimaryColor,
      );

  Widget _buildInstruction() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildInstructionChildren(),
      );

  List<Widget> _buildInstructionChildren() => [_buildTitle(), _buildSubtitle()];

  Widget _buildTitle() => Text(
        'Important Instruction',
        style: style16DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => RichText(
        text: TextSpan(
          style: style14DG400,
          children: [
            TextSpan(
                style: style14MG400, text: 'You will hear an audio recording'),
            TextSpan(
              style: style12R700,
              text: 'one time only during the exam',
            ),
            TextSpan(
              style: style14MG400,
              text: ' You can replay here for tutorial purposes.',
            ),
          ],
        ),
      );

  Widget _buildDividerWrapper() => Expanded(child: _buildDivider());

  Widget _buildDivider() => const Divider(color: kcVeryLightGrey);

  Widget _buildRow() => Row(
        children: [_buildHeadsetIcon(), _buildWarning()],
      );

  Widget _buildHeadsetIcon() => const Icon(
        Icons.headset_mic_rounded,
        color: kcPrimaryColor,
      );

  Widget _buildWarning() => Text(
        'Please wear headphones for best quality.',
        style: style14P600,
      );
}
