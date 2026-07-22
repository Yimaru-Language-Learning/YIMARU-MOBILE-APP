import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_viewmodel.dart';

class IeltsFillInTheBlanksQuestion extends ViewModelWidget<CoursePracticeViewModel> {
  final List<dynamic> question;

  const IeltsFillInTheBlanksQuestion({super.key, required this.question});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildSentence(viewModel);

  Widget _buildSentence(CoursePracticeViewModel viewModel) => RichText(
        text: TextSpan(
          style: style14MG400,
          children: question.map<InlineSpan>((e) {
            if (e['type'] == 'text') {
              return _buildText(e['value']);
            }

            return _buildTextFieldSpan(value: e['id'], viewModel: viewModel);
          }).toList(),
        ),
      );

  TextSpan _buildText(String text) => TextSpan(
        text: text,
        style: style14MG400.copyWith(height: 1.75),
      );

  WidgetSpan _buildTextFieldSpan(
          {required String value,
          required CoursePracticeViewModel viewModel}) =>
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: _buildTextFieldWrapper(value: value, viewModel: viewModel),
      );

  Widget _buildTextFieldWrapper(
          {required String value,
          required CoursePracticeViewModel viewModel}) =>
      SizedBox(
        width: 100,
        height: 32,
        child: _buildTextField(value: value, viewModel: viewModel),
      );

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
