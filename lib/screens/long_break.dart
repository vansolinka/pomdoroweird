import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/tomato_display.dart';
import '../widgets/buttons.dart';
import '../widgets/break_messages.dart';
import 'short_break.dart';
import 'home_screen.dart';
import 'dart:math';

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
    _refreshMessage(); // ✅ refresh message on page load
  }

  void _refreshMessage() {
    final random = Random();
    setState(() {
      _message = longBreakMessages[random.nextInt(longBreakMessages.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.stormyMist,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Main scrollable content
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Top: Pomodoro Button
                      Center(
                        child: BreakButton(
                          label: 'Pomodoro weird',
                          onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const HomeScreen()),
                              );
                        },
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Bottom Row: Short & Long Break
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
                            const SizedBox(width: 16), // spacing between buttons
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

                      const SizedBox(height: 60),
                      // 💬 Message Bubble
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
                          style: AppTextStyles.bodyMessages,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  TomatoDisplay(
                    size: screenWidth * 0.9,
                    duration: const Duration(minutes: 15),
                    startPulse: 120,
                    breakTomato: 0,
                    onStart: _refreshMessage, // 👈 this gets called when Play is pressed
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
