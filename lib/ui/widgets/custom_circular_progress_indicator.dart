import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final Color color;
  const CustomCircularProgressIndicator({super.key, required this.color});

  @override
  Widget build(BuildContext context) => _buildIndicator();

  Widget _buildIndicator() => CircularProgressIndicator(
        color: color,
        strokeWidth: 6,
      );
}
