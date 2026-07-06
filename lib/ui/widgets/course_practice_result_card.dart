import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/course_practice_answer_card.dart';
import 'package:yimaru_app/ui/widgets/learn_practice_answer_card.dart';

class CoursePracticeResultCard extends StatelessWidget {
  final String question;
  final Map<String, dynamic> answer;

  const CoursePracticeResultCard(
      {super.key, required this.answer, required this.question});

  @override
  Widget build(BuildContext context) => _buildRow();

  Widget _buildQuestion() => Text(
        '${answer['question']}.',
        maxLines: 1,
        style: style14DG400,
      );

  Widget _buildRow() => Row(
        children: _buildRowChildren(),
      );

  List<Widget> _buildRowChildren() => [
        _buildQuestion(),
        horizontalSpaceTiny,
        _buildSampleResponseWrapper(),
        horizontalSpaceSmall,
        _buildActualResponseWrapper()
      ];

  Widget _buildSampleResponseWrapper() =>
      Expanded(child: _buildSampleResponse());

  Widget _buildSampleResponse() => CoursePracticeAnswerCard(
        answer: answer,
        voice: Voice.sample,
        title: LocaleKeys.sample_answer.tr(),
      );

  Widget _buildActualResponseWrapper() =>
      Expanded(child: _buildActualResponse());

  Widget _buildActualResponse() => CoursePracticeAnswerCard(
        answer: answer,
        voice: Voice.recorded,
        title: LocaleKeys.your_answer.tr(),
      );
}
