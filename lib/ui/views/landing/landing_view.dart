import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/landing_showcase.dart';

import 'landing_viewmodel.dart';

class LandingView extends StackedView<LandingViewModel> {
  const LandingView({Key? key}) : super(key: key);

  @override
  LandingViewModel viewModelBuilder(BuildContext context) => LandingViewModel();

  @override
  Widget builder(
    BuildContext context,
    LandingViewModel viewModel,
    Widget? child,
  ) {
    final isAmharic = viewModel.currentLanguageCode == 'am';

    return Scaffold(
      backgroundColor: const Color(0xFFFFD166), // Brand Yellow #FFD166
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Bar with Language Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildLanguagePill(context, viewModel),
                ],
              ),
            ),

            // Central Illustration Area (Scales smoothly to fit available space)
            const Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: LandingShowcase(),
                  ),
                ),
              ),
            ),

            // Bottom White Card
            _buildBottomCard(context, viewModel, isAmharic),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguagePill(BuildContext context, LandingViewModel viewModel) {
    return GestureDetector(
      onTap: () => viewModel.toggleLanguage(context),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFC38B60).withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF2A1830).withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.language_rounded,
              size: 15,
              color: Color(0xFF2A1830),
            ),
            const SizedBox(width: 6),
            Text(
              viewModel.currentLanguageCode,
              style: const TextStyle(
                fontFamily: 'Aeonik',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2A1830),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomCard(
    BuildContext context,
    LandingViewModel viewModel,
    bool isAmharic,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        24,
        28,
        24,
        MediaQuery.of(context).padding.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Headline
          Text(
            isAmharic ? 'እንግሊዝኛን ይማሩ' : 'Learn English',
            style: const TextStyle(
              fontFamily: 'Aeonik',
              fontSize: 27,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2A1830), // Ink
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle
          Text(
            isAmharic
                ? 'በማንኛውም ሰዓት፣ በማንኛውም ቦታ፣ በማንኛውም እድሜ።'
                : 'At any time, at any place, at any age.',
            style: const TextStyle(
              fontFamily: 'Aeonik',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF5A5060),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 24),

          // Primary CTA Button: "Get started"
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: viewModel.setFirstTimeInstall,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8E2483), // Brand Plum
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Get started',
                style: TextStyle(
                  fontFamily: 'Aeonik',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
