import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final Color color;

  const CustomCircularProgressIndicator({super.key, required this.color});

  @override
  Widget build(BuildContext context) => _buildIndicatorWrapper();

  Widget _buildIndicatorWrapper() => SizedBox(
        width: 16,
        height: 16,
        child: _buildIndicator(),
      );

  Widget _buildIndicator() => CircularProgressIndicator(
        color: color,
        strokeWidth: 5,
      );
}
