import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_viewmodel.dart';

import '../common/helper_functions.dart';
import '../common/ui_helpers.dart';

class CountdownTimer extends ViewModelWidget<CoursePracticeViewModel> {
  final String? time;
  const CountdownTimer({super.key, this.time});

  Future<void> _stopRecording(CoursePracticeViewModel viewModel)async{
    await viewModel.stopRecording();
    viewModel.setNextButton();
  }
  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildContainer(viewModel);

  Widget _buildContainer(CoursePracticeViewModel viewModel) => Container(
    width: 100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: kcPrimaryColor.withValues(alpha: 0.1),
    ),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    child: _buildRow(viewModel),
  );

  Widget _buildRow(CoursePracticeViewModel viewModel) => Row(
    children: [
      _buildClockIcon(),
      horizontalSpaceTiny,
      _buildCountdownState(viewModel),
    ],
  );


  Widget _buildCountdownState(CoursePracticeViewModel viewModel) => time == null ? _buildCountdownTime(viewModel):_buildCountdownText();

  Widget _buildCountdownText() => Text(
    time ?? '',
    style: style16P600,
    textAlign: TextAlign.center,
  );

  Widget _buildCountdownTime(CoursePracticeViewModel viewModel) =>
      TimerCountdown(
        spacerWidth: 0,
        enableDescriptions: false,
        timeTextStyle: style14P600,
        colonsTextStyle: style14P400,
        format: CountDownTimerFormat.minutesSeconds,
        onEnd:()async => await _stopRecording(viewModel) ,
        endTime: DateTime.now().add(
          Duration(
            minutes: getMinutes(
              viewModel.questions[viewModel.currentQuestion].dynamicPayload
                  ?.stimulus?.last.value['seconds'],
            ),
            seconds: getSeconds(
              viewModel.questions[viewModel.currentQuestion].dynamicPayload
                  ?.stimulus?.last.value['seconds'],
            ),
          ),
        ),
      );

  Widget _buildClockIcon() => const Icon(
    Icons.timer_outlined,
    color: kcPrimaryColor,
  );
}

