import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/cancel_practice_sheet.dart';
import 'package:yimaru_app/ui/widgets/practice_app_bar.dart';
import 'package:yimaru_app/ui/widgets/speaking_partner_image.dart';

class LearnPracticeIntroScreen extends ViewModelWidget<LearnPracticeViewModel> {
  final String title;
  final String label;
  final String? level;
  final String subtitle;
  final LearnPractices practice;
  final TextEditingController phoneNumberController;

  const LearnPracticeIntroScreen({
    super.key,
    this.level,
    required this.label,
    required this.title,
    required this.subtitle,
    required this.practice,
    required this.phoneNumberController,
  });

  Future<void> _practice({
    required BuildContext context,
    required LearnPracticeViewModel viewModel,
  }) async {
    if (viewModel.user?.learn ?? false) {
      viewModel.goTo(1);
    } else {
      if (Platform.isIOS) {
        Map<String, dynamic> data = {'category': 'IELTS'};
        if (viewModel.user?.phoneNumber != null) {
          await viewModel.showPurchaseDialog();
        } else {
          await _showDialog(context: context, viewModel: viewModel);
        }
        await viewModel.iosCheckout(data);
      } else {
        await viewModel.navigateToLearnSubscription();
      }
    }
  }

  Future<void> _showDialog({
    required BuildContext context,
    required LearnPracticeViewModel viewModel,
  }) async {
    if (!context.mounted) return;
    await showDialog(
      context: context,
      builder: (context) => ViewModelBuilder<LearnPracticeViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        disposeViewModel: false,
        builder: (context, model, child) => Container(), // Handled internally
      ),
    );
  }

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

  String _getAppBarTitle() {
    if (practice == LearnPractices.course) {
      return 'Level practice';
    } else if (practice == LearnPractices.module) {
      return 'Module practice';
    } else {
      return 'Lesson practice';
    }
  }

  String _getButtonText() {
    if (practice == LearnPractices.course) {
      return 'Begin level practice';
    } else if (practice == LearnPractices.module) {
      return 'Begin module practice';
    } else {
      return 'Begin lesson practice';
    }
  }

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7FC),
      body: SafeArea(
        child: Column(
          children: [
            PracticeAppBar(
              title: _getAppBarTitle(),
              onPop: () async =>
                  await _showSheet(context: context, viewModel: viewModel),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Spacer(),
                    _buildCenterBadge(),
                    const SizedBox(height: 24),
                    _buildPartnerChip(),
                    const SizedBox(height: 24),
                    _buildHeadline(),
                    const SizedBox(height: 10),
                    _buildSubheadline(),
                    const Spacer(),
                    _buildBottomButton(context, viewModel),
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

  Widget _buildCenterBadge() {
    final displayLevel = (level != null && level!.trim().isNotEmpty)
        ? level!.trim().toUpperCase()
        : 'A1';

    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer halo
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF7EDF8),
            ),
          ),
          // Middle ring
          Container(
            width: 155,
            height: 155,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFEDD5EC),
            ),
          ),
          // Confetti dots
          Positioned(
            top: 24,
            right: 28,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFD166),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 26,
            child: Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF2FB67C),
              ),
            ),
          ),
          // Inner core circle
          if (practice == LearnPractices.course || level != null)
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.magenta38,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.magenta38.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                displayLevel,
                style: const TextStyle(
                  fontFamily: 'Aeonik',
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                  color: kcWhite,
                  letterSpacing: 1.0,
                ),
              ),
            )
          else
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.magenta38,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.magenta38.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const SpeakingPartnerImage(radius: 50),
            ),
        ],
      ),
    );
  }

  Widget _buildPartnerChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEDE8F2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SpeakingPartnerImage(radius: 12),
          const SizedBox(width: 8),
          Text(
            LocaleKeys.daniel.tr(),
            style: const TextStyle(
              fontFamily: 'Aeonik',
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2A1830),
            ),
          ),
          const Text(
            ' · ',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF9CA3AF),
            ),
          ),
          Text(
            LocaleKeys.speaking_partner.tr(),
            style: const TextStyle(
              fontFamily: 'Aeonik',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline() {
    final cleanTitle = (level != null && practice == LearnPractices.course)
        ? "Let's practice Course ${level!.toUpperCase()}"
        : title;

    return Text(
      cleanTitle,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'Aeonik',
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Color(0xFF2A1830),
        height: 1.25,
      ),
    );
  }

  Widget _buildSubheadline() {
    return Text(
      subtitle,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'Aeonik',
        fontSize: 14,
        color: Color(0xFF6B7280),
        height: 1.4,
      ),
    );
  }

  Widget _buildBottomButton(
      BuildContext context, LearnPracticeViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: () async =>
            await _practice(context: context, viewModel: viewModel),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.magenta38,
          foregroundColor: kcWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          _getButtonText(),
          style: const TextStyle(
            fontFamily: 'Aeonik',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: kcWhite,
          ),
        ),
      ),
    );
  }
}
