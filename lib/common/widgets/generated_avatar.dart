import 'dart:math';

import 'package:flutter/material.dart';

class GeneratedAvatar extends StatelessWidget {
  const GeneratedAvatar({
    super.key,
    required this.seed,
    required this.size,
    this.borderRadius,
  });

  final String seed;
  final double size;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(size / 2),
      child: CustomPaint(
        size: Size.square(size),
        painter: _GeneratedAvatarPainter(seed),
      ),
    );
  }
}

class _GeneratedAvatarPainter extends CustomPainter {
  _GeneratedAvatarPainter(this.seed);

  final String seed;

  @override
  void paint(Canvas canvas, Size size) {
    final rand = Random(seed.hashCode);
    final baseHue = rand.nextDouble() * 360;
    final secondaryHue = (baseHue + 40 + rand.nextDouble() * 80) % 360;

    final base = HSVColor.fromAHSV(1, baseHue, 0.35, 0.95).toColor();
    final accent = HSVColor.fromAHSV(1, secondaryHue, 0.6, 0.9).toColor();
    final accent2 = HSVColor.fromAHSV(1, (secondaryHue + 120) % 360, 0.45, 0.85)
        .toColor();

    final rect = Offset.zero & size;
    final background = Paint()
      ..shader = LinearGradient(
        colors: [base, accent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);
    canvas.drawRect(rect, background);

    final circlePaint = Paint()..color = accent2.withValues(alpha: 0.65);
    final circlePaint2 = Paint()..color = accent.withValues(alpha: 0.4);

    final radius1 = size.width * (0.25 + rand.nextDouble() * 0.2);
    final radius2 = size.width * (0.15 + rand.nextDouble() * 0.2);
    final offset1 = Offset(
      size.width * (0.2 + rand.nextDouble() * 0.6),
      size.height * (0.2 + rand.nextDouble() * 0.6),
    );
    final offset2 = Offset(
      size.width * (0.1 + rand.nextDouble() * 0.7),
      size.height * (0.1 + rand.nextDouble() * 0.7),
    );

    canvas.drawCircle(offset1, radius1, circlePaint);
    canvas.drawCircle(offset2, radius2, circlePaint2);
  }

  @override
  bool shouldRepaint(covariant _GeneratedAvatarPainter oldDelegate) {
    return oldDelegate.seed != seed;
  }
}
