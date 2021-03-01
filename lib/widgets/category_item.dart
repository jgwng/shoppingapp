import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

import 'package:shoppingapp/constants/app_themes.dart';

class HexagonPaint extends StatelessWidget {
  final Offset center;
  final double radius;

  HexagonPaint(this.center, this.radius);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: HexagonPainter(center, radius),
    );
  }
}

class HexagonPainter extends CustomPainter {
  static const int SIDES_OF_HEXAGON = 6;
  final double radius;
  final Offset center;

  HexagonPainter(this.center, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = AppThemes.mainColor;
    paint..style = PaintingStyle.stroke;
    paint..strokeCap = StrokeCap.round;
    paint..strokeWidth= 2.0;
    Path path = createHexagonPath();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-33);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawPath(path, paint);
  }

  Path createHexagonPath() {
    final path = Path();
    var angle = (math.pi * 2) / SIDES_OF_HEXAGON;

    Offset firstPoint = Offset(radius * math.cos((angle)), radius * math.sin((angle)));
    path.moveTo(firstPoint.dx+center.dx, center.dy+firstPoint.dy);

    for (int i = 1; i <= 6; i++) {
      double x = radius * math.cos((angle) * i) + center.dx;
      double y = radius * math.sin((angle) * i) + center.dy;
      path.lineTo(x, y);
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}