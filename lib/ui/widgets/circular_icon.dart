import 'package:flutter/material.dart';

class CircularIcon extends StatelessWidget {
  final Color color;
  final double size;
  final IconData icon;
  const CircularIcon(
      {super.key, required this.icon, required this.size, required this.color});

  @override
  Widget build(BuildContext context) => _buildIconWrapper();

  Widget _buildIconWrapper() => CircleAvatar(
        radius: size,
        backgroundColor: color.withOpacity(0.25),
        child: _buildIcon(),
      );

  Widget _buildIcon() => Icon(
        icon,
        size: size,
        color: color,
      );
}
