import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import '../themes/app_theme.dart';
import '../utils/responsive.dart';

class AppLogo extends StatefulWidget {
  final double? size;

  const AppLogo({super.key, this.size});

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
    )..repeat();

    _angleAnimation = Tween<double>(
      begin: -pi / 2,
      end: -pi / 2 + 2 * pi,
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
    Responsive.init(context);

    final logoSize = widget.size ?? Responsive.screenWidth.clamp(320.0, 400.0);
    final arcRadius = logoSize / 2.5;

    return AnimatedBuilder(
      animation: _angleAnimation,
      builder: (context, child) {
        return ArcText(
          radius: arcRadius,
          text: 'POMODORO WEIRD',
          textStyle: AppTextStyles.logo,
          startAngle: _angleAnimation.value,
          placement: Placement.outside,
        );
      },
    );
  }
}
