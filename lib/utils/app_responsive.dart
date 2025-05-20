// lib/utils/app_responsive.dart

import 'package:flutter/material.dart';

class AppResponsive {
  final BuildContext context;
  final double screenWidth;
  final double screenHeight;
  final bool isSmallScreen;

  AppResponsive(this.context)
      : screenWidth = MediaQuery.of(context).size.width,
        screenHeight = MediaQuery.of(context).size.height,
        isSmallScreen = MediaQuery.of(context).size.height < 700 ||
                        MediaQuery.of(context).size.width < 390;

  double responsiveSize(double small, double large) =>
      isSmallScreen ? small : large;

  double widthPercent(double percent) => screenWidth * percent;

  double heightPercent(double percent) => screenHeight * percent;

  double fontSize(double base) => isSmallScreen ? base * 0.88 : base;
}
