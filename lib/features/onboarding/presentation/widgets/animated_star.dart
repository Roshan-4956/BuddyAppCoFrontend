import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../utils/constants/assets.dart';

class AnimatedStar extends StatelessWidget {
  final double size;
  final Color color;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double rotation;
  final Duration delay;

  const AnimatedStar({
    super.key,
    required this.size,
    required this.color,
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.rotation = 0,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Transform.rotate(
        angle: rotation * 3.14159 / 180,
        child:
            SvgPicture.asset(
                  Assets.fillerStar,
                  width: size,
                  height: size,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                )
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                )
                .scale(
                  duration: 1500.ms,
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1.2, 1.2),
                  curve: Curves.easeInOut,
                  delay: delay,
                )
                .fade(duration: 1500.ms, begin: 0.7, end: 1.0, delay: delay),
      ),
    );
  }
}
