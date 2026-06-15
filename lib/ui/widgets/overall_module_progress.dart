import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/widgets/overall_progress_wrapper.dart';

class OverallModuleProgress extends StatelessWidget {
  const OverallModuleProgress({super.key});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: kcPrimaryColor.withValues(alpha: 0.1),
        ),
        child: const OverallProgressWrapper(),
      );
}
