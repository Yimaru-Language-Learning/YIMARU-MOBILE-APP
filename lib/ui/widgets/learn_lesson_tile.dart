import 'package:flutter/material.dart';
import 'package:yimaru_app/models/lesson.dart';
import 'package:yimaru_app/ui/widgets/mini_thumbnail.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';
import 'custom_linear_progress_indicator.dart';

class LearnLessonTile extends StatelessWidget {
  final Lesson lesson;
  final GestureTapCallback? onLessonTap;

  const LearnLessonTile({super.key, this.onLessonTap, required this.lesson});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: kcPrimaryColor.withOpacity(0.1),
            // color: ProgressStatuses.pending == status
            //     ? kcPrimaryColor.withOpacity(0.1)
            //     : kcGreen.withOpacity(0.1),
          ),
        ),
        child: _buildExpansionTile(),
      );

  Widget _buildExpansionTile() => ExpansionTile(
        enabled: true,
        title: _buildTitle(),
        textColor: kcDarkGrey,
        showTrailingIcon: true,
        initiallyExpanded: true,
        trailing: _buildPendingIcon(),
        collapsedIconColor: kcDarkGrey,
        collapsedTextColor: kcDarkGrey,
        leading: _buildLeadingWrapper(),
        shape: Border.all(color: kcTransparent),
        expandedAlignment: Alignment.centerLeft,
        backgroundColor: kcGreen.withOpacity(0.1),
        controlAffinity: ListTileControlAffinity.trailing,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        collapsedBackgroundColor: kcPrimaryColor.withOpacity(0.1),
        childrenPadding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        tilePadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        // enabled: status != ProgressStatuses.pending,
        // backgroundColor: ProgressStatuses.pending == status
        //     ? kcPrimaryColor.withOpacity(0.1)
        //     : kcGreen.withOpacity(0.1),
        // collapsedBackgroundColor: ProgressStatuses.pending == status
        //     ? kcPrimaryColor.withOpacity(0.1)
        //     : kcGreen.withOpacity(0.1),
        // initiallyExpanded: status != ProgressStatuses.completed ? true : false,
        children: _buildExpansionTileChildren(),
      );

  Widget _buildLeadingWrapper() =>
      MiniThumbnail(thumbnail: lesson.thumbnail ?? 'assets/images/image_1.png');

  Widget _buildTitle() => Text(
        lesson.title ?? '',
        style: style16DG600,
      );

  // Widget _buildIconState() => ProgressStatuses.pending == status
  //     ? _buildPendingIcon()
  //     : _buildCompleteIcon();

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
        // _buildProgressText(),
        // verticalSpaceSmall,
        _buildActionButtonWrapper()
      ];

  Widget _buildProgress() => const CustomLinearProgressIndicator(
        progress: 0,
        activeColor: kcPrimaryColor,
        backgroundColor: kcVeryLightGrey,
      );

  // Widget _buildProgressText() => Text(
  //       ProgressStatuses.completed == status ? 'Completed' : 'In Progress',
  //       style: style14P400,
  //     );

  Widget _buildActionButtonWrapper() => SizedBox(
        height: 50,
        child: _buildLessonButton(),
      );

  Widget _buildLessonButton() => CustomElevatedButton(
        height: 15,
        text: 'Start',
        borderRadius: 12,
        onTap: onLessonTap,
        width: double.maxFinite,
        foregroundColor: kcWhite,
        trailingIcon: Icons.play_arrow,
        backgroundColor: kcPrimaryColor,
      );
}
