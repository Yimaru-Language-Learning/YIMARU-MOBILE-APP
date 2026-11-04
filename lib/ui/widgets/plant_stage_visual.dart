import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class PlantStageVisual extends StatelessWidget {
  final int stage; // 0: Sprout (Beginner), 1: Growing (Intermediate), 2: Blooming (Advanced)
  final double size;

  const PlantStageVisual({
    super.key,
    required this.stage,
    this.size = 64,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: kcWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral14.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: CustomPaint(
        size: Size(size, size),
        painter: _PlantPainter(stage: stage),
      ),
    );
  }
}

class _PlantPainter extends CustomPainter {
  final int stage;

  _PlantPainter({required this.stage});

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Draw sparkles
    _drawSparkle(canvas, Offset(w * 0.22, h * 0.28), 3.5);
    _drawSparkle(canvas, Offset(w * 0.78, h * 0.24), 4.0);
    if (stage > 0) {
      _drawSparkle(canvas, Offset(w * 0.16, h * 0.50), 2.5);
    }

    // Pot dimensions
    final double potTop = h * 0.58;
    final double potBottom = h * 0.88;
    final double potTopWidth = w * 0.44;
    final double potBottomWidth = w * 0.34;
    final double centerX = w * 0.50;

    // Pot body
    final potPath = Path()
      ..moveTo(centerX - potTopWidth / 2, potTop)
      ..lineTo(centerX + potTopWidth / 2, potTop)
      ..lineTo(centerX + potBottomWidth / 2, potBottom)
      ..lineTo(centerX - potBottomWidth / 2, potBottom)
      ..close();

    final potPaint = Paint()
      ..color = const Color(0xFFC9773F)
      ..style = PaintingStyle.fill;
    canvas.drawPath(potPath, potPaint);

    // Pot rim
    final potRim = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(centerX, potTop),
        width: potTopWidth * 1.12,
        height: h * 0.07,
      ),
      const Radius.circular(3),
    );
    final rimPaint = Paint()..color = const Color(0xFFB0652F);
    canvas.drawRRect(potRim, rimPaint);

    // Decorative band on pot
    final bandPaint = Paint()..color = AppColors.magenta38;
    canvas.drawRect(
      Rect.fromLTWH(
        centerX - potTopWidth * 0.42,
        potTop + h * 0.10,
        potTopWidth * 0.84,
        h * 0.045,
      ),
      bandPaint,
    );

    // Stems & Leaves based on stage
    final stemPaint = Paint()
      ..color = const Color(0xFF2E9E6A)
      ..strokeWidth = 3.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final leafPaint = Paint()
      ..color = const Color(0xFF58CC02)
      ..style = PaintingStyle.fill;

    if (stage == 0) {
      // Stage 0: Beginner Sprout (Single small stem + 2 leaves)
      canvas.drawLine(
        Offset(centerX, potTop),
        Offset(centerX, potTop - h * 0.22),
        stemPaint,
      );

      // Left leaf
      _drawLeaf(canvas, Offset(centerX, potTop - h * 0.15), -0.7, leafPaint, w * 0.18, h * 0.11);
      // Right leaf
      _drawLeaf(canvas, Offset(centerX, potTop - h * 0.20), 0.7, leafPaint, w * 0.18, h * 0.11);
    } else if (stage == 1) {
      // Stage 1: Intermediate (Taller stem + 4 lush leaves)
      canvas.drawLine(
        Offset(centerX, potTop),
        Offset(centerX, potTop - h * 0.34),
        stemPaint,
      );

      _drawLeaf(canvas, Offset(centerX, potTop - h * 0.12), -0.65, leafPaint, w * 0.19, h * 0.10);
      _drawLeaf(canvas, Offset(centerX, potTop - h * 0.16), 0.65, leafPaint, w * 0.19, h * 0.10);
      _drawLeaf(canvas, Offset(centerX, potTop - h * 0.26), -0.75, leafPaint, w * 0.18, h * 0.09);
      _drawLeaf(canvas, Offset(centerX, potTop - h * 0.30), 0.75, leafPaint, w * 0.18, h * 0.09);
    } else {
      // Stage 2: Advanced (Mature plant with red berries)
      canvas.drawLine(
        Offset(centerX, potTop),
        Offset(centerX, potTop - h * 0.36),
        stemPaint,
      );

      _drawLeaf(canvas, Offset(centerX, potTop - h * 0.11), -0.6, leafPaint, w * 0.20, h * 0.10);
      _drawLeaf(canvas, Offset(centerX, potTop - h * 0.15), 0.6, leafPaint, w * 0.20, h * 0.10);
      _drawLeaf(canvas, Offset(centerX, potTop - h * 0.24), -0.7, leafPaint, w * 0.18, h * 0.09);
      _drawLeaf(canvas, Offset(centerX, potTop - h * 0.28), 0.7, leafPaint, w * 0.18, h * 0.09);

      // Red berries
      final berryPaint = Paint()..color = const Color(0xFFD7263D);
      canvas.drawCircle(Offset(centerX - w * 0.14, potTop - h * 0.18), 3.2, berryPaint);
      canvas.drawCircle(Offset(centerX + w * 0.15, potTop - h * 0.23), 3.2, berryPaint);
      canvas.drawCircle(Offset(centerX - w * 0.10, potTop - h * 0.30), 3.0, berryPaint);
      canvas.drawCircle(Offset(centerX + w * 0.10, potTop - h * 0.33), 3.0, berryPaint);
    }
  }

  void _drawLeaf(Canvas canvas, Offset origin, double angle, Paint paint, double length, double width) {
    canvas.save();
    canvas.translate(origin.dx, origin.dy);
    canvas.rotate(angle);

    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(length * 0.5, -width, length, 0)
      ..quadraticBezierTo(length * 0.5, width, 0, 0)
      ..close();

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void _drawSparkle(Canvas canvas, Offset center, double size) {
    final paint = Paint()
      ..color = const Color(0xFFFFD23F)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(center.dx, center.dy - size)
      ..quadraticBezierTo(center.dx, center.dy, center.dx + size, center.dy)
      ..quadraticBezierTo(center.dx, center.dy, center.dx, center.dy + size)
      ..quadraticBezierTo(center.dx, center.dy, center.dx - size, center.dy)
      ..quadraticBezierTo(center.dx, center.dy, center.dx, center.dy - size)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _PlantPainter oldDelegate) => oldDelegate.stage != stage;
}
