import 'package:flutter/material.dart';

class QRCornersPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double cornerLength;
  final double borderRadius;

  QRCornersPainter({
    this.color = Colors.white,
    this.strokeWidth = 3,
    this.cornerLength = 20,
    this.borderRadius = 8, // border radius for rounded corners
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Top-left corner
    canvas.drawArc(
      Rect.fromLTWH(0, 0, borderRadius * 2, borderRadius * 2),
      3.14159, // start angle (180°)
      1.5708, // sweep angle (90°)
      false,
      paint,
    );
    canvas.drawLine(Offset(borderRadius, 0), Offset(cornerLength, 0), paint);
    canvas.drawLine(Offset(0, borderRadius), Offset(0, cornerLength), paint);

    // Top-right corner
    canvas.drawArc(
      Rect.fromLTWH(
        size.width - borderRadius * 2,
        0,
        borderRadius * 2,
        borderRadius * 2,
      ),
      -1.5708, // -90°
      1.5708, // 90°
      false,
      paint,
    );
    canvas.drawLine(
      Offset(size.width - cornerLength, 0),
      Offset(size.width - borderRadius, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, borderRadius),
      Offset(size.width, cornerLength),
      paint,
    );

    // Bottom-left corner
    canvas.drawArc(
      Rect.fromLTWH(
        0,
        size.height - borderRadius * 2,
        borderRadius * 2,
        borderRadius * 2,
      ),
      3.14159 / 2, // 90°
      1.5708, // 90°
      false,
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height - cornerLength),
      Offset(0, size.height - borderRadius),
      paint,
    );
    canvas.drawLine(
      Offset(borderRadius, size.height),
      Offset(cornerLength, size.height),
      paint,
    );

    // Bottom-right corner
    canvas.drawArc(
      Rect.fromLTWH(
        size.width - borderRadius * 2,
        size.height - borderRadius * 2,
        borderRadius * 2,
        borderRadius * 2,
      ),
      0, // 0°
      1.5708, // 90°
      false,
      paint,
    );
    canvas.drawLine(
      Offset(size.width - cornerLength, size.height),
      Offset(size.width - borderRadius, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height - cornerLength),
      Offset(size.width, size.height - borderRadius),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
