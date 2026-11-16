import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class RosetteCheckBadge extends StatelessWidget {
  final double size;

  const RosetteCheckBadge({super.key, this.size = 110});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size + 40,
      height: size + 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Confetti dots & stars
          CustomPaint(
            size: Size(size + 40, size + 40),
            painter: _ConfettiPainter(),
          ),
          // Scalloped Rosette
          CustomPaint(
            size: Size(size, size),
            painter: _RosettePainter(
              color: AppColors.magenta38,
              petals: 14,
            ),
          ),
          // Checkmark
          Icon(
            Icons.check_rounded,
            size: size * 0.48,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class _RosettePainter extends CustomPainter {
  final Color color;
  final int petals;

  _RosettePainter({required this.color, required this.petals});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius * 0.85;

    final path = Path();
    final step = (math.pi * 2) / (petals * 2);

    for (int i = 0; i < petals * 2; i++) {
      final r = (i % 2 == 0) ? outerRadius : innerRadius;
      final angle = i * step - (math.pi / 2);
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    // Soft blur shadow
    canvas.drawShadow(path, color.withValues(alpha: 0.3), 8, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ConfettiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final yellow = Paint()..color = const Color(0xFFFFD166);
    final mint = Paint()..color = const Color(0xFF2FB67C);
    final purple = Paint()..color = const Color(0xFFC9A6CF);

    // Some small festive dots and 4-point stars around the rosette
    canvas.drawCircle(Offset(center.dx - 55, center.dy - 45), 3, yellow);
    canvas.drawCircle(Offset(center.dx + 52, center.dy - 50), 3.5, mint);
    canvas.drawCircle(Offset(center.dx - 60, center.dy + 35), 4, purple);
    canvas.drawCircle(Offset(center.dx + 58, center.dy + 40), 3, yellow);
    canvas.drawCircle(Offset(center.dx + 65, center.dy - 10), 2.5, purple);
    canvas.drawCircle(Offset(center.dx - 68, center.dy - 10), 3, mint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

