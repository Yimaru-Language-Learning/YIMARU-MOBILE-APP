import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import 'custom_circular_progress_indicator.dart';

class EmptyVideoPlayer extends StatelessWidget {
  const EmptyVideoPlayer({super.key});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        decoration: const BoxDecoration(color: kcBlack),
        child: _buildStack(),
      );

  Widget _buildStack() => Stack(
        children: [_buildProgressIndicatorWrapper()],
      );

  Widget _buildProgressIndicatorWrapper() => Align(
        alignment: Alignment.center,
        child: _buildProgressIndicator(),
      );

  Widget _buildProgressIndicator() =>
      const CustomCircularProgressIndicator(color: kcPrimaryColor);
}
