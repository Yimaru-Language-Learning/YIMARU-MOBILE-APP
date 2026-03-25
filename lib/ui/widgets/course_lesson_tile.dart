import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/course_lesson.dart';
import 'package:yimaru_app/ui/views/course_lesson/course_lesson_viewmodel.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';
import 'mini_thumbnail.dart';

class CourseLessonTile extends ViewModelWidget<CourseLessonViewModel> {
  final CourseLesson lesson;
  final GestureTapCallback? onVideoTap;
  final GestureTapCallback? onPracticeTap;

  const CourseLessonTile({
    super.key,
    this.onVideoTap,
    this.onPracticeTap,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context, CourseLessonViewModel viewModel) =>
      _buildExpansionTileCard(context: context, viewModel: viewModel);

  Widget _buildExpansionTileCard(
          {required BuildContext context,
          required CourseLessonViewModel viewModel}) =>
      Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: kcPrimaryColor.withValues(alpha: 0.25),
          ),
        ),
        child: _buildColumn(),
      );

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() => [
        //  _buildDivider(),
        verticalSpaceMedium,
        _buildTile(),
        verticalSpaceMedium,
        _buildActionButtonWrapper(),
        verticalSpaceSmall,
      ];

  Widget _buildTile() => ListTile(
        minTileHeight: 0,
        title: _buildTitle(),
        subtitle: _buildSubtitle(),
        leading: _buildLeadingWrapper(),
        titleAlignment: ListTileTitleAlignment.top,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      );

  Widget _buildTitle() => Text(
        lesson.title ?? '',
        style: style16DG600,
      );

  Widget _buildSubtitle() => Text(
        '${((lesson.duration ?? 0) / 50).toInt()} min',
        style: style14MG400,
      );

  Widget _buildLeadingWrapper() =>
      const MiniThumbnail(thumbnail: 'assets/images/image_1.png');

  Widget _buildActionButtonWrapper() => Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildActionButtons(),
      );

  Widget _buildActionButtons() => Row(
        children: [
          _buildDetailButtonWrapper(),
          horizontalSpaceSmall,
          _buildPracticeButtonWrapper()
        ],
      );

  Widget _buildDetailButtonWrapper() => Expanded(
        child: _buildDetailButton(),
      );

  Widget _buildDetailButton() => CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        onTap: onVideoTap,
        text: 'Play Video',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildPracticeButtonWrapper() => Expanded(
        child: _buildPracticeButton(),
      );

  Widget _buildPracticeButton() => CustomElevatedButton(
        height: 15,
        text: 'Practice',
        borderRadius: 12,
        onTap: onPracticeTap,
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
      );
}
