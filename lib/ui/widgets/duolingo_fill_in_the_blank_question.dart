import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_viewmodel.dart';

class DuolingoFillInTheBlankQuestion
    extends ViewModelWidget<CoursePracticeViewModel> {
  final int blanks;
  final bool showNumber;
  final dynamic segment;

  const DuolingoFillInTheBlankQuestion(
      {super.key,
      required this.blanks,
      required this.segment,
      required this.showNumber});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildSentence(viewModel);

  Widget _buildSentence(CoursePracticeViewModel viewModel) => RichText(
        text: TextSpan(
          style: style14MG400.copyWith(height: 1.75),
          children: (segment as List)
              .map<TextSpan>(
                (e) => TextSpan(
                    text: e['type'] == 'text'
                        ? e['value']
                        : '${List.filled(blanks, '_').join(' ')} ',
                    style: e['type'] == 'text' ? style14DG400 : style18P600),
              )
              .toList(),
        ),
      );
}
