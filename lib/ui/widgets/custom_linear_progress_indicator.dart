import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  final double progress;
  final Color activeColor;
  final Color backgroundColor;

  const CustomLinearProgressIndicator(
      {super.key,
      required this.progress,
      required this.activeColor,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) => _buildProgressIndicatorWrapper();

  Widget _buildProgressIndicatorWrapper() => SizedBox(
        height: 5,
        width: double.maxFinite,
        child: _buildProgressIndicatorClipper(),
      );

  Widget _buildProgressIndicatorClipper() => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: _buildProgressIndicator(),
      );

  Widget _buildProgressIndicator() => LinearProgressIndicator(
        value: progress,
        color: activeColor,
        backgroundColor: backgroundColor,
      );
}
