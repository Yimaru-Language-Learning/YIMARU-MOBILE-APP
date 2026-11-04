import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/cancel_practice_sheet.dart';
import 'package:yimaru_app/ui/widgets/custom_circular_progress_indicator.dart';
import 'package:yimaru_app/ui/widgets/page_loading_indicator.dart';

import '../../course_practice_viewmodel.dart';

class IeltsIntroScreen extends ViewModelWidget<CoursePracticeViewModel> {
  final String title;
  final String subtitle;
  final String instructionTitle;
  final String instructionSubtitle;
  final TextEditingController practiceController;

  const IeltsIntroScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.instructionTitle,
    required this.practiceController,
    required this.instructionSubtitle,
  });

  Future<void> _nextScreen(
      {required BuildContext context,
      required CoursePracticeViewModel viewModel}) async {
    viewModel.resetValues();
    practiceController.clear();

    int id = viewModel
            .questions[viewModel.currentQuestion].questionTypeDefinitionId ??
        0;
    if (id == 17 /*IELTS Speaking – Interview*/) {
      String stimulus = viewModel.questions[viewModel.currentQuestion]
              .dynamicPayload?.stimulus?.first.value ??
          '';
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setSpeakingState();
      viewModel.setCountdown(responseFirstSec);
      await viewModel.playVoicePrompt(stimulus);
    } else if (id == 18 /*IELTS Speaking – Cue Card Part 1*/) {
      int stimulusFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.first.value['seconds'];
      viewModel.setCountdown(stimulusFirstSec);
    } else if (id == 20 /*IELTS Speaking – Cue Card Part 2*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      String stimulus = viewModel.questions[viewModel.currentQuestion]
              .dynamicPayload?.stimulus?.first.value ??
          '';
      viewModel.setSpeakingState();
      viewModel.setCountdown(responseFirstSec);
      await viewModel.playVoicePrompt(stimulus);
    } else if (id == 21 /*IELTS Speaking – Discussion*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      String stimulus = viewModel.questions[viewModel.currentQuestion]
              .dynamicPayload?.stimulus?.first.value ??
          '';
      viewModel.setSpeakingState();
      viewModel.setCountdown(responseFirstSec);
      await viewModel.playVoicePrompt(stimulus);
    } else if (id == 26 /*IELTS Writing – Part 1*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      String image = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.first.value;
      await viewModel.cacheNetworkImage(image: image, context: context);
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 27 /*IELTS Writing – Part 2*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    }
    viewModel.nextScreen();
  }

  Future<void> _cancel(CoursePracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.pop();
    viewModel.goBack();
  }

  Future<void> _showSheet(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (cxt) => _buildSheet(viewModel),
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  String _displayTitle(CoursePracticeViewModel viewModel) {
    if (title.isNotEmpty) {
      if (title.toLowerCase().contains('ielts')) return title;
      return 'IELTS $title';
    }
    return 'IELTS Listening';
  }

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(context, viewModel),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 12),
                          // IELTS Heading
                          const Center(
                            child: Text(
                              'IELTS',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Aeonik',
                                color: Color(0xFF1A1A2E),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Practice Card
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border:
                                    Border.all(color: const Color(0xFFEEEEF0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.04),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Soft pink banner with illustration
                                  Container(
                                    width: double.infinity,
                                    height: 180,
                                    color: const Color(0xFFFFEEF0),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/images/08-ielts/8.1-ielts-course-01.svg',
                                        height: 110,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _displayTitle(viewModel),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Aeonik',
                                            color: Color(0xFF1A1A2E),
                                          ),
                                        ),
                                        if (subtitle.isNotEmpty) ...[
                                          const SizedBox(height: 4),
                                          Text(
                                            subtitle,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Aeonik',
                                              color: Color(0xFF888899),
                                            ),
                                          ),
                                        ],
                                        const SizedBox(height: 16),
                                        _buildStartButton(context, viewModel),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              _buildBodyState(viewModel),
            ],
          ),
        ),
      );

  Widget _buildTopBar(
          BuildContext context, CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            GestureDetector(
              onTap: () async =>
                  await _showSheet(context: context, viewModel: viewModel),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFEEEEF0)),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  LocaleKeys.practice_test.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Aeonik',
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 38), // Balance back button
          ],
        ),
      );

  Widget _buildStartButton(
          BuildContext context, CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.cacheImage) ||
              viewModel.busy(StateObjects.coursePracticePrompt)
          ? const Center(
              child: CustomCircularProgressIndicator(
                  color: Color(0xFFE4002B)),
            )
          : GestureDetector(
              onTap: () async =>
                  await _nextScreen(context: context, viewModel: viewModel),
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE4002B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    LocaleKeys.start_assessment.tr(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Aeonik',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );

  Widget _buildBodyState(CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.coursePracticePrompt)
          ? const PageLoadingIndicator()
          : const SizedBox.shrink();
}
