import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/widgets/custom_response_card.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';

class SpeakingAssessmentReviewSection extends StatelessWidget {
  final GestureTapCallback? onTap;
  const SpeakingAssessmentReviewSection({super.key, this.onTap});

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
          verticalSpaceSmall,
          _buildYourResponse(),
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

  Widget _buildSampleAnswer() =>
      const CustomResponseCard(title: 'Sample Answer', subtitle: '0:54');

  Widget _buildYourResponse() =>
      const CustomResponseCard(title: 'Your Response', subtitle: '0:54');

  Widget _buildContinueButton() => CustomElevatedButton(
        height: 55,
        onTap: onTap,
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );
}
