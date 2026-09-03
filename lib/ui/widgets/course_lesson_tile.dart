import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/course_lesson.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/course_module/course_module_viewmodel.dart';

import '../common/app_colors.dart';
import '../common/enmus.dart';
import '../common/helper_functions.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';
import 'mini_thumbnail.dart';

class CourseLessonTile extends ViewModelWidget<CourseModuleViewModel> {
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
  Widget build(BuildContext context, CourseModuleViewModel viewModel) =>
      _buildExpansionTileCard(context: context, viewModel: viewModel);

  Widget _buildExpansionTileCard(
          {required BuildContext context,
          required CourseModuleViewModel viewModel}) =>
      Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: _buildColumn(),
      );

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() => [
        _buildDivider(),
        verticalSpaceMedium,
        _buildTile(),
        verticalSpaceMedium,
        _buildActionButtonWrapper(),
        verticalSpaceSmall,
      ];

  Widget _buildDivider() => const Divider(color: kcVeryLightGrey);

  Widget _buildTile() => ListTile(
        minTileHeight: 0,
        title: _buildTitle(),
        subtitle: _buildSubtitle(),
        leading: _buildLeadingWrapper(),
        trailing: _buildTrailingWrapper(),
        titleAlignment: ListTileTitleAlignment.top,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      );

  Widget _buildTitle() => Text(
        lesson.title ?? '',
        style: style16DG600,
      );

  Widget _buildSubtitle() => Text(
        '${((lesson.id ?? 0) / 50).toInt()} ${LocaleKeys.min.tr()}',
        style: style14MG400,
      );

  Widget _buildLeadingWrapper() => MiniThumbnail(
      thumbnail:
          getReadableUrl(lesson.thumbnail ?? 'assets/images/image_1.png') ??
              'assets/images/image_1.png');

  Widget _buildTrailingWrapper() =>
      ProgressStatuses.completed != ProgressStatuses.completed
          ? _buildCompletedTrailing()
          : _buildPendingTrailing();

  Widget _buildCompletedTrailing() => const Icon(
        Icons.check_circle,
        color: kcGreen,
      );

  Widget _buildPendingTrailing() => const Icon(
        Icons.circle_outlined,
        color: kcLightGrey,
      );

  Widget _buildActionButtonWrapper() => Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildActionButtons(),
      );

  Widget _buildActionButtons() => Row(
        children: [
          _buildDetailButtonWrapper(),
          if (lesson.hasPractice ?? false) horizontalSpaceSmall,
          if (lesson.hasPractice ?? false) _buildPracticeButtonWrapper()
        ],
      );

  Widget _buildDetailButtonWrapper() => Expanded(
        child: _buildDetailButton(),
      );

  Widget _buildDetailButton() => CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        onTap: onVideoTap,
        text: LocaleKeys.play_video.tr(),
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildPracticeButtonWrapper() => Expanded(
        child: _buildPracticeButton(),
      );

  Widget _buildPracticeButton() => CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        onTap: onPracticeTap,
        text: LocaleKeys.practice_test.tr(),
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
      );
}
