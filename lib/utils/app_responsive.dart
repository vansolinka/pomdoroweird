// lib/utils/app_responsive.dart

import 'package:flutter/material.dart';

class AppResponsive {
  final BuildContext context;
  final double screenWidth;
  final double screenHeight;
  final bool isSmallScreen;
  final bool isTablet;

  AppResponsive(this.context)
      : screenWidth = MediaQuery.of(context).size.width,
        screenHeight = MediaQuery.of(context).size.height,
        isSmallScreen = MediaQuery.of(context).size.height < 700 ||
                        MediaQuery.of(context).size.width < 390,
        isTablet = MediaQuery.of(context).size.shortestSide >= 600;

  double responsiveSize(double small, double large) =>
      isSmallScreen ? small : large;

  // 🆕 Add this: handles small / normal / tablet
  double tieredSize({required double small, required double medium, required double tablet}) {
    if (isSmallScreen) return small;
    if (isTablet) return tablet;
    return medium;
  }

  double widthPercent(double percent) => screenWidth * percent;

  double heightPercent(double percent) => screenHeight * percent;

  double fontSize(double base) {
    if (isSmallScreen) return base * 0.88;
    if (isTablet) return base * 1.2;
    return base;
  }
}
