import 'package:flutter/material.dart';

class CustomFormLabel extends StatelessWidget {
  final String label;
  final TextStyle style;

  const CustomFormLabel({super.key, required this.label, required this.style});

  @override
  Widget build(BuildContext context) => _buildLabel();

  Widget _buildLabel() => Text(
        label,
        style: style,
      );
}
