import 'dart:math';
import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/tomato_display.dart';
import '../widgets/buttons.dart';
import '../widgets/break_messages.dart';
import 'short_break.dart';
import 'home_screen.dart';
import '../utils/app_responsive.dart';

class LongBreakScreen extends StatefulWidget {
  const LongBreakScreen({super.key});

  @override
  State<LongBreakScreen> createState() => _LongBreakScreenState();
}

class _LongBreakScreenState extends State<LongBreakScreen> {
  String _message = longBreakMessages[0];

  @override
  void initState() {
    super.initState();
    _refreshMessage();
  }

  void _refreshMessage() {
    final random = Random();
    setState(() {
      _message = longBreakMessages[random.nextInt(longBreakMessages.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    final r = AppResponsive(context);

    return Scaffold(
      backgroundColor: AppColors.stormyMist,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: r.tieredSize(small: 20, medium: 24, tablet: 40),
                vertical: r.tieredSize(small: 28, medium: 32, tablet: 48),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: r.tieredSize(small: 40, medium: 60, tablet: 80)),

                  Center(
                    child: BreakButton(
                      label: 'Pomodoro weird',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: r.tieredSize(small: 12, medium: 16, tablet: 24)),

                  Row(
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
                      SizedBox(width: r.tieredSize(small: 12, medium: 16, tablet: 24)),
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

                  SizedBox(height: r.tieredSize(small: 40, medium: 60, tablet: 80)),

                  Container(
                    margin: EdgeInsets.only(top: r.tieredSize(small: 12, medium: 16, tablet: 24)),
                    padding: EdgeInsets.symmetric(
                      horizontal: r.tieredSize(small: 16, medium: 20, tablet: 28),
                      vertical: r.tieredSize(small: 10, medium: 12, tablet: 18),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.softTomato,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.plumCalm,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      _message,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMessages.copyWith(
                        fontSize: r.fontSize(16),
                      ),
                    ),
                  ),

                  SizedBox(height: r.tieredSize(small: 30, medium: 40, tablet: 45)),

                  TomatoDisplay(
                    size: r.tieredSize(small: r.widthPercent(0.87), medium: r.widthPercent(0.9), tablet: r.widthPercent(0.91)),
                    duration: const Duration(minutes: 15),
                    startPulse: 120,
                    breakTomato: 0,
                    onStart: _refreshMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
