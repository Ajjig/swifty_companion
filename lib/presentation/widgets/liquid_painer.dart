import 'package:flutter/material.dart';
import 'package:swifty_companion/core/theme.dart';

class LiquidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [AppTheme.mainColor, Color(0xFF5FC6FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path()
      ..lineTo(0, size.height * 0.8)
      ..cubicTo(
        size.width * 0.25,
        size.height * 0.65,
        size.width * 0.25,
        size.height * 0.35,
        size.width * 0.5,
        size.height * 0.5,
      )
      ..cubicTo(
        size.width * 0.75,
        size.height * 0.65,
        size.width * 0.75,
        size.height * 0.35,
        size.width,
        size.height * 0.5,
      )
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
