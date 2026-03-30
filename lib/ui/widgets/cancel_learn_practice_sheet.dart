import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/speaking_partner_image.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_bottom_sheet.dart';
import 'custom_elevated_button.dart';

class CancelLearnPracticeSheet extends ViewModelWidget<LearnPracticeViewModel> {
  final GestureTapCallback? onClose;
  final GestureTapCallback? onCancel;
  final GestureTapCallback? onContinue;

  const CancelLearnPracticeSheet(
      {super.key, this.onClose, this.onCancel, this.onContinue});

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) =>
      _buildSheetWrapper(viewModel);

  Widget _buildSheetWrapper(LearnPracticeViewModel viewModel) =>
      CustomBottomSheet(
          height: 500, onTap: onClose, child: _buildColumnWrapper(viewModel));

  Widget _buildColumnWrapper(LearnPracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LearnPracticeViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildSheetChildren(viewModel),
      );

  List<Widget> _buildSheetChildren(LearnPracticeViewModel viewModel) => [
        verticalSpaceLarge,
        _buildImage(),
        verticalSpaceMedium,
        _buildMessage(viewModel),
        _buildSubtitle(),
        verticalSpaceLarge,
        _buildContinueButton(),
        _buildEndButton(),
      ];

  Widget _buildImage() => const SpeakingPartnerImage(
        radius: 45,
      );

  Widget _buildMessage(LearnPracticeViewModel viewModel) => Text.rich(
        TextSpan(text: 'You’re almost there,', style: style18DG700, children: [
          TextSpan(
            text: '  ${viewModel.user?.firstName ?? ''}!',
            style: style18P600,
          )
        ]),
      );

  Widget _buildSubtitle() => Text(
        'Finish this session to see your progress.',
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildContinueButton() => CustomElevatedButton(
        height: 55,
        onTap: onContinue,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: 'Continue Practice',
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildEndButton() => CustomElevatedButton(
        height: 55,
        onTap: onCancel,
        borderRadius: 12,
        text: 'End Session',
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
      );
}
