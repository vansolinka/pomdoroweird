import 'package:flutter/material.dart';

class Responsive {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockWidth;
  static late double blockHeight;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;
  }

  static double w(double percentage) => blockWidth * percentage;
  static double h(double percentage) => blockHeight * percentage;
  static double sp(double percentage) => blockHeight * percentage; // for fontSize
  static double wp(double percent) => screenWidth * (percent / 100);
  static double hp(double percent) => screenHeight * (percent / 100);
}
