import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/widgets/page_loading_indicator.dart';
import 'package:yimaru_app/ui/widgets/refresh_button.dart';

class AssessmentLoadingScreen extends StatelessWidget {
  final bool isEmpty;
  final bool isLoading;
  final GestureTapCallback? onPop;
  final GestureTapCallback? onTap;

  const AssessmentLoadingScreen({
    super.key,
    this.onTap,
    this.onPop,
    required this.isEmpty,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6E1665),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top bar
            _buildTopBar(),

            // White curved body
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (isEmpty) _buildRefreshButton(),
                    if (isLoading) _buildLoadingState(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(left: 80, top: 14, child: _sparkle(12)),
          Positioned(right: 90, top: 24, child: _sparkle(8)),
          Positioned(left: 170, bottom: 8, child: _sparkle(6)),
          if (onPop != null)
            Positioned(
              left: 0,
              child: GestureDetector(
                onTap: onPop,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.arrow_back_ios_new_rounded,
                        size: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _sparkleDot(10),
            const SizedBox(width: 10),
            _sparkleDot(14),
            const SizedBox(width: 10),
            _sparkleDot(10),
          ],
        ),
        const SizedBox(height: 28),
        const SizedBox(
          width: 58,
          height: 58,
          child: CircularProgressIndicator(
            strokeWidth: 3.5,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.magenta38),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Preparing your assessment...',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.neutral14,
            fontFamily: 'Aeonik',
          ),
        ),
      ],
    );
  }

  Widget _buildRefreshButton() => RefreshButton(onTap: onTap);

  Widget _sparkle(double size) => Icon(
        Icons.star_rounded,
        size: size,
        color: Colors.white.withValues(alpha: 0.35),
      );

  Widget _sparkleDot(double size) => Icon(
        Icons.star_rounded,
        size: size,
        color: AppColors.magenta38.withValues(alpha: 0.4),
      );
}
