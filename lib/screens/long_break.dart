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
                horizontal: r.responsiveSize(20, 24),
                vertical: r.responsiveSize(28, 32),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: r.responsiveSize(40, 60)),

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

                  SizedBox(height: r.responsiveSize(12, 16)),

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

                  SizedBox(height: r.responsiveSize(40, 60)),

                  Container(
                    margin: EdgeInsets.only(top: r.responsiveSize(12, 16)),
                    padding: EdgeInsets.symmetric(
                      horizontal: r.responsiveSize(16, 20),
                      vertical: r.responsiveSize(10, 12),
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

                  SizedBox(height: r.responsiveSize(30, 40)),

                  TomatoDisplay(
                    size: r.widthPercent(r.isSmallScreen ? 0.87 : 0.9),
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
