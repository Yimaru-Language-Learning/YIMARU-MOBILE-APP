import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/helper_functions.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';

import '../../../common/app_colors.dart';
import '../../../common/translations/locale_keys.g.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/small_app_bar.dart';

class LearnPracticeDescriptionScreen
    extends ViewModelWidget<LearnPracticeViewModel> {
  const LearnPracticeDescriptionScreen({super.key});

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
        _buildTitle(viewModel),
        verticalSpaceMedium,
        _buildSubtitle(viewModel),
        verticalSpaceMedium,
        _buildImageContainer(viewModel),
        verticalSpaceLarge
      ];

  Widget _buildTitle(LearnPracticeViewModel viewModel) => Text.rich(
        TextSpan(text: 'Speaking Practice: ', style: style14DG600, children: [
          TextSpan(
            style: style14MG400,
            text: viewModel.practices.first.title ?? '',
          )
        ]),
      );

  Widget _buildSubtitle(LearnPracticeViewModel viewModel) => Text(
        viewModel.practices.first.storyDescription ?? '',
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildImageContainer(LearnPracticeViewModel viewModel) => Container(
        height: 200,
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: _buildImageWrapper(viewModel),
      );

  Widget _buildImageWrapper(LearnPracticeViewModel viewModel) => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: _buildImage(viewModel),
      );

  Widget _buildImage(LearnPracticeViewModel viewModel) => CachedNetworkImage(
        fit: BoxFit.cover,
        width: double.maxFinite,
        imageUrl:
            getReadableUrl(viewModel.practices.first.storyImage ?? '') ?? '',
      );

  Widget _buildContinueButtonWrapper(LearnPracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(LearnPracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: () => viewModel.goTo(2),
        backgroundColor: kcPrimaryColor,
        text: LocaleKeys.start_practice.tr(),
      );
}
