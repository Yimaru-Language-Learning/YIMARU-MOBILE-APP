import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/learn_practice_answer_card.dart';

class LearnPracticeResultCard extends ViewModelWidget<LearnPracticeViewModel> {
  final Map<String, dynamic> answer;

  const LearnPracticeResultCard({super.key, required this.answer});

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) =>
      _buildColumnWrapper(viewModel);

  Widget _buildColumnWrapper(LearnPracticeViewModel viewModel) => SizedBox(
        height: 125,
        width: double.maxFinite,
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LearnPracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(LearnPracticeViewModel viewModel) =>
      [_buildQuestion(viewModel), verticalSpaceSmall, _buildRow()];

  Widget _buildQuestion(LearnPracticeViewModel viewModel) => Text(
        answer['question_text'],
        maxLines: 2,
        style: style14DG400,
      );

  Widget _buildRow() => Row(
        children: _buildRowChildren(),
      );

  List<Widget> _buildRowChildren() => [
        _buildSampleResponseWrapper(),
        horizontalSpaceSmall,
        _buildActualResponseWrapper()
      ];

  Widget _buildSampleResponseWrapper() =>
      Expanded(child: _buildSampleResponse());

  Widget _buildSampleResponse() => LearnPracticeAnswerCard(
        answer: answer,
        voice: Voice.sample,
        title: 'Sample Answer',
      );

  Widget _buildActualResponseWrapper() =>
      Expanded(child: _buildActualResponse());

  Widget _buildActualResponse() => LearnPracticeAnswerCard(
        answer: answer,
        title: 'Your Answer',
        voice: Voice.recorded,
      );
}
