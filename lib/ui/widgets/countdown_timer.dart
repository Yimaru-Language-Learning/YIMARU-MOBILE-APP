import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

import '../common/ui_helpers.dart';

class CountdownTimer extends StatelessWidget {
  const CountdownTimer({super.key});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: kcPrimaryColor.withValues(alpha: 0.1),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: _buildRow(),
      );

  Widget _buildRow() => Row(
        children: [
          _buildClockIcon(),
          horizontalSpaceTiny,
          _buildCountdownTime(),
        ],
      );

  Widget _buildCountdownTime() => Text(
        '0:20',
        style: style16P600,
        textAlign: TextAlign.center,
      );

  Widget _buildClockIcon() => const Icon(
        Icons.timer_outlined,
        color: kcPrimaryColor,
      );
}
