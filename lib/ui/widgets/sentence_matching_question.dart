import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_viewmodel.dart';

import '../common/app_constants.dart';

class SentenceMatchingQuestion
    extends ViewModelWidget<CoursePracticeViewModel> {
  final String number;
  final String question;

  const SentenceMatchingQuestion(
      {super.key, required this.number, required this.question});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildButtonWrapper(viewModel);

  Widget _buildButtonWrapper(CoursePracticeViewModel viewModel) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: _buildRow(viewModel),
      );

  Widget _buildRow(CoursePracticeViewModel viewModel) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildRowChildren(viewModel),
      );

  List<Widget> _buildRowChildren(CoursePracticeViewModel viewModel) => [
        _buildNumberWrapper(),
        horizontalSpaceSmall,
        _buildTextWrapper(),
        horizontalSpaceSmall,
        _buildDropdown(viewModel)
      ];

  Widget _buildNumberWrapper() => Container(
        width: 25,
        height: 25,
        margin: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: kcPrimaryColor.withValues(alpha: 0.1),
        ),
        child: _buildNumber(),
      );

  Widget _buildNumber() => Text(
        number,
        style: style14DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildTextWrapper() => Expanded(
        child: _buildText(),
      );

  Widget _buildText() => Text(
        question,
        style: style14DG400,
      );

  Widget _buildDropdown(CoursePracticeViewModel viewModel) =>
      DropdownMenu<String?>(
        width: 50,
        textStyle: style14MG400,
        initialSelection: viewModel.selectedOption.isNotEmpty
            ? viewModel.selectedOption.containsKey(question)
                ? viewModel.selectedOption[question][question]
                : ''
            : '',
        onSelected: (value) {
          Map<String, dynamic> answer = {number: value};
          viewModel.setSelectedChoice(number: number, answer: answer);
        },
        showTrailingIcon: false,
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          filled: true,
          border: dropdownBorder,
          enabledBorder: dropdownBorder,
          focusedBorder: dropdownBorder,
          fillColor: viewModel.selectedOption.containsKey(number)
              ? kcPrimaryColor.withValues(alpha: 0.1)
              : kcTransparent,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
        ),
        dropdownMenuEntries: alphabet.entries
            .take(viewModel.questions[viewModel.currentQuestion].dynamicPayload
                ?.response?.last.value['options'].length)
            .map((k) => k.value)
            .map(
              (option) => DropdownMenuEntry<String>(
                value: option,
                label: option,
              ),
            )
            .toList(),
      );
}
