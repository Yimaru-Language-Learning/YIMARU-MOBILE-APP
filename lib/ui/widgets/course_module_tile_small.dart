import 'package:flutter/material.dart';
import 'package:yimaru_app/models/course_module.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class CourseModuleTileSmall extends StatelessWidget {
  final CourseModule? module;
  final GestureTapCallback? onTap;

  const CourseModuleTileSmall({super.key, this.onTap, required this.module});

  @override
  Widget build(BuildContext context) => _buildTile();

  Widget _buildTile() => ListTile(
        onTap: onTap,
        title: _buildTitle(),
        leading: _buildLeadingWrapper(),
        trailing: _buildTrailingWrapper(),
        shape: Border(
          top: BorderSide(
            color: kcPrimaryColor.withValues(alpha: 0.25),
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      );

  Widget _buildTitle() => Text(
        module?.name ?? '',
        maxLines: 1,
        softWrap: false,
        style: style14DG600,
      );

  Widget _buildLeadingWrapper() => CircleAvatar(
        backgroundColor: kcVeryLightGrey.withValues(alpha: 0.5),
        child: _buildLeading(),
      );

  Widget _buildLeading() => const Icon(
        Icons.book,
        color: kcLightGrey,
      );

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
}
