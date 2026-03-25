import 'package:flutter/material.dart';
import 'package:yimaru_app/models/course_detail.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';

class CourseTile extends StatelessWidget {
  final CourseDetail courseDetail;
  final GestureTapCallback? onCourseTap;
  final GestureTapCallback? onPracticeTap;

  const CourseTile({
    super.key,
    this.onCourseTap,
    this.onPracticeTap,
    required this.courseDetail,
  });

  @override
  Widget build(BuildContext context) => _buildExpansionTileCard();

  Widget _buildExpansionTileCard() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: kcPrimaryColor.withOpacity(0.2),
          ),
        ),
        child: _buildTileStack(),
      );

  Widget _buildTileStack() => Stack(
        children: [_buildExpansionTile(), _buildTileShaderState()],
      );

  Widget _buildExpansionTile() => ExpansionTile(
        title: _buildTitle(),
        textColor: kcDarkGrey,
        showTrailingIcon: false,
        initiallyExpanded: false,
        collapsedIconColor: kcDarkGrey,
        collapsedTextColor: kcDarkGrey,
        shape: Border.all(color: kcTransparent),
        expandedAlignment: Alignment.centerLeft,
        backgroundColor: kcPrimaryColor.withOpacity(0.1),
        controlAffinity: ListTileControlAffinity.trailing,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        collapsedBackgroundColor: kcPrimaryColor.withOpacity(0.1),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
        enabled: courseDetail.courseProgress?.progressStatus == 'NOT_STARTED'
            ? courseDetail.courseProgress?.displayOrder == 1
                ? true
                : false
            : true,
        children: _buildExpansionTileChildren(),
      );

  List<Widget> _buildExpansionTileChildren() => [
        _buildProgressRow(),
        verticalSpaceSmall,
        _buildActionButtonWrapper(),
        verticalSpaceSmall
      ];

  Widget _buildTitle() => Text(
        (courseDetail.course?.title == null ||
                (courseDetail.course?.title?.isEmpty ?? false))
            ? 'Course ${courseDetail.course?.id}'
            : courseDetail.course?.title ?? '',
        style: style16P600,
      );

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
        backgroundColor: kcVeryLightGrey,
        progress: courseDetail.courseProgress?.progressPercentage ?? 0 / 100,
      );

  Widget _buildProgress() => Text(
        '${courseDetail.courseProgress?.progressPercentage?.toInt() ?? 0}%',
        style: style14DG400,
      );

  Widget _buildActionButtonWrapper() => SizedBox(
        height: 40,
        width: 300,
        child: _buildActionButtons(),
      );

  Widget _buildActionButtons() => Row(
        children: [
          _buildStartButtonWrapper(),
          horizontalSpaceSmall,
          _buildPracticeButtonWrapper()
        ],
      );

  Widget _buildStartButtonWrapper() => Expanded(
        child: _buildStartButton(),
      );

  Widget _buildStartButton() => CustomElevatedButton(
        height: 15,
        borderRadius: 8,
        onTap: onCourseTap,
        text: 'Start Course',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildPracticeButtonWrapper() => Expanded(
        child: _buildPracticeButton(),
      );

  Widget _buildPracticeButton() => CustomElevatedButton(
        height: 15,
        borderRadius: 8,
        text: 'Practice',
        onTap: onPracticeTap,
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
      );

  Widget _buildTileShaderState() =>
      courseDetail.courseProgress?.progressStatus == 'NOT_STARTED'
          ? courseDetail.courseProgress?.displayOrder == 1
              ? Container()
              : _buildTileShaderWrapper()
          : Container();

  Widget _buildTileShaderWrapper() => Positioned.fill(
        child: _buildTileShader(),
      );

  Widget _buildTileShader() => Container(
        decoration: BoxDecoration(
          color: kcWhite.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5),
        ),
      );
}
