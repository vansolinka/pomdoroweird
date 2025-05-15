import 'package:flutter/material.dart';

class AppColors {
  static const plumCalm = Color(0xFF5B3758);
  static const mintFocus = Color(0xFF83B692);
  static const softTomato = Color(0xFFF8DEDA);
  static const zestyRose = Color(0xFFF9627D);
  static const punchBerry = Color(0xFFC65B7C);
  static const bgDark = Color(0xFF0D0D0D);
  static const stormyMist = Color(0xFF96AAB3);
}

class AppTextStyles {
  static const logo = TextStyle(
    fontSize: 32,
    color: AppColors.softTomato,
    fontFamily: 'GloriaHallelujah',
    letterSpacing: 4.8, //15%
  );
  static const body = TextStyle(
    fontSize: 16,
    color: AppColors.softTomato,
    fontFamily: 'Poppins',
  );
    static const bodyMessages = TextStyle(
    fontSize: 16,
    color: AppColors.plumCalm,
    fontFamily: 'Poppins',
    letterSpacing: -1
  );
    static const buttons = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.softTomato,
    fontFamily: 'Nunito',
    letterSpacing: 3,
  );
  static const timer = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w900,
    color: AppColors.punchBerry,
    fontFamily: 'Orbitron',
    letterSpacing: 3
  );
}


