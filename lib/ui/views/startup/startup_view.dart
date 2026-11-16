import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/landing_showcase.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  final String? label;

  const StartupView({Key? key, this.label}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD166), // Brand Yellow #FFD166
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Bar spacer
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: SizedBox(height: 32),
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

            // Bottom White Card with Loading Indicator
            _buildBottomCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomCard(BuildContext context) {
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
          const Text(
            'እንግሊዝኛን ይማሩ',
            style: TextStyle(
              fontFamily: 'Aeonik',
              fontSize: 27,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2A1830), // Ink
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle
          const Text(
            'በማንኛውም ሰዓት፣ በማንኛውም ቦታ፣ በማንኛውም እድሜ።',
            style: TextStyle(
              fontFamily: 'Aeonik',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF5A5060),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 24),

          // Button with loading state
          Container(
            width: double.infinity,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFF8E2483), // Brand Plum
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${label ?? LocaleKeys.loading.tr()} ...',
                  style: const TextStyle(
                    fontFamily: 'Aeonik',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
