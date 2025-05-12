import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Text(
        'POMODORO WEIRD',
        style: AppTextStyles.logo,
        textAlign: TextAlign.center,
      ),
    );
  }
}
