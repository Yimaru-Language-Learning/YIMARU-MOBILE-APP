import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_viewmodel.dart';

class IeltsFillInTheBlanksQuestion
    extends ViewModelWidget<CoursePracticeViewModel> {
  final List<dynamic> question;

  const IeltsFillInTheBlanksQuestion({super.key, required this.question});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildSentenceWrapper(viewModel);

  Widget _buildSentenceWrapper(CoursePracticeViewModel viewModel) {
    int blank = 0;
    return _buildSentence(blank: blank, viewModel: viewModel);
  }

  Widget _buildSentence(
          {required int blank, required CoursePracticeViewModel viewModel}) =>
      RichText(
        text: TextSpan(
          style: style14MG400,
          children: question.map<InlineSpan>((e) {
            if (e['type'] == 'text') {
              return _buildText(e['value']);
            }
            blank++;
            return _buildTextFieldSpan(
                blank: blank, value: e['id'], viewModel: viewModel);
          }).toList(),
        ),
      );

  TextSpan _buildText(String text) => TextSpan(
        text: text,
        style: style14MG400.copyWith(height: 1.75),
      );

  WidgetSpan _buildTextFieldSpan(
          {required int blank,
          required String value,
          required CoursePracticeViewModel viewModel}) =>
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: _buildTextFieldWrapper(
            blank: blank, value: value, viewModel: viewModel),
      );

  Widget _buildTextFieldWrapper(
          {required int blank,
          required String value,
          required CoursePracticeViewModel viewModel}) =>
      SizedBox(
        width: 150,
        height: 32,
        child: _buildTextFieldRow(
            blank: blank, value: value, viewModel: viewModel),
      );

  Widget _buildTextFieldRow(
          {required int blank,
          required String value,
          required CoursePracticeViewModel viewModel}) =>
      Row(
        children: [
          _buildBlankNumber(blank),
          _buildTextFieldExpandedWrapper(value: value, viewModel: viewModel)
        ],
      );

  Widget _buildBlankNumber(int blank) => Text(
        '  $blank  ',
        style: style14MG400,
      );

  Widget _buildTextFieldExpandedWrapper(
          {required String value,
          required CoursePracticeViewModel viewModel}) =>
      Expanded(child: _buildTextField(value: value, viewModel: viewModel));

  Widget _buildTextField(
          {required String value,
          required CoursePracticeViewModel viewModel}) =>
      TextField(
        style: style14MG400,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (change) => viewModel.updateAnswer(value, change),
      );
}
