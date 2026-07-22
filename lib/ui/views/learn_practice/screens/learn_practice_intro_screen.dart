import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';

import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/small_app_bar.dart';
import '../../../widgets/speaking_partner_image.dart';

class LearnPracticeIntroScreen extends ViewModelWidget<LearnPracticeViewModel> {
  final String title;
  final String label;
  final String? level;
  final String subtitle;
  final LearnPractices practice;

  const LearnPracticeIntroScreen(
      {super.key,
      this.level,
      required this.label,
      required this.title,
      required this.subtitle,
      required this.practice});

  Future<void> _practice(LearnPracticeViewModel viewModel) async {
    if (viewModel.user?.learn ?? false) {
      viewModel.goTo(1);
    } else {
      await viewModel.navigateToLearnSubscription();
    }
  }

  Future<void> _cancel(LearnPracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.pop();
    viewModel.pop();
  }

  Future<void> _showSheet(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: kcTransparent,
        builder: (cxt) => _buildSheet(viewModel),
      );

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) =>
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldContainer(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Container(
        decoration: bgDecoration,
        child: _buildScaffold(context: context, viewModel: viewModel),
      );

  Widget _buildScaffold(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      SafeArea(
          child: _buildColumnWrapper(context: context, viewModel: viewModel));

  Widget _buildColumnWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(context: context, viewModel: viewModel),
      );

  Widget _buildColumn(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context: context, viewModel: viewModel),
          verticalSpaceMedium,
          _buildBodyColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      SmallAppBar(
        showBackButton: true,
        onPop: () async =>
            await _showSheet(context: context, viewModel: viewModel),
      );

  Widget _buildSheet(LearnPracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildBodyColumnWrapper(LearnPracticeViewModel viewModel) => Expanded(
        child: _buildBodyColumn(viewModel),
      );

  Widget _buildBodyColumn(LearnPracticeViewModel viewModel) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(LearnPracticeViewModel viewModel) => [
        _buildPracticeColumnWrapper(viewModel),
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildPracticeColumnWrapper(LearnPracticeViewModel viewModel) =>
      Expanded(child: _buildPracticeColumnScrollView(viewModel));

  Widget _buildPracticeColumnScrollView(LearnPracticeViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildPracticeColumn(viewModel),
      );

  Widget _buildPracticeColumn(LearnPracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildPracticeColumnChildren(viewModel),
      );

  List<Widget> _buildPracticeColumnChildren(LearnPracticeViewModel viewModel) =>
      [
        verticalSpaceMassive,
        _buildImageState(),
        verticalSpaceMedium,
        _buildPartnerNameState(),
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceMedium,
        _buildSubtitle()
      ];

  Widget _buildImageState() =>
      level != null ? _buildCourseSpeakingPartnerImage() : _buildImage(75);

  Widget _buildCourseSpeakingPartnerImage() => CircleAvatar(
        radius: 75,
        backgroundColor: kcPrimaryColorLight,
        child: _buildCourseSpeakingPartnerText(),
      );

  Widget _buildCourseSpeakingPartnerText() => Text(
        level?.toUpperCase() ?? '',
        style: style40P900,
      );

  Widget _buildImage(double radius) => SpeakingPartnerImage(radius: radius);

  Widget _buildPartnerNameState() =>
      level != null ? _buildCourseSpeakingPartner() : _buildPartnerName();

  Widget _buildCourseSpeakingPartner() => Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildCourseSpeakingPartnerChildren(),
      );

  List<Widget> _buildCourseSpeakingPartnerChildren() =>
      [_buildImage(15), horizontalSpaceTiny, _buildPartnerName()];

  Widget _buildPartnerName() => Text.rich(
        TextSpan(text: 'Daniel', style: style14DG600, children: [
          TextSpan(
            text: ' - ${LocaleKeys.speaking_partner.tr()}',
            style: style14MG400,
          )
        ]),
      );

  Widget _buildTitle() => Text(
        title,
        style: style25DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => Text(
        subtitle,
        maxLines: 1,
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildContinueButtonWrapper(LearnPracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(LearnPracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: label,
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: () async => await _practice(viewModel),
      );
}
