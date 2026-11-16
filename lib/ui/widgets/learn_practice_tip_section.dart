import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';

class LearnPracticeTipSection extends ViewModelWidget<LearnPracticeViewModel> {
  const LearnPracticeTipSection({super.key});

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) {
    final backendTip = viewModel.practices.firstOrNull?.quickTips;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F7FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFDCE6FA), width: 1.5),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with lightbulb
          Row(
            children: [
              const Text('💡', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                LocaleKeys.quick_tip.tr(),
                style: const TextStyle(
                  fontFamily: 'Aeonik',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'You can always do better!',
            style: TextStyle(
              fontFamily: 'Aeonik',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2563EB),
            ),
          ),
          const SizedBox(height: 10),

          if (backendTip != null && backendTip.trim().isNotEmpty)
            Text(
              backendTip,
              style: const TextStyle(
                fontFamily: 'Aeonik',
                fontSize: 13,
                height: 1.45,
                color: Color(0xFF374151),
              ),
            )
          else ...[
            _buildBulletPoint('Speak in full sentences instead of short phrases.'),
            _buildBulletPoint('Keep a steady pace, not too fast and not too slow.'),
            _buildBulletPoint('Use varied vocabulary to make your answers richer.'),
            _buildBulletPoint('Pause naturally instead of using fillers like "um" or "uh".'),
          ],
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4B5563),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Aeonik',
                fontSize: 13,
                height: 1.4,
                color: Color(0xFF4B5563),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
