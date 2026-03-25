import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../common/app_colors.dart';

class SpeakingIndicator extends StatelessWidget {
  final double size;
  const SpeakingIndicator({super.key, required this.size});

  @override
  Widget build(BuildContext context) => _buildSpeakingIndicator();

  Widget _buildSpeakingIndicator() => Container(
        height: size,
        alignment: Alignment.center,
        child: _buildSpinner(),
      );

  Widget _buildSpinner() => SpinKitWave(
        size: size,
        color: kcPrimaryColor,
        type: SpinKitWaveType.center,
      );
}
