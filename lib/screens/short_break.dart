import 'dart:math';
import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/tomato_display.dart';
import '../widgets/buttons.dart';
import '../widgets/break_messages.dart';
import 'long_break.dart';
import 'home_screen.dart';
import '../utils/app_responsive.dart'; // ✅ Responsive helper

class ShortBreakScreen extends StatefulWidget {
  const ShortBreakScreen({super.key});

  @override
  State<ShortBreakScreen> createState() => _ShortBreakScreenState();
}

class _ShortBreakScreenState extends State<ShortBreakScreen> {
  String _message = shortBreakMessages[0];

  @override
  void initState() {
    super.initState();
    _refreshMessage(); // ✅ refresh message on page load
  }

  void _refreshMessage() {
    final random = Random();
    setState(() {
      _message = shortBreakMessages[random.nextInt(shortBreakMessages.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    final r = AppResponsive(context); // ✅ Initialize responsive helper

    return Scaffold(
      backgroundColor: AppColors.mintFocus,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: r.responsiveSize(40, 60)),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                        margin: const EdgeInsets.only(top: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                    ],
                  ),

                  SizedBox(height: r.responsiveSize(30, 40)),

                  TomatoDisplay(
                    size: r.widthPercent(r.isSmallScreen ? 0.87 : 0.9),
                    duration: const Duration(minutes: 5),
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
