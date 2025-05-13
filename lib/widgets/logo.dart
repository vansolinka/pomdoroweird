import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import '../themes/app_theme.dart';

class AppLogo extends StatefulWidget {
  const AppLogo({super.key});

  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _angleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(); // makes it loop forever

    _angleAnimation = Tween<double>(
      begin: -pi / 2, // top center
      end: -pi / 2 + 2 * pi, // full rotation
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _angleAnimation,
      builder: (context, child) {
        return ArcText(
          radius: 160,
          text: 'POMODORO WEIRD',
          textStyle: AppTextStyles.logo,
          startAngle: _angleAnimation.value,
          placement: Placement.outside,
        );
      },
    );
  }
}
