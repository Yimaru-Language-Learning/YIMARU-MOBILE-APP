import 'package:flutter/material.dart';

import '../common/ui_helpers.dart';

class SpeakingLabel extends StatelessWidget {
  const SpeakingLabel({super.key});

  @override
  Widget build(BuildContext context) => _buildSpeakerLabel();

  Widget _buildSpeakerLabel() => Text(
        'You are speaking...',
        style: style14P400,
        textAlign: TextAlign.center,
      );
}
