import 'package:flutter/material.dart';

import '../common/app_colors.dart';

class CustomContainerShader extends StatelessWidget {
  const CustomContainerShader({super.key});

  @override
  Widget build(BuildContext context) => _buildContainerShaderWrapper();

  Widget _buildContainerShaderWrapper() => Positioned.fill(
        child: _buildContainerShader(),
      );

  Widget _buildContainerShader() => Container(
        decoration: BoxDecoration(
          color: kcWhite.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5),
        ),
      );
}
