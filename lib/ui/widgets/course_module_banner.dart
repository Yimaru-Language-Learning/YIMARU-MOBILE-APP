import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class CourseModuleBanner extends StatelessWidget {
  const CourseModuleBanner({super.key});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        height: 125,
        width: double.maxFinite,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: kcOrange.withValues(alpha: 0.43),
        ),
        child: _buildIcon(),
      );

  Widget _buildIcon() => Image.asset('assets/icons/duolingo.png');
}
