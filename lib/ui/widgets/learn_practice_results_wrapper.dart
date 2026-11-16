import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/learn_practice_result_card.dart';

class LearnPracticeResultsWrapper
    extends ViewModelWidget<LearnPracticeViewModel> {
  const LearnPracticeResultsWrapper({super.key});

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEDE8F2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Text(
            LocaleKeys.conversation_review.tr(),
            style: const TextStyle(
              fontFamily: 'Aeonik',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2A1830),
            ),
          ),
          const SizedBox(height: 16),
          // Answers list
          if (viewModel.answers.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'No recorded questions to review.',
                style: TextStyle(
                  fontFamily: 'Aeonik',
                  fontSize: 13,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.answers.length,
              itemBuilder: (context, index) => LearnPracticeResultCard(
                answer: viewModel.answers[index],
                itemIndex: index,
              ),
            ),
        ],
      ),
    );
  }
}
