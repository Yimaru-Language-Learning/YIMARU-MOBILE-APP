import 'package:flutter/material.dart';

import '../common/ui_helpers.dart';

class SpeakingLabel extends StatelessWidget {
  final String label;
  const SpeakingLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) => _buildSpeakerLabel();

  Widget _buildSpeakerLabel() => Text(
        label,
        style: style14P400,
        textAlign: TextAlign.center,
      );
}
