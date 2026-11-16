import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/learn_practice_answer_card.dart';

class LearnPracticeResultCard extends ViewModelWidget<LearnPracticeViewModel> {
  final Map<String, dynamic> answer;
  final int itemIndex;

  const LearnPracticeResultCard({
    super.key,
    required this.answer,
    this.itemIndex = 0,
  });

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) {
    final recordedVoice = answer['recorded_voice_answer'] as String?;
    final hasRecorded = recordedVoice != null && recordedVoice.trim().isNotEmpty;
    
    // Determine status color: 
    // item 0: Green, item 1: Orange, others or no recorded voice: Red
    Color dotColor = const Color(0xFF2FB67C);
    if (!hasRecorded) {
      dotColor = const Color(0xFFEF4444);
    } else if (itemIndex == 1) {
      dotColor = const Color(0xFFF59E0B);
    }

    final questionText = answer['question_text'] as String? ?? 'Question';
    final numberedQuestion = '${itemIndex + 1}. $questionText';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question header with status dot
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: dotColor,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  numberedQuestion,
                  style: const TextStyle(
                    fontFamily: 'Aeonik',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2A1830),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Audio pills or No answer detected state
          if (hasRecorded)
            Row(
              children: [
                Expanded(
                  child: LearnPracticeAnswerCard(
                    voice: Voice.sample,
                    title: LocaleKeys.sample_answer.tr(),
                    answer: answer,
                    duration: '0:02',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: LearnPracticeAnswerCard(
                    voice: Voice.recorded,
                    title: 'Your response',
                    answer: answer,
                    duration: '0:02',
                  ),
                ),
              ],
            )
          else ...[
            const Padding(
              padding: EdgeInsets.only(left: 18),
              child: Text(
                'No answer detected.',
                style: TextStyle(
                  fontFamily: 'Aeonik',
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFFEF4444),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 18),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF5F5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFFED7D7)),
              ),
              child: const Text(
                'Suggestion: you can use "I am a student" or "I work as ..."',
                style: TextStyle(
                  fontFamily: 'Aeonik',
                  fontSize: 12,
                  color: Color(0xFFB91C1C),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
