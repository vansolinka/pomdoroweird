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

  // Shrink the arc radius based on screen size
 final tomatoSize = MediaQuery.of(context).size.width.clamp(320.0, 400.0);
final arcRadius = tomatoSize / 2.5; // or 2.2 to make it tighter


  return AnimatedBuilder(
    animation: _angleAnimation,
    builder: (context, child) {
      return ArcText(
        radius: arcRadius,
        text: 'POMODORO WEIRD',
        textStyle: AppTextStyles.logo, // ✅ fixed size
        startAngle: _angleAnimation.value,
        placement: Placement.outside,
      );
    },
  );
}


}
