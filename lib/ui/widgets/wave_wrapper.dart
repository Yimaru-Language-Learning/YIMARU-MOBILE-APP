import 'package:flutter/material.dart';

import '../common/app_colors.dart';

class WaveWrapper extends StatelessWidget {
  final Widget child;
  final double height;
  const WaveWrapper({super.key, required this.child, required this.height});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            radius: 0.7,
            stops: const [
              0.2,
              0.25,
              0.45,
              0.75,
              1,
            ],
            center: Alignment.center,
            colors: [
              kcPrimaryColor.withOpacity(0.4),
              kcPrimaryColor.withOpacity(0.4),
              kcPrimaryColor.withOpacity(0.15),
              kcPrimaryColor.withOpacity(0.1),
              kcPrimaryColor.withOpacity(0.05),
            ],
            // quarterly spread
          ),
        ),
        child: child,
      );
}
