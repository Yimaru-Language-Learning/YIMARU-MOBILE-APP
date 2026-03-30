import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/learn_practice_answer_card.dart';


class LearnPracticeResultCard extends ViewModelWidget<LearnPracticeViewModel> {
  final Map<String, dynamic> data;
   const LearnPracticeResultCard(
      {super.key, required this.data});

  @override
  Widget build(BuildContext context,LearnPracticeViewModel viewModel) => _buildColumnWrapper();

  Widget _buildColumnWrapper() => SizedBox(
    height: 100,
    width: double.maxFinite,
    child: _buildColumn(),
  );

  Widget _buildColumn() => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: _buildColumnChildren(),
  );

  List<Widget> _buildColumnChildren() =>
      [_buildQuestion(), verticalSpaceSmall, _buildRow()];

  Widget _buildQuestion() => Text(
    data['question_text'],
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

  Widget _buildSampleResponse() =>
      const LearnPracticeAnswerCard(title: 'Sample Answer' ,object: StateObjects.learnPracticeSample,);

  Widget _buildActualResponseWrapper() =>
      Expanded(child: _buildActualResponse());

  Widget _buildActualResponse() =>
      const LearnPracticeAnswerCard(title: 'Your Answer',object: StateObjects.learnPracticeAnswer,);



}
