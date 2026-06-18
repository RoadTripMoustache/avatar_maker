import "dart:math";

import "package:avatar_maker/src/core/enums/effect_type.dart";
import "package:flutter/material.dart";

/// Internal droplet helper for liquid-style effects.
class _Droplet {
  final Offset base;
  final double radius;
  final double phase;
  final int colorIndex;
  late Offset position;

  _Droplet({
    required this.base,
    required this.radius,
    required this.phase,
    required this.colorIndex,
  });
}

/// Static, type-distinct thumbnail preview for effect items.
class EffectThumbnailPainter extends CustomPainter {
  final EffectType effectType;
  final List<Color> colors;

  EffectThumbnailPainter({
    required this.effectType,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide * 0.4;

    switch (effectType) {
      case EffectType.aura:
        _thumbAura(canvas, center, radius);
        break;
      case EffectType.stars:
        _thumbStars(canvas, center, radius);
        break;
      case EffectType.hearts:
        _thumbHearts(canvas, center, radius);
        break;
      case EffectType.sparkles:
        _thumbSparkles(canvas, center, radius);
        break;
      case EffectType.flames:
        _thumbFlames(canvas, center, radius);
        break;
      case EffectType.snowflakes:
        _thumbSnowflakes(canvas, center, radius);
        break;
      case EffectType.butterflies:
        _thumbButterflies(canvas, center, radius);
        break;
      case EffectType.birds:
        _thumbBirds(canvas, center, radius);
        break;
      case EffectType.bubbles:
        _thumbBubbles(canvas, center, radius);
        break;
      case EffectType.particles:
        _thumbParticles(canvas, center, radius);
        break;
      case EffectType.mist:
        _thumbMist(canvas, center, radius);
        break;
      case EffectType.wavyLines:
        _thumbWavyLines(canvas, center, radius);
        break;
      case EffectType.orbitDots:
        _thumbOrbitDots(canvas, center, radius);
        break;
      case EffectType.rotatingRing:
        _thumbRotatingRing(canvas, center, radius);
        break;
      case EffectType.abstractShapes:
        _thumbAbstractShapes(canvas, center, radius);
        break;
      case EffectType.risingBubbles:
        _thumbRisingBubbles(canvas, center, radius);
        break;
      case EffectType.flyingObjects:
        _thumbFlyingObjects(canvas, center, radius);
        break;
      case EffectType.pushSymbols:
        _thumbPushSymbols(canvas, center, radius);
        break;
      case EffectType.colorWaves:
        _thumbColorWaves(canvas, center, radius);
        break;
      case EffectType.growingVines:
        _thumbGrowingVines(canvas, center, radius);
        break;
      case EffectType.networkWeb:
        _thumbNetworkWeb(canvas, center, radius);
        break;
      case EffectType.infinitySnake:
        _thumbInfinitySnake(canvas, center, radius);
        break;
      case EffectType.graphNodes:
        _thumbGraphNodes(canvas, center, radius);
        break;
      case EffectType.waterDroplets:
        _thumbWaterDroplets(canvas, center, radius);
        break;
      case EffectType.liquidMetaballs:
        _thumbLiquidMetaballs(canvas, center, radius);
        break;
      case EffectType.morphShapes:
        _thumbMorphShapes(canvas, center, radius);
        break;
      case EffectType.geometricConstellation:
        _thumbGeometricConstellation(canvas, center, radius);
        break;
    }
  }

  Color _color(int index, {double alpha = 0.8}) {
    if (colors.isEmpty) {
      return Colors.white.withValues(alpha: alpha);
    }
    return colors[index % colors.length].withValues(alpha: alpha);
  }

  // ── Per-type thumbnail drawings ──────────────────────────────────────
  void _thumbAura(Canvas canvas, Offset center, double radius) {
    for (int i = 0; i < 3; i++) {
      final paint = Paint()
        ..color = _color(i, alpha: 0.18 - i * 0.04)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;
      canvas.drawCircle(center, radius * (0.4 + i * 0.2), paint);
    }
  }

  void _thumbStars(Canvas canvas, Offset center, double radius) {
    for (int i = 0; i < 5; i++) {
      final angle = i * 2 * pi / 5;
      final offset = Offset(
        center.dx + cos(angle) * radius * 0.6,
        center.dy + sin(angle) * radius * 0.6,
      );
      final paint = Paint()
        ..color = _color(i, alpha: 0.8)
        ..style = PaintingStyle.fill;
      drawStar(canvas, offset, 3, paint, rotation: i * 0.6);
    }
  }

  void _thumbHearts(Canvas canvas, Offset center, double radius) {
    for (int i = 0; i < 4; i++) {
      final angle = i * pi / 2;
      final offset = Offset(
        center.dx + cos(angle) * radius * 0.6,
        center.dy + sin(angle) * radius * 0.6,
      );
      final paint = Paint()
        ..color = _color(i, alpha: 0.8)
        ..style = PaintingStyle.fill;
      drawHeart(canvas, offset, 4, paint, rotation: i * 0.4);
    }
  }

  void _thumbSparkles(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = _color(0, alpha: 0.8)
      ..style = PaintingStyle.fill;
    for (int i = 0; i < 4; i++) {
      final angle = i * pi / 2;
      final offset = Offset(
        center.dx + cos(angle) * radius * 0.7,
        center.dy + sin(angle) * radius * 0.7,
      );
      final path = Path();
      path.moveTo(offset.dx, offset.dy - 4);
      path.lineTo(offset.dx + 1, offset.dy - 1);
      path.lineTo(offset.dx + 4, offset.dy);
      path.lineTo(offset.dx + 1, offset.dy + 1);
      path.lineTo(offset.dx, offset.dy + 4);
      path.lineTo(offset.dx - 1, offset.dy + 1);
      path.lineTo(offset.dx - 4, offset.dy);
      path.lineTo(offset.dx - 1, offset.dy - 1);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  void _thumbFlames(Canvas canvas, Offset center, double radius) {
    for (int i = 0; i < 4; i++) {
      final angle = i * 2 * pi / 4;
      final offset = Offset(
        center.dx + cos(angle) * radius * 0.6,
        center.dy + sin(angle) * radius * 0.6,
      );
      final paint = Paint()
        ..color = _color(i, alpha: 0.8)
        ..style = PaintingStyle.fill;
      final path = Path();
      path.moveTo(offset.dx, offset.dy + 4);
      path.quadraticBezierTo(
          offset.dx + 3, offset.dy, offset.dx, offset.dy - 4);
      path.quadraticBezierTo(
          offset.dx - 3, offset.dy, offset.dx, offset.dy + 4);
      canvas.drawPath(path, paint);
    }
  }

  void _thumbSnowflakes(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = _color(0, alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 4; i++) {
      final angle = i * pi / 2;
      final offset = Offset(
        center.dx + cos(angle) * radius * 0.6,
        center.dy + sin(angle) * radius * 0.6,
      );
      for (int j = 0; j < 4; j++) {
        final a = j * pi / 4;
        canvas.drawLine(
            offset,
            Offset(
              offset.dx + cos(a) * 4,
              offset.dy + sin(a) * 4,
            ),
            paint);
      }
    }
  }

  void _thumbButterflies(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = _color(0, alpha: 0.8)
      ..style = PaintingStyle.fill;
    for (int i = 0; i < 3; i++) {
      final angle = i * 2 * pi / 3;
      final offset = Offset(
        center.dx + cos(angle) * radius * 0.6,
        center.dy + sin(angle) * radius * 0.6,
      );
      final leftWing = Path()
        ..moveTo(offset.dx, offset.dy)
        ..quadraticBezierTo(
            offset.dx - 5, offset.dy - 3, offset.dx - 5, offset.dy)
        ..quadraticBezierTo(
            offset.dx - 3, offset.dy + 2, offset.dx, offset.dy + 1)
        ..close();
      final rightWing = Path()
        ..moveTo(offset.dx, offset.dy)
        ..quadraticBezierTo(
            offset.dx + 5, offset.dy - 3, offset.dx + 5, offset.dy)
        ..quadraticBezierTo(
            offset.dx + 3, offset.dy + 2, offset.dx, offset.dy + 1)
        ..close();
      canvas.drawPath(leftWing, paint);
      canvas.drawPath(rightWing, paint);
    }
  }

  void _thumbBirds(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = _color(0, alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 3; i++) {
      final angle = i * 2 * pi / 3;
      final offset = Offset(
        center.dx + cos(angle) * radius * 0.6,
        center.dy + sin(angle) * radius * 0.6,
      );
      final path = Path()
        ..moveTo(offset.dx - 4, offset.dy)
        ..quadraticBezierTo(
            offset.dx - 2, offset.dy - 3, offset.dx, offset.dy - 1)
        ..quadraticBezierTo(
            offset.dx + 2, offset.dy - 3, offset.dx + 4, offset.dy);
      canvas.drawPath(path, paint);
    }
  }

  void _thumbBubbles(Canvas canvas, Offset center, double radius) {
    for (int i = 0; i < 4; i++) {
      final angle = i * 2 * pi / 4;
      final offset = Offset(
        center.dx + cos(angle) * radius * 0.6,
        center.dy + sin(angle) * radius * 0.6,
      );
      final paint = Paint()
        ..color = _color(i, alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawCircle(offset, 4, paint);
    }
  }

  void _thumbParticles(Canvas canvas, Offset center, double radius) {
    for (int i = 0; i < 10; i++) {
      final angle = i * 2 * pi / 10;
      final r = radius * 0.4 + (i % 3) * radius * 0.15;
      final offset = Offset(
        center.dx + cos(angle) * r,
        center.dy + sin(angle) * r,
      );
      final paint = Paint()
        ..color = _color(i, alpha: 0.7)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(offset, 1.2 + (i % 2) * 0.6, paint);
    }
  }

  void _thumbMist(Canvas canvas, Offset center, double radius) {
    for (int i = 0; i < 5; i++) {
      final angle = i * 2 * pi / 5;
      final offset = Offset(
        center.dx + cos(angle) * radius * 0.6,
        center.dy + sin(angle) * radius * 0.6,
      );
      final paint = Paint()
        ..color = _color(i, alpha: 0.18)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(offset, 4, paint);
    }
  }

  void _thumbWavyLines(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = _color(0, alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;
    for (int ring = 0; ring < 3; ring++) {
      final path = Path();
      final r = radius * (0.4 + ring * 0.15);
      for (int i = 0; i <= 36; i++) {
        final t = i / 36 * 2 * pi;
        final wave = sin(t * 4 + ring) * 1.2;
        final x = center.dx + cos(t) * (r + wave);
        final y = center.dy + sin(t) * (r + wave);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      paint.color = _color(ring, alpha: 0.4 + ring * 0.1);
      canvas.drawPath(path, paint);
    }
  }

  void _thumbOrbitDots(Canvas canvas, Offset center, double radius) {
    final ringPaint = Paint()
      ..color = _color(0, alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    for (int i = 0; i < 2; i++) {
      canvas.drawCircle(center, radius * (0.4 + i * 0.2), ringPaint);
    }
    for (int i = 0; i < 6; i++) {
      final angle = i * 2 * pi / 6;
      final r = radius * 0.4 + (i % 2) * radius * 0.2;
      final offset = Offset(
        center.dx + cos(angle) * r,
        center.dy + sin(angle) * r,
      );
      final paint = Paint()
        ..color = _color(i, alpha: 0.8)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(offset, 1.5, paint);
    }
  }

  void _thumbRotatingRing(Canvas canvas, Offset center, double radius) {
    final segmentPaint = Paint()
      ..color = _color(0, alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 4; i++) {
      final start = (i * pi / 2);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius * 0.6),
        start,
        0.4,
        false,
        segmentPaint,
      );
    }
  }

  void _thumbAbstractShapes(Canvas canvas, Offset center, double radius) {
    for (int i = 0; i < 4; i++) {
      final angle = i * 2 * pi / 4;
      final offset = Offset(
        center.dx + cos(angle) * radius * 0.6,
        center.dy + sin(angle) * radius * 0.6,
      );
      final paint = Paint()
        ..color = _color(i, alpha: 0.6)
        ..style = PaintingStyle.fill;
      final path = Path();
      final s = 4 + (i % 2) * 1.5;
      path.moveTo(offset.dx, offset.dy - s);
      path.quadraticBezierTo(
          offset.dx + s * 1.4, offset.dy, offset.dx, offset.dy + s);
      path.quadraticBezierTo(
          offset.dx - s * 1.4, offset.dy, offset.dx, offset.dy - s);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  void _thumbRisingBubbles(Canvas canvas, Offset center, double radius) {
    for (int i = 0; i < 5; i++) {
      final x = radius * 0.2 + i * radius * 0.15;
      final y = radius * 0.6 - i * radius * 0.25;
      final offset = Offset(center.dx - radius * 0.4 + x, center.dy + y);
      final paint = Paint()
        ..color = _color(i, alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawCircle(offset, 2.5 + (i % 2) * 1, paint);
    }
  }

  void _thumbFlyingObjects(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = _color(0, alpha: 0.8)
      ..style = PaintingStyle.fill;
    drawDiamond(canvas, center.translate(-radius * 0.5, 0), 3, paint,
        rotation: pi / 4);
    drawTriangle(canvas, center.translate(0, 0), 3, paint, rotation: pi / 6);
    drawCircleOutline(
      canvas,
      center.translate(radius * 0.5, 0),
      3,
      Paint()
        ..color = _color(1, alpha: 0.8)
        ..style = PaintingStyle.fill,
    );
  }

  void _thumbPushSymbols(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = _color(0, alpha: 0.8)
      ..style = PaintingStyle.fill;
    drawDiamond(canvas, center.translate(-radius * 0.4, 0), 3, paint);
    drawStar(
        canvas,
        center,
        3,
        Paint()
          ..color = _color(1, alpha: 0.8)
          ..style = PaintingStyle.fill);
    drawTriangle(canvas, center.translate(radius * 0.4, 0), 3,
        Paint()..color = _color(2, alpha: 0.8));
  }

  void _thumbColorWaves(Canvas canvas, Offset center, double radius) {
    for (int ring = 0; ring < 3; ring++) {
      final path = Path();
      final r = radius * (0.3 + ring * 0.18);
      for (int i = 0; i <= 36; i++) {
        final t = i / 36 * 2 * pi;
        final wave = sin(t * 5 + ring) * 1.2;
        final x = center.dx + cos(t) * (r + wave);
        final y = center.dy + sin(t) * (r + wave);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      final paint = Paint()
        ..color = _color(ring, alpha: 0.4 + ring * 0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(path, paint);
    }
  }

  void _thumbGrowingVines(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = _color(0, alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 3; i++) {
      final start = Offset(center.dx - radius * 0.4 + i * radius * 0.4,
          center.dy + radius * 0.4);
      final path = Path()..moveTo(start.dx, start.dy);
      path.quadraticBezierTo(
        start.dx,
        start.dy - radius * 0.5,
        start.dx + (i - 1) * 4,
        start.dy - radius * 0.7,
      );
      canvas.drawPath(path, paint);
    }
  }

  void _thumbNetworkWeb(Canvas canvas, Offset center, double radius) {
    final positions = <Offset>[];
    for (int i = 0; i < 5; i++) {
      final angle = i * 2 * pi / 5;
      positions.add(Offset(
        center.dx + cos(angle) * radius * 0.5,
        center.dy + sin(angle) * radius * 0.5,
      ));
    }
    final linePaint = Paint()
      ..color = _color(0, alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    for (int i = 0; i < positions.length; i++) {
      for (int j = i + 1; j < positions.length; j++) {
        canvas.drawLine(positions[i], positions[j], linePaint);
      }
    }
    final nodePaint = Paint()
      ..color = _color(0, alpha: 0.8)
      ..style = PaintingStyle.fill;
    for (final p in positions) {
      canvas.drawCircle(p, 1.6, nodePaint);
    }
  }

  void _thumbInfinitySnake(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = _color(0, alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;
    final path = Path();
    for (int i = 0; i <= 40; i++) {
      final t = i / 40 * 2 * pi;
      final x = center.dx + sin(t) * radius * 0.6;
      final y = center.dy + sin(2 * t) * radius * 0.25;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  void _thumbGraphNodes(Canvas canvas, Offset center, double radius) {
    final positions = <Offset>[];
    for (int i = 0; i < 6; i++) {
      final angle = i * 2 * pi / 6;
      positions.add(Offset(
        center.dx + cos(angle) * radius * 0.5,
        center.dy + sin(angle) * radius * 0.5,
      ));
    }
    final linePaint = Paint()
      ..color = _color(0, alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    for (int i = 0; i < positions.length; i++) {
      for (int j = i + 1; j < positions.length; j++) {
        canvas.drawLine(positions[i], positions[j], linePaint);
      }
    }
    final nodePaint = Paint()
      ..color = _color(0, alpha: 0.8)
      ..style = PaintingStyle.fill;
    for (final p in positions) {
      canvas.drawCircle(p, 2, nodePaint);
    }
  }

  void _thumbWaterDroplets(Canvas canvas, Offset center, double radius) {
    for (int i = 0; i < 4; i++) {
      final angle = i * 2 * pi / 4;
      final offset = Offset(
        center.dx + cos(angle) * radius * 0.4,
        center.dy + sin(angle) * radius * 0.4,
      );
      final paint = Paint()
        ..color = _color(i, alpha: 0.7)
        ..style = PaintingStyle.fill;
      final path = Path();
      path.moveTo(offset.dx, offset.dy - 4);
      path.quadraticBezierTo(
          offset.dx + 3, offset.dy - 1, offset.dx, offset.dy + 3);
      path.quadraticBezierTo(
          offset.dx - 3, offset.dy - 1, offset.dx, offset.dy - 4);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  void _thumbLiquidMetaballs(Canvas canvas, Offset center, double radius) {
    final positions = [
      center.translate(-radius * 0.3, 0),
      center.translate(radius * 0.3, 0),
      center.translate(0, -radius * 0.3),
    ];
    for (int i = 0; i < positions.length; i++) {
      final paint = Paint()
        ..color = _color(i, alpha: 0.45)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(positions[i], 5, paint);
    }
  }

  void _thumbMorphShapes(Canvas canvas, Offset center, double radius) {
    for (int i = 0; i < 3; i++) {
      final angle = i * 2 * pi / 3;
      final offset = Offset(
        center.dx + cos(angle) * radius * 0.5,
        center.dy + sin(angle) * radius * 0.5,
      );
      final path = Path();
      final segments = 18;
      for (int s = 0; s <= segments; s++) {
        final t = s / segments * 2 * pi;
        final r = 4 + sin(t * 3 + i) * 1.5;
        final x = offset.dx + cos(t) * r;
        final y = offset.dy + sin(t) * r;
        if (s == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      final paint = Paint()
        ..color = _color(i, alpha: 0.6)
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, paint);
    }
  }

  void _thumbGeometricConstellation(
      Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = _color(0, alpha: 0.8)
      ..style = PaintingStyle.fill;
    drawDiamond(
        canvas, center.translate(-radius * 0.4, -radius * 0.2), 2.5, paint);
    drawTriangle(
        canvas, center.translate(radius * 0.4, -radius * 0.2), 2.5, paint);
    drawCircleOutline(
      canvas,
      center.translate(0, radius * 0.3),
      2.5,
      Paint()
        ..color = _color(1, alpha: 0.8)
        ..style = PaintingStyle.fill,
    );
    final squarePaint = Paint()
      ..color = _color(2, alpha: 0.8)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(
        center: center.translate(0, -radius * 0.4),
        width: 4,
        height: 4,
      ),
      squarePaint,
    );
  }

  @override
  bool shouldRepaint(covariant EffectThumbnailPainter oldDelegate) {
    return oldDelegate.effectType != effectType || oldDelegate.colors != colors;
  }
}

extension _ThumbHelpers on CustomPainter {
  void drawHeart(Canvas canvas, Offset c, double size, Paint p,
      {double rotation = 0}) {
    canvas.save();
    canvas.translate(c.dx, c.dy);
    canvas.rotate(rotation);
    final path = Path()
      ..moveTo(0, size * 0.35)
      ..cubicTo(size * 0.55, -size * 0.45, size * 1.1, size * 0.1, 0, size)
      ..cubicTo(
          -size * 1.1, size * 0.1, -size * 0.55, -size * 0.45, 0, size * 0.35);
    canvas.drawPath(path, p);
    canvas.restore();
  }

  void drawStar(Canvas canvas, Offset c, double radius, Paint p,
      {double rotation = 0}) {
    canvas.save();
    canvas.translate(c.dx, c.dy);
    canvas.rotate(rotation);
    final path = Path();
    for (int i = 0; i < 10; i++) {
      final angle = i * pi / 5 - pi / 2;
      final r = i.isEven ? radius : radius * 0.42;
      final point = Offset(cos(angle) * r, sin(angle) * r);
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    canvas.drawPath(path, p);
    canvas.restore();
  }

  void drawDiamond(Canvas canvas, Offset c, double size, Paint p,
      {double rotation = 0}) {
    final path = Path()
      ..moveTo(0, -size)
      ..lineTo(size, 0)
      ..lineTo(0, size)
      ..lineTo(-size, 0)
      ..close();
    canvas.save();
    canvas.translate(c.dx, c.dy);
    canvas.rotate(rotation);
    canvas.drawPath(path, p);
    canvas.restore();
  }

  void drawTriangle(Canvas canvas, Offset c, double size, Paint p,
      {double rotation = 0}) {
    final path = Path()
      ..moveTo(0, -size)
      ..lineTo(size * 0.95, size * 0.85)
      ..lineTo(-size * 0.95, size * 0.85)
      ..close();
    canvas.save();
    canvas.translate(c.dx, c.dy);
    canvas.rotate(rotation);
    canvas.drawPath(path, p);
    canvas.restore();
  }

  void drawCircleOutline(Canvas canvas, Offset c, double size, Paint p) {
    canvas.drawCircle(c, size, p);
  }
}

/// Professional ambient cosmetic effects.
/// Each effect type has a distinct visual identity while maintaining:
/// - Close perimeter positioning (radius 0.42)
/// - Subtle, slow animation
/// - Performance optimization (reduced particle count)
class CosmeticEffectPainter extends CustomPainter {
  final EffectType effectType;
  final double phase;
  final List<Color> colors;

  CosmeticEffectPainter({
    required this.effectType,
    required this.phase,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    switch (effectType) {
      case EffectType.stars:
        _paintStars(canvas, size);
        break;
      case EffectType.hearts:
        _paintHearts(canvas, size);
        break;
      case EffectType.sparkles:
        _paintSparkles(canvas, size);
        break;
      case EffectType.flames:
        _paintFlames(canvas, size);
        break;
      case EffectType.snowflakes:
        _paintSnowflakes(canvas, size);
        break;
      case EffectType.aura:
        _paintAura(canvas, size);
        break;
      case EffectType.butterflies:
        _paintButterflies(canvas, size);
        break;
      case EffectType.bubbles:
        _paintBubbles(canvas, size);
        break;
      case EffectType.particles:
        _paintParticles(canvas, size);
        break;
      case EffectType.mist:
        _paintMist(canvas, size);
        break;
      case EffectType.wavyLines:
        _paintWavyLines(canvas, size);
        break;
      case EffectType.orbitDots:
        _paintOrbitDots(canvas, size);
        break;
      case EffectType.rotatingRing:
        _paintRotatingRing(canvas, size);
        break;
      case EffectType.abstractShapes:
        _paintAbstractShapes(canvas, size);
        break;
      case EffectType.birds:
        _paintBirds(canvas, size);
        break;
      case EffectType.risingBubbles:
        _paintRisingBubbles(canvas, size);
        break;
      case EffectType.flyingObjects:
        _paintFlyingObjects(canvas, size);
        break;
      case EffectType.pushSymbols:
        _paintPushSymbols(canvas, size);
        break;
      case EffectType.colorWaves:
        _paintColorWaves(canvas, size);
        break;
      case EffectType.growingVines:
        _paintGrowingVines(canvas, size);
        break;
      case EffectType.networkWeb:
        _paintNetworkWeb(canvas, size);
        break;
      case EffectType.infinitySnake:
        _paintInfinitySnake(canvas, size);
        break;
      case EffectType.graphNodes:
        _paintGraphNodes(canvas, size);
        break;
      case EffectType.waterDroplets:
        _paintWaterDroplets(canvas, size);
        break;
      case EffectType.liquidMetaballs:
        _paintLiquidMetaballs(canvas, size);
        break;
      case EffectType.morphShapes:
        _paintMorphShapes(canvas, size);
        break;
      case EffectType.geometricConstellation:
        _paintGeometricConstellation(canvas, size);
        break;
    }
  }

  Color _color(int index, {double alpha = 0.8}) {
    if (colors.isEmpty) {
      return Colors.white.withValues(alpha: alpha);
    }
    return colors[index % colors.length].withValues(alpha: alpha);
  }

  Offset _perimeterOffset(Size size, double angle,
      {double radiusFactor = 0.42}) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * radiusFactor;
    return Offset(
      center.dx + cos(angle) * radius,
      center.dy + sin(angle) * radius,
    );
  }

  double _random01(int seed) {
    final value = sin(seed * 12.9898) * 43758.5453;
    return value - value.floor();
  }

  void _drawTextSymbol(
    Canvas canvas,
    Offset center,
    String symbol,
    double fontSize,
    Paint paint, {
    double rotation = 0,
    double scale = 1,
  }) {
    final painter = TextPainter(
      text: TextSpan(
        text: symbol,
        style: TextStyle(
          fontSize: fontSize,
          color: paint.color,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    painter.layout();

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.scale(scale);
    painter.paint(canvas, Offset(-painter.width / 2, -painter.height / 2));
    canvas.restore();
    painter.dispose();
  }

  // ── STARS: Twinkling star particles with subtle trails ─────────────
  void _paintStars(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Subtle outer glow ring.
    final glowPaint = Paint()
      ..color = _color(0, alpha: 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    canvas.drawCircle(center, size.width * 0.42, glowPaint);

    // Orbiting stars on the perimeter.
    for (int i = 0; i < 8; i++) {
      final angle = (i * 2 * pi / 8) + (phase * 2 * pi);
      final offset = _perimeterOffset(size, angle);
      final pulse = 0.75 + 0.25 * sin((phase * 1 + i * 0.2) * 2 * pi);
      final alpha = 0.5 + 0.35 * pulse;
      final paint = Paint()
        ..color = _color(i, alpha: alpha)
        ..style = PaintingStyle.fill;
      _drawStar(
        canvas,
        offset,
        4 + pulse * 4,
        paint,
        rotation: phase * 2 * pi + i * 0.5,
      );
    }

    // Subtle star trails.
    final trailPaint = Paint()
      ..color = _color(1, alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 4; i++) {
      final angle = (i * 2 * pi / 4) + (phase * 2 * pi);
      final start = _perimeterOffset(size, angle);
      final end = _perimeterOffset(size, angle - 0.12, radiusFactor: 0.43);
      canvas.drawLine(start, end, trailPaint);
    }
  }

  void _drawStar(
    Canvas canvas,
    Offset center,
    double radius,
    Paint paint, {
    double rotation = 0,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    final path = Path();
    for (int i = 0; i < 10; i++) {
      final angle = i * pi / 5 - pi / 2;
      final r = i.isEven ? radius : radius * 0.42;
      final point = Offset(cos(angle) * r, sin(angle) * r);
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  // ── HEARTS: Floating heart petals with soft pulse ───────────────────
  void _paintHearts(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Soft heart aura ring.
    final glowPaint = Paint()
      ..color = _color(0, alpha: 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawCircle(center, size.width * 0.42, glowPaint);

    // Floating heart particles on the perimeter.
    for (int i = 0; i < 8; i++) {
      final angle = (i * 2 * pi / 8) + (phase * 2 * pi);
      final offset = _perimeterOffset(size, angle);
      final pulse = 0.85 + 0.15 * sin((phase + i * 0.18) * 2 * pi);
      final alpha = 0.5 + 0.3 * sin((phase + i * 0.18) * 2 * pi);
      final paint = Paint()
        ..color = _color(i, alpha: alpha)
        ..style = PaintingStyle.fill;
      _drawHeart(
        canvas,
        offset,
        5 * pulse,
        paint,
        rotation: phase * 2 * pi + i * 0.3,
      );
    }

    // Heart-shaped orbit trail.
    final trailPaint = Paint()
      ..color = _color(1, alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    final path = Path();
    for (int i = 0; i <= 60; i++) {
      final t = i / 60 * 2 * pi;
      final x = size.width * 0.5 + size.width * 0.42 * sin(t + phase * 2 * pi);
      final y = size.height * 0.5 +
          size.height * 0.42 * (sin(t * 2 + phase * 2 * pi) * 0.45);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, trailPaint);
  }

  void _drawHeart(
    Canvas canvas,
    Offset center,
    double scale,
    Paint paint, {
    double rotation = 0,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    final path = Path();
    path.moveTo(0, scale * 0.35);
    path.cubicTo(
      scale * 0.55,
      scale * -0.45,
      scale * 1.1,
      scale * 0.1,
      0,
      scale,
    );
    path.cubicTo(
      scale * -1.1,
      scale * 0.1,
      scale * -0.55,
      scale * -0.45,
      0,
      scale * 0.35,
    );
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  // ── SPARKLES: Diamond sparkles with light beams ──────────────────────
  void _paintSparkles(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Radiant sparkle ring.
    final glowPaint = Paint()
      ..color = _color(0, alpha: 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawCircle(center, size.width * 0.42, glowPaint);

    // Sparkle particles around the perimeter.
    for (int i = 0; i < 10; i++) {
      final angle = (i * 2 * pi / 10) + (phase * 2 * pi);
      final offset = _perimeterOffset(size, angle);
      final pulse = 0.65 + 0.35 * sin((phase * 2 + i * 0.25) * 2 * pi);
      final alpha = 0.45 + 0.4 * pulse;
      final paint = Paint()
        ..color = _color(i, alpha: alpha)
        ..style = PaintingStyle.fill;
      _drawSparkle(
        canvas,
        offset,
        3 + pulse * 4,
        paint,
        rotation: phase * 2 * pi + i * 0.4,
      );
    }

    // Light beams from the center.
    final beamPaint = Paint()
      ..color = _color(1, alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 4; i++) {
      final angle = (i * 2 * pi / 4) + (phase * 2 * pi);
      final start = _perimeterOffset(size, angle, radiusFactor: 0.32);
      final end = _perimeterOffset(size, angle, radiusFactor: 0.5);
      canvas.drawLine(start, end, beamPaint);
    }
  }

  void _drawSparkle(
    Canvas canvas,
    Offset center,
    double size,
    Paint paint, {
    double rotation = 0,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    final path = Path();
    path.moveTo(0, -size);
    path.lineTo(size * 0.22, -size * 0.22);
    path.lineTo(size, 0);
    path.lineTo(size * 0.22, size * 0.22);
    path.lineTo(0, size);
    path.lineTo(-size * 0.22, size * 0.22);
    path.lineTo(-size, 0);
    path.lineTo(-size * 0.22, -size * 0.22);
    path.close();
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  // ── FLAMES: Flickering flame wisps ────────────────────────────────────
  void _paintFlames(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Flame aura ring.
    final glowPaint = Paint()
      ..color = _color(0, alpha: 0.1)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    canvas.drawCircle(center, size.width * 0.42, glowPaint);

    // Flickering flame particles on the perimeter.
    for (int i = 0; i < 8; i++) {
      final angle = (i * 2 * pi / 8) + (phase * 2 * pi);
      final offset = _perimeterOffset(size, angle);
      final flicker = 0.85 + 0.2 * sin((phase * 4 + i * 0.35) * 2 * pi);
      final alpha = 0.5 + 0.3 * sin((phase * 1 + i * 0.2) * 2 * pi);
      final paint = Paint()
        ..color = _color(i, alpha: alpha)
        ..style = PaintingStyle.fill;
      _drawFlame(
        canvas,
        offset,
        7 * flicker,
        paint,
        rotation: sin(phase * 2 * pi + i) * 0.15,
      );
    }

    // Flame wisps.
    final wispPaint = Paint()
      ..color = _color(1, alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 4; i++) {
      final angle = (i * 2 * pi / 4) + (phase * 2 * pi);
      final start = _perimeterOffset(size, angle);
      final end = _perimeterOffset(size, angle - 0.15, radiusFactor: 0.44);
      canvas.drawLine(start, end, wispPaint);
    }
  }

  void _drawFlame(
    Canvas canvas,
    Offset center,
    double size,
    Paint paint, {
    double rotation = 0,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    final path = Path();
    path.moveTo(0, size);
    path.quadraticBezierTo(
      size * 0.75,
      size * 0.1,
      size * 0.25,
      -size,
    );
    path.quadraticBezierTo(
      -size * 0.35,
      -size * 0.2,
      -size * 0.65,
      size * 0.25,
    );
    path.quadraticBezierTo(
      -size * 0.15,
      size * 0.45,
      0,
      size,
    );
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  // ── SNOWFLAKES: Delicate snow crystals with shimmer ──────────────────
  void _paintSnowflakes(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Snow aura ring.
    final glowPaint = Paint()
      ..color = _color(0, alpha: 0.07)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawCircle(center, size.width * 0.42, glowPaint);

    // Snowflakes on the perimeter.
    for (int i = 0; i < 8; i++) {
      final angle = (i * 2 * pi / 8) + (phase * 2 * pi);
      final offset = _perimeterOffset(size, angle);
      final alpha = 0.6 + 0.25 * sin((phase + i * 0.2) * 2 * pi);
      final paint = Paint()
        ..color = _color(i, alpha: alpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..strokeCap = StrokeCap.round;
      _drawSnowflake(
        canvas,
        offset,
        5 + (i % 3) * 1.2,
        paint,
        rotation: phase * 2 * pi + i * 0.4,
      );
    }

    // Snow shimmer dots.
    final particlePaint = Paint()
      ..color = _color(1, alpha: 0.25)
      ..style = PaintingStyle.fill;
    for (int i = 0; i < 12; i++) {
      final angle = (i * 2 * pi / 12) + (phase * 2 * pi);
      final offset = _perimeterOffset(size, angle, radiusFactor: 0.45);
      canvas.drawCircle(offset, 1.2 + (i % 2), particlePaint);
    }
  }

  void _drawSnowflake(
    Canvas canvas,
    Offset center,
    double size,
    Paint paint, {
    double rotation = 0,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);

    for (int i = 0; i < 6; i++) {
      final angle = i * pi / 3;
      final end = Offset(cos(angle) * size, sin(angle) * size);
      canvas.drawLine(Offset.zero, end, paint);

      final branchAngle1 = angle + pi / 5;
      final branchAngle2 = angle - pi / 5;
      final branchStart =
          Offset(cos(angle) * size * 0.55, sin(angle) * size * 0.55);
      final branchEnd1 = Offset(
        branchStart.dx + cos(branchAngle1) * size * 0.3,
        branchStart.dy + sin(branchAngle1) * size * 0.3,
      );
      final branchEnd2 = Offset(
        branchStart.dx + cos(branchAngle2) * size * 0.3,
        branchStart.dy + sin(branchAngle2) * size * 0.3,
      );
      canvas.drawLine(branchStart, branchEnd1, paint);
      canvas.drawLine(branchStart, branchEnd2, paint);
    }
    canvas.restore();
  }

  // ── AURA: Pulsing energy rings ────────────────────────────────────────
  void _paintAura(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = size.width * 0.41;

    // Three subtle glowing rings with different radii and opacities.
    for (int ring = 0; ring < 3; ring++) {
      final animatedRadius =
          baseRadius + sin((phase * 2 * pi) + ring * 0.8) * (5 + ring * 2);
      final alpha = 0.04 + (3 - ring) * 0.035;
      final paint = Paint()
        ..color = _color(ring, alpha: alpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5 + (3 - ring) * 0.4
        ..strokeCap = StrokeCap.round;
      canvas.drawCircle(center, animatedRadius, paint);
    }

    // Aura particles.
    final particlePaint = Paint()
      ..color = _color(0, alpha: 0.2)
      ..style = PaintingStyle.fill;
    for (int i = 0; i < 8; i++) {
      final angle = (i * 2 * pi / 8) + (phase * 2 * pi);
      final offset = _perimeterOffset(size, angle, radiusFactor: 0.43);
      canvas.drawCircle(offset, 1.5 + (i % 2), particlePaint);
    }
  }

  // ── BUTTERFLIES: Delicate wing patterns ───────────────────────────────
  void _paintButterflies(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Butterfly aura ring.
    final glowPaint = Paint()
      ..color = _color(0, alpha: 0.07)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawCircle(center, size.width * 0.42, glowPaint);

    // Butterflies orbiting the perimeter.
    for (int i = 0; i < 6; i++) {
      final angle = (i * 2 * pi / 6) + (phase * 2 * pi);
      final offset = _perimeterOffset(size, angle);
      final alpha = 0.55 + 0.25 * sin((phase + i * 0.2) * 2 * pi);
      final paint = Paint()
        ..color = _color(i, alpha: alpha)
        ..style = PaintingStyle.fill;
      final flap = sin((phase * 4 + i) * 2 * pi) * 0.12;
      _drawButterfly(
        canvas,
        offset,
        6 + (i % 2) * 1.5,
        paint,
        wingFlap: flap,
        rotation: angle + pi / 2,
      );
    }

    // Wing trail arcs.
    final trailPaint = Paint()
      ..color = _color(1, alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 3; i++) {
      final angle = (i * 2 * pi / 3) + (phase * 2 * pi);
      final start = _perimeterOffset(size, angle);
      final mid = _perimeterOffset(size, angle - 0.08, radiusFactor: 0.44);
      final end = _perimeterOffset(size, angle - 0.16, radiusFactor: 0.45);
      final path = Path()
        ..moveTo(start.dx, start.dy)
        ..quadraticBezierTo(mid.dx, mid.dy, end.dx, end.dy);
      canvas.drawPath(path, trailPaint);
    }
  }

  void _drawButterfly(
    Canvas canvas,
    Offset center,
    double size,
    Paint paint, {
    double wingFlap = 0,
    double rotation = 0,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);

    final leftWing = Path();
    leftWing.moveTo(0, 0);
    leftWing.quadraticBezierTo(
      -size * (1.2 + wingFlap),
      -size * 0.8,
      -size * 1.25,
      -size * 0.1,
    );
    leftWing.quadraticBezierTo(
      -size * 0.7,
      size * 0.4,
      0,
      size * 0.3,
    );
    leftWing.close();

    final rightWing = Path();
    rightWing.moveTo(0, 0);
    rightWing.quadraticBezierTo(
      size * (1.2 + wingFlap),
      -size * 0.8,
      size * 1.25,
      -size * 0.1,
    );
    rightWing.quadraticBezierTo(
      size * 0.7,
      size * 0.4,
      0,
      size * 0.3,
    );
    rightWing.close();

    canvas.drawPath(leftWing, paint);
    canvas.drawPath(rightWing, paint);

    final bodyPaint = Paint()
      ..color = _color(2, alpha: 0.45)
      ..style = PaintingStyle.fill;
    final bodyPath = Path();
    bodyPath.addOval(Rect.fromCenter(
      center: Offset(0, size * 0.12),
      width: size * 0.18,
      height: size * 0.75,
    ));
    canvas.drawPath(bodyPath, bodyPaint);
    canvas.restore();
  }

  // ── BUBBLES: Floating bubble particles ────────────────────────────────
  void _paintBubbles(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Bubble aura ring.
    final glowPaint = Paint()
      ..color = _color(0, alpha: 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawCircle(center, size.width * 0.42, glowPaint);

    // Bubble particles on the perimeter.
    for (int i = 0; i < 10; i++) {
      final angle = (i * 2 * pi / 10) + (phase * 2 * pi);
      final offset = _perimeterOffset(size, angle);
      final pulse = 0.85 + 0.15 * sin((phase + i * 0.2) * 2 * pi);
      final alpha = 0.25 + 0.25 * pulse;
      final bubblePaint = Paint()
        ..color = _color(i, alpha: alpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;
      final bubbleFill = Paint()
        ..color = _color(i, alpha: alpha * 0.35)
        ..style = PaintingStyle.fill;
      final bubbleSize = 3 + (i % 3) * 1.5 + pulse * 1.5;
      canvas.drawCircle(offset, bubbleSize, bubbleFill);
      canvas.drawCircle(offset, bubbleSize, bubblePaint);

      // Bubble highlight.
      final highlightPaint = Paint()
        ..color = _color(i + 1, alpha: alpha * 0.5)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(offset.dx - bubbleSize * 0.3, offset.dy - bubbleSize * 0.3),
        bubbleSize * 0.25,
        highlightPaint,
      );
    }
  }

  // ── PARTICLES: Floating particle dust ─────────────────────────────────
  void _paintParticles(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Particle aura ring.
    final glowPaint = Paint()
      ..color = _color(0, alpha: 0.06)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawCircle(center, size.width * 0.42, glowPaint);

    // Particle dust on the perimeter.
    for (int i = 0; i < 16; i++) {
      final angle = (i * 2 * pi / 16) + (phase * 2 * pi);
      final offset = _perimeterOffset(size, angle);
      final pulse = 0.6 + 0.4 * sin((phase * 2 + i * 0.15) * 2 * pi);
      final alpha = 0.25 + 0.35 * pulse;
      final particlePaint = Paint()
        ..color = _color(i, alpha: alpha)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
          offset, 1.5 + (i % 3) * 0.8 + pulse * 0.8, particlePaint);
    }

    // Particle trails.
    final trailPaint = Paint()
      ..color = _color(1, alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 6; i++) {
      final angle = (i * 2 * pi / 6) + (phase * 2 * pi);
      final start = _perimeterOffset(size, angle);
      final end = _perimeterOffset(size, angle - 0.1, radiusFactor: 0.43);
      canvas.drawLine(start, end, trailPaint);
    }
  }

  // ── MIST: Soft mist/fog particles ─────────────────────────────────────
  void _paintMist(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Mist aura ring.
    final glowPaint = Paint()
      ..color = _color(0, alpha: 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    canvas.drawCircle(center, size.width * 0.42, glowPaint);

    // Mist particles.
    for (int i = 0; i < 12; i++) {
      final angle = (i * 2 * pi / 12) + (phase * 2 * pi);
      final offset = _perimeterOffset(size, angle);
      final pulse = 0.7 + 0.3 * sin((phase + i * 0.2) * 2 * pi);
      final alpha = 0.12 + 0.18 * pulse;
      final mistPaint = Paint()
        ..color = _color(i, alpha: alpha)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(offset, 4 + (i % 3) * 2 + pulse * 2, mistPaint);
    }

    // Mist wisps.
    final wispPaint = Paint()
      ..color = _color(1, alpha: 0.1)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 4; i++) {
      final angle = (i * 2 * pi / 4) + (phase * 2 * pi);
      final start = _perimeterOffset(size, angle);
      final mid = _perimeterOffset(size, angle - 0.08, radiusFactor: 0.44);
      final end = _perimeterOffset(size, angle - 0.16, radiusFactor: 0.45);
      final path = Path()
        ..moveTo(start.dx, start.dy)
        ..quadraticBezierTo(mid.dx, mid.dy, end.dx, end.dy);
      canvas.drawPath(path, wispPaint);
    }
  }

  // ── WAVY LINES: Animated wave lines (inspired by Lottie Radio_02) ─────
  void _paintWavyLines(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Subtle outer glow ring.
    final glowPaint = Paint()
      ..color = _color(0, alpha: 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawCircle(center, size.width * 0.42, glowPaint);

    // Wavy line paths.
    final linePaint = Paint()
      ..color = _color(0, alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (int ring = 0; ring < 3; ring++) {
      final path = Path();
      final radius = size.width * (0.34 + ring * 0.04);
      for (int i = 0; i <= 80; i++) {
        final angle = i / 80 * 2 * pi;
        final wave = sin(angle * 4 + phase * 2 * pi + ring) * 8;
        final x = center.dx + cos(angle) * (radius + wave);
        final y = center.dy + sin(angle) * (radius + wave);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      linePaint.color = _color(ring, alpha: 0.25 + ring * 0.08);
      canvas.drawPath(path, linePaint);
    }
  }

  // ── ORBIT DOTS: Orbiting dots (inspired by Lottie Cred Points) ───────
  void _paintOrbitDots(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Orbit rings.
    final ringPaint = Paint()
      ..color = _color(0, alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    for (int i = 0; i < 3; i++) {
      canvas.drawCircle(center, size.width * (0.38 + i * 0.04), ringPaint);
    }

    // Orbiting dots.
    for (int i = 0; i < 12; i++) {
      final angle = (i * 2 * pi / 12) + (phase * 2 * pi);
      final ringIndex = i % 3;
      final radius = size.width * (0.38 + ringIndex * 0.04);
      final offset = Offset(
        center.dx + cos(angle) * radius,
        center.dy + sin(angle) * radius,
      );
      final pulse = 0.8 + 0.2 * sin((phase + i * 0.2) * 2 * pi);
      final dotPaint = Paint()
        ..color = _color(i, alpha: 0.5 + 0.3 * pulse)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(offset, 2 + pulse * 2, dotPaint);
    }
  }

  // ── ROTATING RING: Rotating segmented ring ────────────────────────────
  void _paintRotatingRing(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Base ring.
    final basePaint = Paint()
      ..color = _color(0, alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(center, size.width * 0.42, basePaint);

    // Rotating segments.
    final segmentPaint = Paint()
      ..color = _color(1, alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 6; i++) {
      final startAngle = (i * 2 * pi / 6) + (phase * 2 * pi);
      final endAngle = startAngle + 0.35;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width * 0.42),
        startAngle,
        endAngle - startAngle,
        false,
        segmentPaint,
      );
    }

    // Inner rotating ring.
    final innerPaint = Paint()
      ..color = _color(2, alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 4; i++) {
      final startAngle = (i * 2 * pi / 4) - (phase * 2 * pi);
      final endAngle = startAngle + 0.3;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width * 0.34),
        startAngle,
        endAngle - startAngle,
        false,
        innerPaint,
      );
    }
  }

  // ── ABSTRACT SHAPES: Organic abstract shapes (inspired by Lottie Seekr) ─
  void _paintAbstractShapes(Canvas canvas, Size size) {
    // Abstract shape paths.
    for (int i = 0; i < 5; i++) {
      final angle = (i * 2 * pi / 5) + (phase * 2 * pi);
      final offset = _perimeterOffset(size, angle);
      final shapePaint = Paint()
        ..color = _color(i, alpha: 0.25 + i * 0.04)
        ..style = PaintingStyle.fill;

      final path = Path();
      final shapeSize = 10 + (i % 3) * 4;
      path.moveTo(offset.dx, offset.dy - shapeSize);
      path.quadraticBezierTo(
        offset.dx + shapeSize * 1.5,
        offset.dy - shapeSize * 0.5,
        offset.dx + shapeSize * 0.8,
        offset.dy + shapeSize * 0.3,
      );
      path.quadraticBezierTo(
        offset.dx - shapeSize * 0.5,
        offset.dy + shapeSize * 1.2,
        offset.dx - shapeSize * 1.2,
        offset.dy + shapeSize * 0.2,
      );
      path.quadraticBezierTo(
        offset.dx - shapeSize * 0.8,
        offset.dy - shapeSize * 0.5,
        offset.dx,
        offset.dy - shapeSize,
      );
      path.close();
      canvas.drawPath(path, shapePaint);
    }

    // Connecting lines.
    final linePaint = Paint()
      ..color = _color(0, alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 5; i++) {
      final angle1 = (i * 2 * pi / 5) + (phase * 2 * pi);
      final angle2 = ((i + 1) * 2 * pi / 5) + (phase * 2 * pi);
      final start = _perimeterOffset(size, angle1);
      final end = _perimeterOffset(size, angle2);
      canvas.drawLine(start, end, linePaint);
    }
  }

  // ── BIRDS: Flying silhouettes with motion trails ──────────────────────
  void _paintBirds(Canvas canvas, Size size) {
    // Bird motion trails.
    final trailPaint = Paint()
      ..color = _color(0, alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 5; i++) {
      final angle = (i * 2 * pi / 5) + (phase * 2 * pi);
      final offset = _perimeterOffset(size, angle);
      _drawBird(canvas, offset, 8, trailPaint);
    }

    // Main birds on the perimeter.
    for (int i = 0; i < 5; i++) {
      final angle = (i * 2 * pi / 5) + (phase * 2 * pi);
      final offset = _perimeterOffset(size, angle);
      final alpha = 0.55 + 0.25 * sin((phase + i * 0.25) * 2 * pi);
      final paint = Paint()
        ..color = _color(i, alpha: alpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      _drawBird(
        canvas,
        offset,
        6 + (i % 2),
        paint,
        rotation: angle + pi / 2,
      );
    }

    // Wing arc accents.
    final arcPaint = Paint()
      ..color = _color(1, alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 3; i++) {
      final angle = (i * 2 * pi / 3) + (phase * 2 * pi);
      final start = _perimeterOffset(size, angle);
      final mid = _perimeterOffset(size, angle - 0.08, radiusFactor: 0.44);
      final end = _perimeterOffset(size, angle - 0.16, radiusFactor: 0.45);
      final path = Path()
        ..moveTo(start.dx, start.dy)
        ..quadraticBezierTo(mid.dx, mid.dy, end.dx, end.dy);
      canvas.drawPath(path, arcPaint);
    }
  }

  void _drawBird(
    Canvas canvas,
    Offset center,
    double size,
    Paint paint, {
    double rotation = 0,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);

    final path = Path();
    path.moveTo(-size, 0);
    path.quadraticBezierTo(
      -size * 0.5,
      -size * 0.65,
      0,
      -size * 0.2,
    );
    path.quadraticBezierTo(
      size * 0.5,
      -size * 0.65,
      size,
      0,
    );
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  // ── RISING BUBBLES: Full background bubbles rising upward ─────────────
  void _paintRisingBubbles(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final glowPaint = Paint()
      ..color = _color(0, alpha: 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18;
    canvas.drawCircle(center, size.width * 0.48, glowPaint);

    final fillPaint = Paint()..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    for (int i = 0; i < 28; i++) {
      final t = (phase + i * 0.071) % 1;
      final x = size.width * (0.06 + _random01(i + 1) * 0.88);
      final y = size.height * (1.18 - t * 1.28);
      final radius =
          5 + _random01(i + 17) * 10 + sin((phase + i) * 2 * pi) * 1.2;
      final alpha = 0.14 + _random01(i + 31) * 0.16;
      final offset = Offset(x, y);

      fillPaint.color = _color(i, alpha: alpha * 0.35);
      strokePaint.color = _color(i + 1, alpha: alpha);
      canvas.drawCircle(offset, radius, fillPaint);
      canvas.drawCircle(offset, radius, strokePaint);

      final highlightPaint = Paint()
        ..color = _color(i + 2, alpha: alpha * 0.55)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(offset.dx - radius * 0.32, offset.dy - radius * 0.32),
        max(1.2, radius * 0.22),
        highlightPaint,
      );
    }
  }

  // ── FLYING OBJECTS: Geometric objects crossing the full background ─────
  void _paintFlyingObjects(Canvas canvas, Size size) {
    final trailPaint = Paint()
      ..color = _color(0, alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final objectPaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < 18; i++) {
      final t = (phase + i * 0.113) % 1;
      final x = size.width * (-0.15 + t * 1.3);
      final y = size.height * (0.14 + _random01(i + 7) * 0.72);
      final scale = 0.75 + _random01(i + 11) * 1.1;
      final offset = Offset(x, y);
      final rotation = phase * 2 * pi + i;

      final start = Offset(x - 28 * scale, y + 5 * sin(rotation) * scale);
      canvas.drawLine(start, offset, trailPaint);

      objectPaint.color = _color(i, alpha: 0.24 + _random01(i + 19) * 0.18);
      if (i % 3 == 0) {
        _drawDiamond(canvas, offset, 8 * scale, objectPaint,
            rotation: rotation);
      } else if (i % 3 == 1) {
        _drawTriangle(canvas, offset, 8 * scale, objectPaint,
            rotation: rotation);
      } else {
        _drawSmallOrbit(canvas, offset, 7 * scale, objectPaint,
            rotation: rotation);
      }
    }
  }

  void _drawDiamond(Canvas canvas, Offset center, double size, Paint paint,
      {double rotation = 0}) {
    final path = Path()
      ..moveTo(0, -size)
      ..lineTo(size, 0)
      ..lineTo(0, size)
      ..lineTo(-size, 0)
      ..close();
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void _drawTriangle(Canvas canvas, Offset center, double size, Paint paint,
      {double rotation = 0}) {
    final path = Path()
      ..moveTo(0, -size)
      ..lineTo(size * 0.95, size * 0.85)
      ..lineTo(-size * 0.95, size * 0.85)
      ..close();
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void _drawSmallOrbit(Canvas canvas, Offset center, double size, Paint paint,
      {double rotation = 0}) {
    final path = Path();
    for (int i = 0; i <= 18; i++) {
      final angle = i / 18 * 2 * pi;
      final point = Offset(cos(angle) * size, sin(angle) * size);
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  // ── PUSH SYMBOLS: Different symbols repelling each other ──────────────
  void _paintPushSymbols(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = _color(0, alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    final textPaint = Paint()..style = PaintingStyle.fill;

    final symbols = ["✦", "●", "◆", "▲", "■", "♥", "●", "✚"];
    final offsets = <Offset>[];

    for (int i = 0; i < 18; i++) {
      final baseX = size.width * (0.16 + _random01(i + 1) * 0.68);
      final baseY = size.height * (0.14 + _random01(i + 5) * 0.72);
      final driftX = sin(phase * 2 * pi + i * 0.7) * 10;
      final driftY = cos(phase * 2 * pi + i * 0.9) * 10;
      offsets.add(Offset(baseX + driftX, baseY + driftY));
    }

    for (int i = 0; i < offsets.length; i++) {
      for (int j = i + 1; j < offsets.length; j++) {
        final dx = offsets[i].dx - offsets[j].dx;
        final dy = offsets[i].dy - offsets[j].dy;
        final distance = sqrt(dx * dx + dy * dy);
        if (distance < 58) {
          final alpha = (1 - distance / 58) * 0.12;
          linePaint.color = _color(i, alpha: alpha);
          canvas.drawLine(offsets[i], offsets[j], linePaint);
        }
      }
    }

    for (int i = 0; i < offsets.length; i++) {
      textPaint.color = _color(i, alpha: 0.28 + _random01(i + 23) * 0.22);
      _drawTextSymbol(
        canvas,
        offsets[i],
        symbols[i % symbols.length],
        16 + (i % 3) * 2,
        textPaint,
        rotation: phase * 2 * pi + i,
        scale: 0.9 + _random01(i + 29) * 0.25,
      );
    }
  }

  // ── COLOR WAVES: Full background gradient waves ────────────────────────
  void _paintColorWaves(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final glowPaint = Paint()
      ..color = _color(0, alpha: 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 22;
    canvas.drawCircle(center, size.width * 0.5, glowPaint);

    for (int ring = 0; ring < 5; ring++) {
      final path = Path();
      final radius = size.width * (0.28 + ring * 0.055);
      final wave = 8 + ring * 2;
      for (int i = 0; i <= 96; i++) {
        final angle = i / 96 * 2 * pi;
        final ripple = sin(angle * 5 + phase * 2 * pi + ring * 0.7) * wave;
        final x = center.dx + cos(angle) * (radius + ripple);
        final y = center.dy + sin(angle) * (radius + ripple);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      final paint = Paint()
        ..color = _color(ring, alpha: 0.16 + ring * 0.035)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5 + ring * 0.45
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(path, paint);
    }
  }

  // ── GROWING VINES: Continuously growing vines from edges ───────────────
  void _paintGrowingVines(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final leafPaint = Paint()..style = PaintingStyle.fill;

    final starts = [
      Offset(size.width * 0.12, size.height + 10),
      Offset(size.width * 0.32, size.height + 10),
      Offset(size.width * 0.68, size.height + 10),
      Offset(size.width * 0.88, size.height + 10),
      Offset(-10, size.height * 0.5),
      Offset(size.width + 10, size.height * 0.48),
    ];

    for (int i = 0; i < starts.length; i++) {
      final grow = (phase + i * 0.19) % 1;
      final fromBottom = i < starts.length - 2;
      final startX = starts[i].dx;
      final startY = starts[i].dy;
      final endX = fromBottom
          ? size.width * (0.22 + i * 0.18 + sin(phase * 2 * pi + i) * 0.06)
          : size.width * (0.5 + sin(phase * 2 * pi + i) * 0.18);
      final endY = fromBottom
          ? size.height * (0.72 - grow * 0.58)
          : size.height * (0.5 + cos(phase * 2 * pi + i) * 0.18);
      final controlX = size.width * (0.5 + sin(phase * 2 * pi + i) * 0.28);
      final controlY = size.height * (0.55 - grow * 0.25);

      final path = Path()..moveTo(startX, startY);
      final points = <Offset>[];
      for (int p = 1; p <= 24; p++) {
        final t = p / 24;
        final x = pow(1 - t, 2) * startX +
            2 * (1 - t) * t * controlX +
            pow(t, 2) * endX;
        final y = pow(1 - t, 2) * startY +
            2 * (1 - t) * t * controlY +
            pow(t, 2) * endY;
        points.add(Offset(x.toDouble(), y.toDouble()));
        if (t <= grow) {
          path.lineTo(x.toDouble(), y.toDouble());
        }
      }

      linePaint.color = _color(i, alpha: 0.2 + grow * 0.2);
      canvas.drawPath(path, linePaint);

      for (int leaf = 3;
          leaf < points.length && leaf / points.length <= grow;
          leaf += 3) {
        final point = points[leaf];
        final side = leaf.isEven ? 1 : -1;
        final leafSize = 4 + (leaf % 4) * 1.5;
        final leafPath = Path()
          ..moveTo(point.dx, point.dy)
          ..quadraticBezierTo(
            point.dx + side * leafSize * 1.4,
            point.dy - leafSize * 0.8,
            point.dx + side * leafSize * 2.2,
            point.dy + leafSize * 0.3,
          )
          ..quadraticBezierTo(
            point.dx + side * leafSize * 0.7,
            point.dy + leafSize * 1.1,
            point.dx,
            point.dy,
          )
          ..close();
        leafPaint.color = _color(i + 2, alpha: 0.16 + grow * 0.18);
        canvas.drawPath(leafPath, leafPaint);
      }
    }
  }

  // ── NETWORK WEB: Background node map ───────────────────────────────────
  void _paintNetworkWeb(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    final nodePaint = Paint()..style = PaintingStyle.fill;

    final nodes = <Offset>[];
    for (int i = 0; i < 26; i++) {
      final x = size.width * (0.12 + _random01(i + 1) * 0.76);
      final y = size.height * (0.12 + _random01(i + 5) * 0.76);
      final drift = Offset(
        sin(phase * 2 * pi + i) * 5,
        cos(phase * 2 * pi + i * 0.7) * 5,
      );
      nodes.add(Offset(x, y) + drift);
    }

    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final distance = (nodes[i] - nodes[j]).distance;
        if (distance < 105) {
          final alpha = (1 - distance / 105) * 0.16;
          linePaint.color = _color(i, alpha: alpha);
          canvas.drawLine(nodes[i], nodes[j], linePaint);
        }
      }
    }

    for (int i = 0; i < nodes.length; i++) {
      final pulse = 0.7 + 0.3 * sin(phase * 2 * pi + i * 0.4);
      nodePaint.color = _color(i, alpha: 0.22 + pulse * 0.18);
      canvas.drawCircle(nodes[i], 2.2 + pulse * 1.6, nodePaint);
    }
  }

  // ── INFINITY SNAKE: Infinite snake moving on infinity curve ────────────
  void _paintInfinitySnake(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radiusX = size.width * 0.32;
    final radiusY = size.height * 0.13;

    final basePaint = Paint()
      ..color = _color(0, alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    final path = Path();
    for (int i = 0; i <= 120; i++) {
      final t = i / 120 * 2 * pi;
      final offset = _infinityPoint(center, radiusX, radiusY, t);
      if (i == 0) {
        path.moveTo(offset.dx, offset.dy);
      } else {
        path.lineTo(offset.dx, offset.dy);
      }
    }
    canvas.drawPath(path, basePaint);

    final snakePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (int segment = 0; segment < 4; segment++) {
      final segmentPath = Path();
      final startT = (phase + segment * 0.35) % 1 * 2 * pi;
      for (int i = 0; i <= 18; i++) {
        final t = startT + i / 18 * 0.55;
        final offset = _infinityPoint(center, radiusX, radiusY, t);
        if (i == 0) {
          segmentPath.moveTo(offset.dx, offset.dy);
        } else {
          segmentPath.lineTo(offset.dx, offset.dy);
        }
      }
      snakePaint.color = _color(segment, alpha: 0.34 + segment * 0.05);
      canvas.drawPath(segmentPath, snakePaint);
    }

    final head = _infinityPoint(center, radiusX, radiusY, phase * 2 * pi);
    final headPaint = Paint()
      ..color = _color(3, alpha: 0.6)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(head, 4.5, headPaint);
  }

  // ── GRAPH NODES: Node-link graph structure ───────────────────────────
  void _paintGraphNodes(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    final nodePaint = Paint()..style = PaintingStyle.fill;

    final nodes = <Offset>[];
    for (int i = 0; i < 20; i++) {
      final baseX = size.width * (0.14 + _random01(i + 1) * 0.72);
      final baseY = size.height * (0.14 + _random01(i + 5) * 0.72);
      final drift = Offset(
        sin(phase * 2 * pi + i) * 8,
        cos(phase * 2 * pi + i * 0.7) * 8,
      );
      nodes.add(Offset(baseX, baseY) + drift);
    }

    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final distance = (nodes[i] - nodes[j]).distance;
        if (distance < 95) {
          final alpha = (1 - distance / 95) * 0.18;
          linePaint.color = _color(i, alpha: alpha);
          canvas.drawLine(nodes[i], nodes[j], linePaint);
        }
      }
    }

    for (int i = 0; i < nodes.length; i++) {
      final pulse = 0.7 + 0.3 * sin(phase * 2 * pi + i * 0.4);
      nodePaint.color = _color(i, alpha: 0.28 + pulse * 0.2);
      canvas.drawCircle(nodes[i], 2.4 + pulse * 1.6, nodePaint);
    }
  }

  // ── WATER DROPLETS: Droplets that merge and split with surface tension ─
  void _paintWaterDroplets(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final glowPaint = Paint()
      ..color = _color(0, alpha: 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawCircle(center, size.width * 0.48, glowPaint);

    final fillPaint = Paint()..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    final droplets = <_Droplet>[];
    for (int i = 0; i < 14; i++) {
      final baseX = size.width * (0.15 + _random01(i + 1) * 0.7);
      final baseY = size.height * (0.15 + _random01(i + 5) * 0.7);
      final radius = 4 + _random01(i + 9) * 6;
      final phaseShift = _random01(i + 13) * 2 * pi;
      droplets.add(_Droplet(
        base: Offset(baseX, baseY),
        radius: radius,
        phase: phaseShift,
        colorIndex: i,
      ));
    }

    for (final d in droplets) {
      d.position = Offset(
        d.base.dx + sin(phase * 2 * pi + d.phase) * 14,
        d.base.dy + cos(phase * 2 * pi + d.phase) * 14,
      );
    }

    for (int i = 0; i < droplets.length; i++) {
      for (int j = i + 1; j < droplets.length; j++) {
        final centerI = droplets[i].position;
        final centerJ = droplets[j].position;
        final distance = (centerI - centerJ).distance;
        final minDist = droplets[i].radius + droplets[j].radius;
        if (distance < minDist + 6) {
          // Merge bridge between droplets.
          final path = Path()
            ..moveTo(centerI.dx, centerI.dy)
            ..quadraticBezierTo(
              (centerI.dx + centerJ.dx) / 2,
              (centerI.dy + centerJ.dy) / 2 - 3,
              centerJ.dx,
              centerJ.dy,
            );
          strokePaint.color = _color(droplets[i].colorIndex, alpha: 0.18);
          canvas.drawPath(path, strokePaint);
        }
      }
    }

    for (final d in droplets) {
      final alpha = 0.22 + 0.18 * (0.5 + 0.5 * sin(phase * 2 * pi + d.phase));
      fillPaint.color = _color(d.colorIndex, alpha: alpha * 0.35);
      strokePaint.color = _color(d.colorIndex, alpha: alpha);
      canvas.drawCircle(d.position, d.radius, fillPaint);
      canvas.drawCircle(d.position, d.radius, strokePaint);
    }
  }

  // ── LIQUID METABALLS: Blobs that merge using distance field ──────────
  void _paintLiquidMetaballs(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final glowPaint = Paint()
      ..color = _color(0, alpha: 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18;
    canvas.drawCircle(center, size.width * 0.5, glowPaint);

    final fillPaint = Paint()..style = PaintingStyle.fill;

    final blobs = <Offset>[];
    final radii = <double>[];
    for (int i = 0; i < 6; i++) {
      final angle = (i * 2 * pi / 6) + phase * 2 * pi;
      final radius = size.width * 0.16;
      blobs.add(Offset(
        center.dx + cos(angle) * radius,
        center.dy + sin(angle) * radius,
      ));
      radii.add(18 + (i % 3) * 6);
    }

    // Draw filled blobs with mask filter to simulate metaball merging.
    for (int i = 0; i < blobs.length; i++) {
      final paint = Paint()
        ..color = _color(i, alpha: 0.24)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(blobs[i], radii[i], paint);
    }

    // Center highlights on each blob.
    for (int i = 0; i < blobs.length; i++) {
      fillPaint.color = _color(i, alpha: 0.32);
      canvas.drawCircle(blobs[i], radii[i] * 0.55, fillPaint);
    }
  }

  // ── MORPH SHAPES: Shapes that morph between forms ─────────────────────
  void _paintMorphShapes(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final glowPaint = Paint()
      ..color = _color(0, alpha: 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawCircle(center, size.width * 0.46, glowPaint);

    final fillPaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < 4; i++) {
      final angle = (i * 2 * pi / 4) + phase * 2 * pi;
      final radius = size.width * 0.18;
      final centerI = Offset(
        center.dx + cos(angle) * radius,
        center.dy + sin(angle) * radius,
      );
      final morph = (0.5 + 0.5 * sin(phase * 2 * pi + i * 1.5));
      final path = Path();
      final segments = 24;
      for (int s = 0; s <= segments; s++) {
        final t = s / segments * 2 * pi;
        final baseR = 22 + (i % 3) * 5;
        final morphR = baseR + sin(t * 3 + morph * 2 * pi) * 8;
        final x = centerI.dx + cos(t) * morphR;
        final y = centerI.dy + sin(t) * morphR;
        if (s == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      fillPaint.color = _color(i, alpha: 0.22);
      canvas.drawPath(path, fillPaint);
    }
  }

  // ── GEOMETRIC CONSTELLATION: Multiple small geometric shapes moving ────
  void _paintGeometricConstellation(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = _color(0, alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..strokeCap = StrokeCap.round;
    final shapePaint = Paint()..style = PaintingStyle.fill;

    final positions = <Offset>[];
    for (int i = 0; i < 22; i++) {
      final baseX = size.width * (0.12 + _random01(i + 1) * 0.76);
      final baseY = size.height * (0.12 + _random01(i + 5) * 0.76);
      final drift = Offset(
        sin(phase * 2 * pi + i * 0.5) * 10,
        cos(phase * 2 * pi + i * 0.4) * 10,
      );
      positions.add(Offset(baseX, baseY) + drift);
    }

    // Constellation lines.
    for (int i = 0; i < positions.length; i++) {
      for (int j = i + 1; j < positions.length; j++) {
        final distance = (positions[i] - positions[j]).distance;
        if (distance < 70) {
          linePaint.color = _color(i, alpha: (1 - distance / 70) * 0.14);
          canvas.drawLine(positions[i], positions[j], linePaint);
        }
      }
    }

    // Geometric shapes.
    for (int i = 0; i < positions.length; i++) {
      final rotation = phase * 2 * pi + i;
      shapePaint.color = _color(i, alpha: 0.28);
      final shapeSize = 4 + (i % 3) * 1.2;
      switch (i % 4) {
        case 0:
          _drawDiamond(canvas, positions[i], shapeSize, shapePaint,
              rotation: rotation);
          break;
        case 1:
          _drawTriangle(canvas, positions[i], shapeSize, shapePaint,
              rotation: rotation);
          break;
        case 2:
          _drawSmallOrbit(canvas, positions[i], shapeSize, shapePaint,
              rotation: rotation);
          break;
        case 3:
          canvas.save();
          canvas.translate(positions[i].dx, positions[i].dy);
          canvas.rotate(rotation);
          canvas.drawRect(
            Rect.fromCenter(
              center: Offset.zero,
              width: shapeSize * 1.6,
              height: shapeSize * 1.6,
            ),
            shapePaint,
          );
          canvas.restore();
          break;
      }
    }
  }

  Offset _infinityPoint(
      Offset center, double radiusX, double radiusY, double t) {
    return Offset(
      center.dx + sin(t) * radiusX,
      center.dy + sin(2 * t) * radiusY,
    );
  }

  @override
  bool shouldRepaint(covariant CosmeticEffectPainter oldDelegate) {
    return oldDelegate.phase != phase ||
        oldDelegate.effectType != effectType ||
        oldDelegate.colors != colors;
  }
}
