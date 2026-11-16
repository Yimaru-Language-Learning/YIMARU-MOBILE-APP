import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/helper_functions.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/cancel_practice_sheet.dart';
import 'package:yimaru_app/ui/widgets/practice_app_bar.dart';

class LearnPracticeDescriptionScreen
    extends ViewModelWidget<LearnPracticeViewModel> {
  const LearnPracticeDescriptionScreen({super.key});

  Future<void> _cancel(LearnPracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.pop();
    viewModel.pop();
  }

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
    final practiceItem = viewModel.practices.isNotEmpty
        ? viewModel.practices.first
        : null;

    final title = practiceItem?.title?.trim().isNotEmpty == true
        ? practiceItem!.title!
        : 'Meet a new classmate';

    final description = practiceItem?.storyDescription?.trim().isNotEmpty == true
        ? practiceItem!.storyDescription!
        : 'Daniel is new in class and wants to chat. Introduce yourself and get to know each other.';

    return Scaffold(
      backgroundColor: const Color(0xFFFAF7FC),
      body: SafeArea(
        child: Column(
          children: [
            PracticeAppBar(
              title: 'Level practice',
              onPop: () async =>
                  await _showSheet(context: context, viewModel: viewModel),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    // Speaking practice chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5EEF7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'SPEAKING PRACTICE',
                        style: TextStyle(
                          fontFamily: 'Aeonik',
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: AppColors.magenta38,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Aeonik',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2A1830),
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Subtitle / Story Description
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Aeonik',
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Illustration Container
                    _buildIllustration(practiceItem?.storyImage),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            // Bottom button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () => viewModel.goTo(2),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.magenta38,
                    foregroundColor: kcWhite,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    LocaleKeys.start_practice.tr(),
                    style: const TextStyle(
                      fontFamily: 'Aeonik',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: kcWhite,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIllustration(String? storyImageUrl) {
    final readableUrl = getReadableUrl(storyImageUrl ?? '') ?? '';

    return Container(
      width: double.infinity,
      height: 240,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7EF),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEDE8F2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: (readableUrl.isNotEmpty && Uri.tryParse(readableUrl)?.hasAbsolutePath == true)
          ? CachedNetworkImage(
              imageUrl: readableUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => _buildDefaultSvgIllustration(),
              errorWidget: (context, url, error) =>
                  _buildDefaultSvgIllustration(),
            )
          : _buildDefaultSvgIllustration(),
    );
  }

  Widget _buildDefaultSvgIllustration() {
    return Center(
      child: SvgPicture.asset(
        'assets/images/Yimaru-Icons-and-Illustrations/02-Illustrations/07-learn-level-speaking-practice/7.2-level-practice-scenario-01.svg',
        fit: BoxFit.contain,
      ),
    );
  }
}
