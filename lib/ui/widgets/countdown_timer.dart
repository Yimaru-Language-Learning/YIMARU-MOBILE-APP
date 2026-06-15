import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

import '../common/ui_helpers.dart';

class CountdownTimer extends StatelessWidget {
  final String? time;
  final DateTime? duration;
  final GestureTapCallback? onEnd;

  const CountdownTimer({super.key, this.time, this.onEnd, this.duration});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: kcPrimaryColor.withValues(alpha: 0.1),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: _buildRow(),
      );

  Widget _buildRow() => Row(
        children: [
          _buildClockIcon(),
          horizontalSpaceTiny,
          _buildCountdownState(),
        ],
      );

  Widget _buildCountdownState() =>
      time == null ? _buildCountdownTime() : _buildCountdownText();

  Widget _buildCountdownText() => Text(
        time ?? '',
        style: style16P600,
        textAlign: TextAlign.center,
      );

  Widget _buildCountdownTime() => TimerCountdown(
        onEnd: onEnd,
        spacerWidth: 0,
        enableDescriptions: false,
        timeTextStyle: style14P600,
        colonsTextStyle: style14P400,
        endTime: duration ?? DateTime.now(),
        format: CountDownTimerFormat.minutesSeconds,
      );

  Widget _buildClockIcon() => const Icon(
        Icons.timer_outlined,
        color: kcPrimaryColor,
      );
}
