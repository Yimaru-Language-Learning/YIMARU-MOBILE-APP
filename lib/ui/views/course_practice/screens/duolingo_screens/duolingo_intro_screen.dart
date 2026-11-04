import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/course_practice_app_bar.dart';
import 'package:yimaru_app/ui/widgets/custom_circular_progress_indicator.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/ui_helpers.dart';
import '../../../../widgets/cancel_practice_sheet.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/wave_wrapper.dart';
import '../../course_practice_viewmodel.dart';

class DuolingoIntroScreen extends ViewModelWidget<CoursePracticeViewModel> {
  final String title;
  final String subtitle;
  final CoursePracticeType type;
  final TextEditingController practiceController;

  const DuolingoIntroScreen(
      {super.key,
      required this.type,
      required this.title,
      required this.subtitle,
      required this.practiceController});

  Future<void> _nextScreen(
      {required BuildContext context,
      required CoursePracticeViewModel viewModel}) async {
    viewModel.resetValues();
    practiceController.clear();

    int id = viewModel
            .questions[viewModel.currentQuestion].questionTypeDefinitionId ??
        0;
    if (id == 12 /*Duolingo - Speak about the photo*/) {
      String image = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.last.value;
      int stimulusFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.first.value['seconds'];
      await viewModel.cacheNetworkImage(image: image, context: context);
      viewModel.setCountdown(stimulusFirstSec);
    } else if (id == 13 /*Duolingo - Read then speak*/) {
      int stimulusFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.first.value['seconds'];
      viewModel.setCountdown(stimulusFirstSec);
    } else if (id == 36 /*Duolingo - Speaking sample*/) {
      int stimulusFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.first.value['seconds'];
      viewModel.setCountdown(stimulusFirstSec);
    } else if (id == 14 /*Duolingo - Interactive speaking*/) {
      int stimulusLastSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.first.value['seconds'];
      viewModel.resetSpeakingState();
      viewModel.setCountdown(stimulusLastSec);
    } else if (id == 22 /*Duolingo - Write about the photo*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      String image = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.first.value;
      await viewModel.cacheNetworkImage(image: image, context: context);
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 23 /*Duolingo - Writing sample*/) {
      int stimulusFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.first.value['seconds'];
      viewModel.setCountdown(stimulusFirstSec);
    } else if (id == 24 /*Duolingo - Interactive writing part 1*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 25 /*Duolingo - Interactive writing part 2*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 28 /*Duolingo - Listen and type*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?[0].value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 56 /*Duolingo - Interactive listening part 1*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      String stimulusFirst = viewModel.questions[viewModel.currentQuestion]
              .dynamicPayload?.stimulus?.first.value ??
          '';
      viewModel.setCountdown(responseFirstSec);
      viewModel.setPlayCount();
      await viewModel.playVoicePrompt(stimulusFirst);
    } else if (id == 29 /*Interactive listening part 2*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?[0].value['seconds'];
      viewModel.setCountdown(responseFirstSec);
      viewModel.resetPlayCount(1);
    } else if (id == 57 /*Duolingo - Interactive listening part 3*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 49 /*Duolingo - Read and select*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?[0].value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 3 /*Duolingo - Fill in the blank*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id ==
        51 /*Duolingo - Interactive reading - complete the sentence*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id ==
        52 /*Duolingo - Interactive reading - complete the passage*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id ==
        53 /*Duolingo - Interactive reading - identify the idea*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id ==
        54 /*Duolingo - Interactive reading - title the passage*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id ==
        55 /*Duolingo - Interactive reading - highlight the answer*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 50 /*Duolingo - Read and complete*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    }

    viewModel.nextScreen();
  }

  IconData _getIcon() {
    if (type == CoursePracticeType.speaking) {
      return Icons.waves;
    } else if (type == CoursePracticeType.writing) {
      return Iconsax.pen_add;
    } else if (type == CoursePracticeType.listening) {
      return Icons.hearing;
    } else {
      return Icons.book;
    }
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
        backgroundColor: kcTransparent,
        builder: (cxt) => _buildSheet(viewModel),
      );

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTopBar(context, viewModel),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 12),
                      // Heading
                      const Text(
                        'Duolingo English Test',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Aeonik',
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Main card containing illustration banner, title, and start button
                      _buildPracticeCard(context, viewModel),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
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
              behavior: HitTestBehavior.opaque,
              onTap: () async =>
                  await _showSheet(context: context, viewModel: viewModel),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFEEEEF0),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 20,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  LocaleKeys.practice_test.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Aeonik',
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 42), // Balance back button
          ],
        ),
      );

  Widget _buildPracticeCard(
          BuildContext context, CoursePracticeViewModel viewModel) =>
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFEEEEF0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Banner Illustration
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: const Color(0xFFE2F8DA),
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/07-duolingo-english-test/7.20-det-practice-test-start-01.svg',
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Practice Title
            Text(
              title.isNotEmpty ? title : 'Listen and Type',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
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
            const SizedBox(height: 18),
            // Start Button inside card
            _buildStartButton(context, viewModel),
          ],
        ),
      );

  Widget _buildStartButton(
          BuildContext context, CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.cacheImage) ||
              viewModel.busy(StateObjects.coursePracticePrompt)
          ? const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: CustomCircularProgressIndicator(
                    color: AppColors.chartreuse40),
              ),
            )
          : GestureDetector(
              onTap: () async =>
                  await _nextScreen(context: context, viewModel: viewModel),
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF58CC02),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFF46A302),
                      offset: Offset(0, 3),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    LocaleKeys.start_assessment.tr(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Aeonik',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );
}
