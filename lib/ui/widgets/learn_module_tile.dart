import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/learn_module.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_module/learn_module_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_container_shader.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';

class LearnModuleTile extends ViewModelWidget<LearnModuleViewModel> {
  final LearnModule module;
  final GestureTapCallback? onModuleTap;
  final GestureTapCallback? onPracticeTap;

  const LearnModuleTile(
      {super.key, this.onModuleTap, this.onPracticeTap, required this.module});

  @override
  Widget build(BuildContext context, LearnModuleViewModel viewModel) =>
      _buildExpansionTileCardWrapper(context: context, viewModel: viewModel);

  Widget _buildExpansionTileCardWrapper(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      GestureDetector(
        onTap: !(module.access?.isAccessible ?? false) ? onPracticeTap : null,
        child: _buildExpansionTileCard(context: context, viewModel: viewModel),
      );

  Widget _buildExpansionTileCard(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kcPrimaryColor.withValues(alpha: 0.1)),
        ),
        child: _buildTileStack(context: context, viewModel: viewModel),
      );

  Widget _buildTileStack(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      Stack(
        children: [
          _buildExpansionTile(context: context, viewModel: viewModel),
          /*  Due to the now learn locking logic
         if (!(module.access?.isAccessible ?? false))
          _buildContainerShader()*/
        ],
      );

  Widget _buildExpansionTile(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      ExpansionTile(
        textColor: kcDarkGrey,
        subtitle: _buildContent(),
        /* Due to the now learn locking logic
         trailing: _buildLockIcon(),*/
        title: _buildTitleWrapper(),
        collapsedIconColor: kcDarkGrey,
        collapsedTextColor: kcDarkGrey,
        backgroundColor: kcBackgroundColor,
        leading: _buildIconWrapper(viewModel),
        shape: Border.all(color: kcTransparent),
        expandedAlignment: Alignment.centerLeft,
        collapsedBackgroundColor: kcBackgroundColor,
        /* Due to the now learn locking logic
        enabled: (program.access?.isAccessible ?? false)
        */
        controlAffinity: ListTileControlAffinity.trailing,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        tilePadding: const EdgeInsets.symmetric(horizontal: 15),
        childrenPadding: const EdgeInsets.fromLTRB(70, 0, 15, 15),
        initiallyExpanded: (module.access?.isAccessible ?? false),
        /* Due to the now learn locking logic
       showTrailingIcon:
            !(module.access?.isAccessible ?? false) ? true : false,*/
        children:
            _buildExpansionTileChildren(context: context, viewModel: viewModel),
      );

  Widget _buildLockIcon() => const Icon(
        Icons.lock_outline_rounded,
        color: kcLightGrey,
      );

  Widget _buildIconWrapper(LearnModuleViewModel viewModel) => CircleAvatar(
        backgroundColor: kcPrimaryColor.withValues(alpha: 0.1),
        child: _buildIconClipper(viewModel),
      );

  Widget _buildIconClipper(LearnModuleViewModel viewModel) => ClipRRect(
        child: _buildIcon(viewModel),
      );

  Widget _buildIcon(LearnModuleViewModel viewModel) => CachedNetworkImage(
        width: 25,
        height: 25,
        imageUrl: module.icon ?? '',
        // cacheKey: viewModel.getModuleImage(module),
      );

  Widget _buildTitleWrapper() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: _buildTitle(),
      );

  Widget _buildTitle() => Text(
        module.name ?? '',
        maxLines: 1,
        softWrap: false,
        style: style16P600,
        overflow: TextOverflow.ellipsis,
      );

  Widget _buildContent() => Text(
        module.description ?? '',
        maxLines: 1,
        softWrap: false,
        style: style14DG400,
        overflow: TextOverflow.ellipsis,
      );

  List<Widget> _buildExpansionTileChildren(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      [_buildExpansionTileItem(context: context, viewModel: viewModel)];

  Widget _buildExpansionTileItem(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildExpansionTileItemChildren(
            context: context, viewModel: viewModel),
      );

  List<Widget> _buildExpansionTileItemChildren(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      [
        _buildProgressRow(),
        verticalSpaceSmall,
        _buildActionButtonWrapper(context: context, viewModel: viewModel)
      ];

  Widget _buildProgressRow() => Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildProgressChildren(),
      );

  List<Widget> _buildProgressChildren() =>
      [_buildProgressStatusWrapper(), horizontalSpaceSmall, _buildProgress()];

  Widget _buildProgressStatusWrapper() => Expanded(
        child: _buildProgressStatus(),
      );

  Widget _buildProgressStatus() => CustomLinearProgressIndicator(
        activeColor: kcPrimaryColor,
        backgroundColor: kcPrimaryColorLight,
        progress: (module.access?.progressPercent ?? 0) / 100,
      );

  Widget _buildProgress() => Text(
        '${module.access?.completedCount ?? 0}/${module.access?.totalCount ?? 0}',
        style: style14DG500,
      );

  Widget _buildActionButtonWrapper(
          {required BuildContext context,
          required LearnModuleViewModel viewModel}) =>
      SizedBox(
        height: 40,
        child: _buildActionButtons(viewModel),
      );

  Widget _buildActionButtons(LearnModuleViewModel viewModel) => Row(
        children: [
          _buildModuleButtonWrapper(viewModel),
          horizontalSpaceSmall,
          _buildPracticeButtonWrapper(viewModel)
        ],
      );

  Widget _buildModuleButtonWrapper(LearnModuleViewModel viewModel) => Expanded(
        child: _buildModuleButton(viewModel),
      );

  Widget _buildModuleButton(LearnModuleViewModel viewModel) =>
      CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        onTap: onModuleTap,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        text: LocaleKeys.view_module.tr(),
      );

  Widget _buildPracticeButtonWrapper(LearnModuleViewModel viewModel) =>
      Expanded(
        child: _buildPracticeButton(viewModel),
      );

  Widget _buildPracticeButton(LearnModuleViewModel viewModel) =>
      CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        onTap: onPracticeTap,
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
        text: LocaleKeys.take_practice.tr(),
      );

  Widget _buildContainerShader() => const CustomContainerShader();
}
