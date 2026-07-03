import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_viewmodel.dart';

class ParagraphOptionCard extends ViewModelWidget<CoursePracticeViewModel> {
  final String number;
  final String question;
  final List<dynamic> choice;

  const ParagraphOptionCard(
      {super.key,
      required this.choice,
      required this.number,
      required this.question});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildButtonWrapper(viewModel);

  Widget _buildButtonWrapper(CoursePracticeViewModel viewModel) => Container(
    height: 150,
        width: double.maxFinite,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: kcVeryLightGrey),
          color: kcVeryLightGrey.withValues(alpha: 0.25),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: _buildRow(viewModel),
      );

  Widget _buildRow(CoursePracticeViewModel viewModel) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildRowChildren(viewModel),
      );

  List<Widget> _buildRowChildren(CoursePracticeViewModel viewModel) => [
        _buildNumberWrapper(),
        horizontalSpaceSmall,
        _buildQuestionColumnWrapper(viewModel)
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

  Widget _buildQuestionColumnWrapper(CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildQuestionColumn(viewModel));

  Widget _buildQuestionColumn(CoursePracticeViewModel viewModel) => Column(
        children: [_buildTextWrapper(), _buildDropdown(viewModel)],
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
        width: double.maxFinite,
        textStyle: style14MG400,
        hintText: 'Choose paragraph',
        initialSelection: viewModel.selectedOption.isNotEmpty
            ? viewModel.selectedOption.containsKey(number)
                ? viewModel.selectedOption[number][number]
                : ''
            : '',
        onSelected: (value) {
          Map<String, dynamic> answer = {number: value};
          viewModel.setSelectedChoice(number: number, answer: answer);
        },
        inputDecorationTheme: InputDecorationTheme(
          //isDense: true,
          border: dropdownBorder,
          enabledBorder: dropdownBorder,
          focusedBorder: dropdownBorder,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 5, vertical: 7.5),
        ),
        dropdownMenuEntries: choice
            .map((e) => e['text'])
            .map(
              (option) => DropdownMenuEntry<String>(
                value: option,
                label: option,
              ),
            )
            .toList(),
      );
}
