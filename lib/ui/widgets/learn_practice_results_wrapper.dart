import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/learn_practice_result_card.dart';

import '../common/app_colors.dart';

class LearnPracticeResultsWrapper extends StatelessWidget {
  final Map<String, dynamic> data;

  const LearnPracticeResultsWrapper({super.key, required this.data});

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
      [_buildTitle(), verticalSpaceSmall, if (data.isNotEmpty) _buildResult()];

  Widget _buildTitle() => Text(
        'Conversation Review',
        style: style16DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildResult() => LearnPracticeResultCard(data: data);
}
