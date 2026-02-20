import 'dart:ui';

import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/enmus.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';
import 'custom_linear_progress_indicator.dart';

class LearnLessonTile extends StatelessWidget {
  final String title;
  final String thumbnail;
  final ProgressStatuses status;
  final GestureTapCallback? onLessonTap;
  final GestureTapCallback? onPracticeTap;

  const LearnLessonTile({
    super.key,
    this.onLessonTap,
    this.onPracticeTap,
    required this.title,
    required this.status,
    required this.thumbnail,
  });

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: ProgressStatuses.pending == status
                ? kcPrimaryColor.withOpacity(0.1)
                : kcGreen.withOpacity(0.1),
          ),
        ),
        child: _buildExpansionTile(),
      );

  Widget _buildExpansionTile() => ExpansionTile(
        title: _buildTitle(),
        textColor: kcDarkGrey,
        showTrailingIcon: true,
        trailing: _buildIconState(),
        // subtitle: _buildContent(),
        collapsedIconColor: kcDarkGrey,
        collapsedTextColor: kcDarkGrey,
        leading: _buildLeadingWrapper(),
        shape: Border.all(color: kcTransparent),
        expandedAlignment: Alignment.centerLeft,
        enabled: status != ProgressStatuses.pending,
        controlAffinity: ListTileControlAffinity.trailing,
        backgroundColor: ProgressStatuses.pending == status
            ? kcPrimaryColor.withOpacity(0.1)
            : kcGreen.withOpacity(0.1),
        childrenPadding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        collapsedBackgroundColor: ProgressStatuses.pending == status
            ? kcPrimaryColor.withOpacity(0.1)
            : kcGreen.withOpacity(0.1),
        tilePadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        initiallyExpanded: status != ProgressStatuses.completed ? true : false,
        children: _buildExpansionTileChildren(),
      );

  Widget _buildLeadingWrapper() => SizedBox(
        width: 75,
        height: double.maxFinite,
        child: _buildLeadingClipper(),
      );

  Widget _buildLeadingClipper() => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: _buildLeadingStack(),
      );

  Widget _buildLeadingStack() => Stack(
        alignment: Alignment.center,
        children: _buildLeadingChildren(),
      );

  List<Widget> _buildLeadingChildren() =>
      [_buildImageWrapper(), _buildPlayButtonWrapper()];

  Widget _buildImageWrapper() =>
      Align(alignment: Alignment.center, child: _buildImage());

  Widget _buildImage() => Image.asset(
        thumbnail,
        fit: BoxFit.fill,
        width: double.maxFinite,
      );

  Widget _buildPlayButtonWrapper() => Align(
        alignment: Alignment.center,
        child: _buildPlayButton(),
      );

  Widget _buildPlayButton() => CircleAvatar(
        radius: 14,
        backgroundColor: kcTransparent,
        child: _buildPlayIconClipper(),
      );

  Widget _buildPlayIconClipper() => ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: _buildPlayIconBlender(),
      );

  Widget _buildPlayIconBlender() => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: _buildPlayIcon(),
      );

  Widget _buildPlayIcon() => const Icon(
        Icons.play_arrow,
        color: kcWhite,
      );

  Widget _buildTitle() => Text(
        title,
        style: style16DG600,
      );

  Widget _buildIconState() => ProgressStatuses.pending == status
      ? _buildPendingIcon()
      : _buildCompleteIcon();

  Widget _buildCompleteIcon() => const Icon(
        Icons.check,
        color: kcGreen,
      );

  Widget _buildPendingIcon() => const Icon(
        Icons.access_time_rounded,
        color: kcPrimaryColor,
      );

  List<Widget> _buildExpansionTileChildren() => [_buildExpansionTileItem()];

  Widget _buildExpansionTileItem() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildExpansionTileItemChildren(),
      );

  List<Widget> _buildExpansionTileItemChildren() => [
        _buildProgress(),
        horizontalSpaceSmall,
        _buildProgressText(),
        verticalSpaceSmall,
        _buildActionButtonWrapper()
      ];

  Widget _buildProgress() => CustomLinearProgressIndicator(
        activeColor: kcPrimaryColor,
        backgroundColor: kcVeryLightGrey,
        progress: ProgressStatuses.completed == status ? 1 : 0.75,
      );

  Widget _buildProgressText() => Text(
        ProgressStatuses.completed == status ? 'Completed' : 'In Progress',
        style: style14P400,
      );

  Widget _buildActionButtonWrapper() => SizedBox(
        height: 40,
        child: _buildActionButtons(),
      );

  Widget _buildActionButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: _buildActionButtonChildren(),
      );

  List<Widget> _buildActionButtonChildren() => [
        _buildPracticeButton(),
        horizontalSpaceSmall,
        _buildLessonButton(),
      ];

  Widget _buildPracticeButton() => CustomElevatedButton(
        height: 15,
        width: 135,
        text: 'Practice',
        borderRadius: 12,
        onTap: onPracticeTap,
        trailingIcon: Icons.mic,
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
      );

  Widget _buildLessonButton() => CustomElevatedButton(
        height: 15,
        width: 135,
        borderRadius: 12,
        onTap: onLessonTap,
        foregroundColor: kcWhite,
        trailingIcon: Icons.play_arrow,
        backgroundColor: kcPrimaryColor,
        text: ProgressStatuses.completed == status ? 'View' : 'Continue',
      );
}
