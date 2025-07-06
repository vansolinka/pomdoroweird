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
import '../utils/responsive.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<TomatoDisplayState> tomatoKey = GlobalKey<TomatoDisplayState>();

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

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
                  SizedBox(height: Responsive.h(6)),

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
                      SizedBox(width: Responsive.w(4)),
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

                  SizedBox(height: Responsive.h(18)),

                  // 🍅 Tomato Clock
                  TomatoDisplay(
                    key: tomatoKey,
                    duration: const Duration(minutes: 25),
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
                            tomatoKey.currentState?.resetFromOutside();
                          },
                        ),
                      );
                    },
                    onReset: () {},
                  ),
                ],
              ),
            ),

            // 🌀 Orbiting Logo
            Positioned(
              top: Responsive.h(60), // You can fine-tune this
              child: AppLogo(
                size: Responsive.screenWidth.clamp(340.0, 540.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
