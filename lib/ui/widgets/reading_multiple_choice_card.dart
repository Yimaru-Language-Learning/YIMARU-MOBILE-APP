import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_small_leading_radio_button.dart';

import 'custom_small_trailing_radio_button.dart';

class ReadingMultipleChoiceCard
    extends ViewModelWidget<CoursePracticeViewModel> {
  final String number;
  final String question;
  final List<dynamic> choice;

  const ReadingMultipleChoiceCard(
      {super.key,
      required this.choice,
      required this.number,
      required this.question});

  void _onTap({
    required Map<String, dynamic> answer,
    required CoursePracticeViewModel viewModel,
  }) {
    viewModel.setSelectedChoice(number: number, answer: answer);
  }

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildContainer(viewModel);

  Widget _buildContainer(CoursePracticeViewModel viewModel) => Container(
        width: double.maxFinite,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildQuestionColumnChildren(viewModel),
      );

  List<Widget> _buildQuestionColumnChildren(
          CoursePracticeViewModel viewModel) =>
      [
        verticalSpaceTiny,
        _buildText(),
        verticalSpaceMedium,
        _buildOptions(viewModel)
      ];

  Widget _buildText() => Text(
        question,
        style: style14DG400,
      );

  Widget _buildOptions(CoursePracticeViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (viewModel.questions[viewModel.currentQuestion]
                .dynamicPayload?.response?.last.value['options'] as List)
            .length,
        itemBuilder: (context, index) => _buildOption(
          title: viewModel.questions[viewModel.currentQuestion].dynamicPayload
              ?.response?.last.value['options'][index]['text'],
          onTap: () => _onTap(
              answer: viewModel.questions[viewModel.currentQuestion]
                  .dynamicPayload?.response?.last.value['options'][index],
              viewModel: viewModel),
          selected: viewModel.isSelectedChoice(
              number: number,
              answer: viewModel.questions[viewModel.currentQuestion]
                  .dynamicPayload?.response?.last.value['options'][index]),
        ),
      );

  Widget _buildOption({
    required String title,
    required bool selected,
    required GestureTapCallback onTap,
  }) =>
      CustomSmallLeadingRadioButton(
          onTap: onTap, title: title, selected: selected);
}
