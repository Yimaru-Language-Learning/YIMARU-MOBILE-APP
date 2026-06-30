import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:stacked/stacked.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import '../views/course_practice/course_practice_viewmodel.dart';

class CircularCountdownTimer extends ViewModelWidget<CoursePracticeViewModel> {
  final  Function()?  onEnd;
  const CircularCountdownTimer({super.key,this.onEnd});

  @override
  Widget build(BuildContext context,CoursePracticeViewModel viewModel)=> _buildTimerStackWrapper(viewModel);

  Widget _buildTimerStackWrapper(CoursePracticeViewModel viewModel) => SizedBox(
    height: 50,
    child: _buildTimerStack(viewModel),
  );

  Widget _buildTimerStack(CoursePracticeViewModel viewModel) => Stack(
    alignment: Alignment.center,
    children: _buildTimerStackChildren(viewModel),
  );

  List<Widget> _buildTimerStackChildren(CoursePracticeViewModel viewModel) =>
      [_buildTimer(), _buildCountdownTime(viewModel)];

  Widget _buildTimer() => const CircularProgressIndicator(
    value: 1.0,
    strokeWidth: 5,
    color: kcPrimaryColor,
    padding: EdgeInsets.zero,
    constraints: BoxConstraints(minWidth: 50, minHeight: 50),
  );

  Widget _buildCountdownTime(CoursePracticeViewModel viewModel) =>
      TimerCountdown(
        spacerWidth: 0,
        onEnd: onEnd,
        enableDescriptions: false,
        timeTextStyle: style14P600,
        colonsTextStyle: style14P400,
        format: CountDownTimerFormat.minutesSeconds,
        endTime: viewModel.countdown ?? DateTime.now(),
      );


}
