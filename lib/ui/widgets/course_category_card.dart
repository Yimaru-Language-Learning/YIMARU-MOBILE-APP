import 'package:flutter/material.dart';
import 'package:yimaru_app/models/course_category.dart';
import 'package:yimaru_app/ui/common/helper_functions.dart';

import '../common/app_colors.dart';
import '../common/app_strings.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';

class CourseCategoryCard extends StatelessWidget {
  final CourseCategory category;
  final GestureTapCallback? onTap;

  const CourseCategoryCard({super.key, this.onTap, required this.category});

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
        category.name ?? '',
        style: style18DG700,
      );

  Widget _buildSubtitle() => Text(
        ksCategorySubtitle,
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
        text: 'Start Course',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );
}
