import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/practice_response_card.dart';

class PracticeResultCard extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;
  const PracticeResultCard(
      {super.key, required this.index, required this.data});

  @override
  Widget build(BuildContext context) => _buildColumnWrapper();

  Widget _buildColumnWrapper() => SizedBox(height: 100,width: double.maxFinite,child: _buildColumn(),);

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() => [_buildQuestion(),verticalSpaceSmall, _buildRow()];

  Widget _buildQuestion() => Text(
        '$index. ${data['question']}',
        style: style14DG400,
      );

  Widget _buildRow() => Row(
        children: _buildRowChildren(),
      );

  List<Widget> _buildRowChildren() =>
      [_buildSampleResponseWrapper(),horizontalSpaceSmall, _buildActualResponseWrapper()];

  Widget _buildSampleResponseWrapper() =>
      Expanded(child: _buildSampleResponse());

  Widget _buildSampleResponse() =>
      const PracticeResponseCard(title: 'Sample Answer', subtitle: '0:54');

  Widget _buildActualResponseWrapper() =>
      Expanded(child: _buildActualResponse());

  Widget _buildActualResponse() =>
      const PracticeResponseCard(title: 'Sample Answer', subtitle: '0:54');
}
