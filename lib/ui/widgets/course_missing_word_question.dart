import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_viewmodel.dart';

class CourseMissingWordQuestion
    extends ViewModelWidget<CoursePracticeViewModel> {
  final bool showNumber;
  final dynamic segment;
  const CourseMissingWordQuestion(
      {super.key, required this.segment, required this.showNumber});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildSentenceWrapper(viewModel);

  Widget _buildSentenceWrapper(CoursePracticeViewModel viewModel) {
    int blank = 1;
    return _buildSentence(blank: blank, viewModel: viewModel);
  }

  Widget _buildSentence(
          {required int blank, required CoursePracticeViewModel viewModel}) =>
      RichText(
        text: TextSpan(
          style: style14MG400.copyWith(height: 1.75),
          children: (segment as List)
              .map<TextSpan>(
                (e) => TextSpan(
                  text: e['type'] == 'text'
                      ? e['value']
                      : ' ${showNumber ? blank++ : ''}_ _ _ _ _ _ _ _ _ _ _ _ ',
                ),
              )
              .toList(),
        ),
      );
}
