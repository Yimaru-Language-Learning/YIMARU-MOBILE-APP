import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_viewmodel.dart';

class DuolingoMissingWordQuestion
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoMissingWordQuestion({super.key});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildSentence(viewModel);

  Widget _buildSentence(CoursePracticeViewModel viewModel) => RichText(
    text: TextSpan(
      style:style14MG400,
      children: (viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload
          ?.stimulus
          ?.last
          .value['segments'] as List)
          .map<TextSpan>(
            (e) => TextSpan(
          text: e['type'] == 'text'
              ? e['value']
              : ' __________ ',

        ),
      )
          .toList(),
    ),
  );




}
