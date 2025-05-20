import 'dart:math';
import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/tomato_display.dart';
import '../widgets/buttons.dart';
import '../widgets/logo.dart';
import 'short_break.dart';
import 'long_break.dart';
import '../widgets/break_messages.dart';
import '../widgets/pomodoro_dialog.dart';
import '../utils/app_responsive.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<TomatoDisplayState> tomatoKey = GlobalKey<TomatoDisplayState>(); // ✅ Key to control timer

  @override
  Widget build(BuildContext context) {
    final r = AppResponsive(context);

    return Scaffold(
      backgroundColor: AppColors.plumCalm,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Main content
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: r.responsiveSize(40, 60)),

                  // Break buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: BreakButton(
                          label: 'Short Break',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ShortBreakScreen()),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: r.responsiveSize(12, 16)),
                      Expanded(
                        child: BreakButton(
                          label: 'Long Break',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LongBreakScreen()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: r.responsiveSize(100, 160)),

                  // Tomato Clock
                  TomatoDisplay(
                    key: tomatoKey, // ✅ apply key
                    size: r.widthPercent(r.isSmallScreen ? 0.87 : 0.9),
                    duration: const Duration(minutes: 1),
                    startPulse: 10,
                    breakTomato: 0,
                    onStart: () {},
                    onComplete: () {
                      final random = Random();
                      final message = endPomodoroMessages[random.nextInt(endPomodoroMessages.length)];

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => PomodoroEndDialog(
                          message: message,
                          onReplay: () {
                            tomatoKey.currentState?.resetFromOutside(); // ✅ reset timer from dialog
                          },
                        ),
                      );
                    },
                    onReset: () {
                      print('Timer was reset via dialog.');
                    },
                  ),
                ],
              ),
            ),

            // Orbiting logo
            Positioned(
              top: r.responsiveSize(400, 500),
              child: const AppLogo(),
            ),
          ],
        ),
      ),
    );
  }
}
