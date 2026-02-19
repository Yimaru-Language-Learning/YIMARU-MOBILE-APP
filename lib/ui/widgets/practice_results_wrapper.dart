import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/practice_result_card.dart';

import '../common/app_colors.dart';

class PracticeResultsWrapper extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const PracticeResultsWrapper({super.key, required this.data});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kcPrimaryColor.withOpacity(0.1),
        ),
        child: _buildColumn(),
      );

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() =>
      [_buildTitle(), verticalSpaceSmall, _buildResults()];

  Widget _buildTitle() => Text(
        'Conversation Review',
        style: style16DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildResults() => ListView.separated(
        shrinkWrap: true,
        itemCount: data.length,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildResult(index),
        separatorBuilder: (context, index) => verticalSpaceSmall,
      );

  Widget _buildResult(int index) =>
      PracticeResultCard(index: index + 1, data: data[index]);
}
