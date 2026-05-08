import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class AppBarPattern extends StatelessWidget {
  const AppBarPattern({
    super.key,
  });

  @override
  Widget build(BuildContext context) => _buildDecorationImageWrapper();

  Widget _buildDecorationImageWrapper() => ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        child: _buildDecorationImage(),
      );

  Widget _buildDecorationImage() => SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: _buildPatternWrapper(),
      );

  Widget _buildPatternWrapper() => SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: _buildPatternMask(),
      );

  Widget _buildPatternMask() => ShaderMask(
        shaderCallback: (Rect bounds) => const LinearGradient(
          colors: [kcWhite, kcWhite],
        ).createShader(bounds),
        blendMode: BlendMode.modulate,
        child: _buildPattern(),
      );

  Widget _buildPattern() => Image.asset(
        'assets/images/pattern.png',
        fit: BoxFit.cover,
      );
}
