import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class LearnPracticeTipSection extends StatelessWidget {
  const LearnPracticeTipSection({super.key});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kcBlue.withOpacity(0.1),
        ),
        child: _buildColumn(),
      );

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() =>
      [_buildTitleWrapper(), verticalSpaceTiny, _buildContent()];

  Widget _buildTitleWrapper() => Row(
        children: [_buildLeading(), horizontalSpaceSmall, _buildTitle()],
      );

  Widget _buildLeading() => const Icon(
        Icons.lightbulb_outline_rounded,
        color: kcBlue,
      );

  Widget _buildTitle() => Text(
        'Quick Tip',
        style: style16B600,
      );

  Widget _buildContent() => Text(
        "You can always do better!\nSpeak in full sentences instead of short phrases.\nMaintain a steady pace, not too fast, not too slow.\nUse varied vocabulary to make your answers richer.\nPause naturally instead of using fillers like “um” or “uh”.",
        style: style14B400,
        textAlign: TextAlign.start,
      );
}
