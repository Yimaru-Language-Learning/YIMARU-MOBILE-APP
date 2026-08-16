import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/helper_functions.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';

class CourseCard extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Map<String, dynamic> course;

  const CourseCard({super.key, this.onTap, required this.course});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        height: 200,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: getColor(),
          borderRadius: BorderRadius.circular(5),
        ),
        child: _buildColumn(),
      );

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() => [
        _buildTitle(),
        verticalSpaceTiny,
        _buildSubtitle(),
        verticalSpaceMedium,
        __buildStartButtonWrapper(),
      ];

  Widget _buildTitle() => Text(
        course['title'],
        style: style18DG700,
      );

  Widget _buildSubtitle() => Text(
        course['description'],
        maxLines: 3,
        style: style16DG400,
      );

  Widget __buildStartButtonWrapper() => SizedBox(
        height: 40,
        child: _buildStartButton(),
      );

  Widget _buildStartButton() => CustomElevatedButton(
        height: 50,
        width: 200,
        onTap: onTap,
        borderRadius: 12,
        text: LocaleKeys.start_course.tr(),
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );
}
