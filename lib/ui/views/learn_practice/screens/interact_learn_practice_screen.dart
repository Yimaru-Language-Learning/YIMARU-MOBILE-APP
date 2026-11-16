import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/practice_question.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/cancel_practice_sheet.dart';
import 'package:yimaru_app/ui/widgets/custom_circular_progress_indicator.dart';
import 'package:yimaru_app/ui/widgets/practice_app_bar.dart';
import 'package:yimaru_app/ui/widgets/speaking_partner_image.dart';

class InteractLearnPracticeScreen
    extends ViewModelWidget<LearnPracticeViewModel> {
  final int index;
  final PracticeQuestion question;

  const InteractLearnPracticeScreen({
    super.key,
    required this.index,
    required this.question,
  });

  Future<void> _cancel(LearnPracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.pop();
    viewModel.pop();
  }

  void _reply(LearnPracticeViewModel viewModel) =>
      viewModel.replayVoicePrompt(question);

  Future<void> _stop(LearnPracticeViewModel viewModel) async =>
      await viewModel.nextQuestion(index: index, question: question);

  Future<void> _showSheet({
    required BuildContext context,
    required LearnPracticeViewModel viewModel,
  }) async =>
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: kcTransparent,
        builder: (cxt) => CancelPracticeSheet(
          onClose: viewModel.pop,
          onContinue: viewModel.pop,
          user: viewModel.user?.firstName ?? '',
          onCancel: () async => await _cancel(viewModel),
        ),
      );

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) {
    final totalQuestions =
        viewModel.questions.isEmpty ? 1 : viewModel.questions.length;
    final progress = index / totalQuestions;
    final isRecording =
        viewModel.recordingState == VoiceRecordingState.recording;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF7FC),
      body: SafeArea(
        child: Column(
          children: [
            PracticeAppBar(
              title: LocaleKeys.practice_speaking.tr(),
              progress: progress,
              onPop: () async =>
                  await _showSheet(context: context, viewModel: viewModel),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    // Header Status Title
                    Text(
                      isRecording
                          ? "${LocaleKeys.you_are_speaking.tr()}..."
                          : "${LocaleKeys.daniel.tr()} ${LocaleKeys.speaking.tr()}...",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Aeonik',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2A1830),
                      ),
                    ),
                    const Spacer(),
                    // Central graphic
                    if (isRecording)
                      _buildUserSpeakingVisualizer(viewModel)
                    else
                      _buildPartnerSpeakingVisualizer(viewModel),
                    const Spacer(),
                    // Action label
                    Text(
                      isRecording
                          ? "Tap the check mark to finish speaking"
                          : LocaleKeys.tap_microphone.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Aeonik',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Bottom Controls Row
                    _buildControlsRow(context, viewModel, isRecording),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPartnerSpeakingVisualizer(LearnPracticeViewModel viewModel) {
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer lavender wave ring
          Container(
            width: 210,
            height: 210,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF7EDF8),
            ),
          ),
          // Middle lavender wave ring
          Container(
            width: 160,
            height: 160,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFEDD5EC),
            ),
          ),
          // Avatar container
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kcWhite,
              boxShadow: [
                BoxShadow(
                  color: AppColors.magenta38.withValues(alpha: 0.18),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(4),
            child: const ClipOval(
              child: SpeakingPartnerImage(radius: 46),
            ),
          ),
          // Sound wave bars overlay below partner
          Positioned(
            bottom: 45,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.magenta38,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildWaveBar(8),
                  const SizedBox(width: 2),
                  _buildWaveBar(14),
                  const SizedBox(width: 2),
                  _buildWaveBar(18),
                  const SizedBox(width: 2),
                  _buildWaveBar(12),
                  const SizedBox(width: 2),
                  _buildWaveBar(16),
                  const SizedBox(width: 2),
                  _buildWaveBar(8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaveBar(double height) {
    return Container(
      width: 2.5,
      height: height,
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildUserSpeakingVisualizer(LearnPracticeViewModel viewModel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Large Purple Equalizer graphic
        Container(
          height: 110,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildEqualizerBar(36),
              _buildEqualizerBar(58),
              _buildEqualizerBar(96),
              _buildEqualizerBar(74),
              _buildEqualizerBar(44),
              _buildEqualizerBar(32),
              _buildEqualizerBar(52),
              _buildEqualizerBar(80),
              _buildEqualizerBar(60),
              _buildEqualizerBar(36),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Faint lavender reflection wave
        SvgPicture.asset(
          'assets/images/Yimaru-Icons-and-Illustrations/02-Illustrations/07-learn-level-speaking-practice/7.6-level-practice-you-are-speaking-01.svg',
          width: 240,
          height: 36,
        ),
      ],
    );
  }

  Widget _buildEqualizerBar(double height) {
    return Container(
      width: 14,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.magenta38,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildControlsRow(
    BuildContext context,
    LearnPracticeViewModel viewModel,
    bool isRecording,
  ) {
    final isBusy = viewModel.busy(StateObjects.learnPracticeQuestion) ||
        viewModel.busy(StateObjects.finishLearnPracticeQuestion) ||
        viewModel.busy(StateObjects.recordLearnPracticeAnswer);

    if (isBusy) {
      return const SizedBox(
        height: 72,
        child: Center(
          child: CustomCircularProgressIndicator(color: AppColors.magenta38),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Action (Replay when not recording, or spacer when recording)
        if (!isRecording)
          GestureDetector(
            onTap: () => _reply(viewModel),
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: 72,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.replay_rounded,
                    size: 26,
                    color: Color(0xFF6B7280),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    LocaleKeys.reply.tr(),
                    style: const TextStyle(
                      fontFamily: 'Aeonik',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          const SizedBox(width: 72),

        // Center Primary Action: Mic or Green Check
        if (!isRecording)
          GestureDetector(
            onTap: () async => await viewModel.startRecording(),
            child: Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.magenta38,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.magenta38.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.mic_rounded,
                size: 34,
                color: kcWhite,
              ),
            ),
          )
        else
          GestureDetector(
            onTap: () async => await _stop(viewModel),
            child: Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2FB67C),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2FB67C).withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.check_rounded,
                size: 36,
                color: kcWhite,
              ),
            ),
          ),

        // Right Action: Cancel
        GestureDetector(
          onTap: () async =>
              await _showSheet(context: context, viewModel: viewModel),
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            width: 72,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.close_rounded,
                  size: 26,
                  color: Color(0xFFEF4444),
                ),
                const SizedBox(height: 4),
                Text(
                  LocaleKeys.cancel.tr(),
                  style: const TextStyle(
                    fontFamily: 'Aeonik',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFEF4444),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
