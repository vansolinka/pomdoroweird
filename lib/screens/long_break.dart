import 'dart:math';
import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/tomato_display.dart';
import '../widgets/buttons.dart';
import '../widgets/break_messages.dart';
import 'short_break.dart';
import 'home_screen.dart';
import '../utils/responsive.dart';

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
    Responsive.init(context);

    return Scaffold(
      backgroundColor: AppColors.stormyMist,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.w(6),   // ~24 on 400px screen
                vertical: Responsive.h(4.5),   // ~32 on 700px screen
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Responsive.h(6)),

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

                  SizedBox(height: Responsive.h(2)),

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

                  SizedBox(height: Responsive.h(6)),

                  Container(
                    margin: EdgeInsets.only(top: Responsive.h(2)),
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.w(5),
                      vertical: Responsive.h(1.5),
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
                        fontSize: Responsive.sp(2.2),
                      ),
                    ),
                  ),

                  SizedBox(height: Responsive.h(2)),

                  TomatoDisplay(
                    size: min(Responsive.w(90), 600),
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
