import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_viewmodel.dart';

class DuolingoMissingWordQuestion
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoMissingWordQuestion({super.key});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildWrap(viewModel);

  Widget _buildWrap(CoursePracticeViewModel viewModel) => Wrap(
        children: (viewModel.questions[viewModel.currentQuestion].dynamicPayload
                ?.stimulus?.last.value['segments'] as List)
            .map((e) =>
                _buildText(e['type'] == 'text' ? e['value'] : '...........'))
            .toList(),
      );

  Widget _buildText(String text) => Text(
        text,
        style: style14DG400,
      );


}
