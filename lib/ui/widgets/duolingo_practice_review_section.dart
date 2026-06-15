import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';

class DuolingoPracticeReviewSection extends StatelessWidget {
  final String review;
  final GestureTapCallback? onTap;
  const DuolingoPracticeReviewSection({super.key, this.onTap,required this.review});

  @override
  Widget build(BuildContext context) => _buildReviewContainer();

  Widget _buildReviewContainer() => Container(
        width: double.maxFinite,
        color: kcDeepGreen.withValues(alpha: 0.1),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: _buildReviewColumn(),
      );

  Widget _buildReviewColumn() => Column(
        children: [
          _buildTitle(),
          verticalSpaceMedium,
          _buildSampleAnswer(),
          verticalSpaceMedium,
          _buildContinueButton(),
          verticalSpaceMedium,
        ],
      );
  Widget _buildTitle() => Text(
        'Review Sample Answer:',
        style: style18G700,
        textAlign: TextAlign.center,
      );

  Widget _buildSampleAnswer() => Text(
          review,

          style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildContinueButton() => CustomElevatedButton(
        height: 55,
        onTap: onTap,
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );
}
