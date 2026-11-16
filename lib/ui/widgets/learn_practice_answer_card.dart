import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';

class LearnPracticeAnswerCard extends ViewModelWidget<LearnPracticeViewModel> {
  final Voice voice;
  final String title;
  final Map<String, dynamic> answer;
  final String duration;

  const LearnPracticeAnswerCard({
    super.key,
    required this.voice,
    required this.title,
    required this.answer,
    this.duration = '0:02',
  });

  bool _isPlaying(LearnPracticeViewModel viewModel) {
    return answer['busy_object'] == viewModel.busyObject &&
        viewModel.playing == voice &&
        viewModel.player.state == PlayerState.playing;
  }

  bool _isLoading(LearnPracticeViewModel viewModel) {
    return answer['busy_object'] == viewModel.busyObject &&
        viewModel.playing == voice &&
        viewModel.busy(answer['busy_object']);
  }

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) {
    final playing = _isPlaying(viewModel);
    final loading = _isLoading(viewModel);

    return GestureDetector(
      onTap: () async {
        if (playing) {
          await viewModel.pauseAudio();
        } else {
          await viewModel.playResult(answer: answer, voice: voice);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: const Color(0xFFF5EEF7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: playing ? AppColors.magenta38 : const Color(0xFFE8D9EC),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Play / Pause button
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.magenta38,
              ),
              alignment: Alignment.center,
              child: loading
                  ? const SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Icon(
                      playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
            ),
            const SizedBox(width: 8),
            // Title & Duration
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Aeonik',
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.magenta38,
                    ),
                  ),
                  Text(
                    duration,
                    style: const TextStyle(
                      fontFamily: 'Aeonik',
                      fontSize: 10,
                      color: Color(0xFF8E7E95),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
