import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/tomato_display.dart';
import '../widgets/buttons.dart';
import '../widgets/logo.dart';
import 'short_break.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.plumCalm,
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
                  // Row for the two buttons
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BreakButton(
                        label: 'Short Break',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ShortBreakScreen()),
                          );
                        },
                      ),
                      BreakButton(
                        label: 'Long Break',
                        onPressed: () => print('Long Break'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 130), // space to make room for the logo overlap
                  TomatoDisplay(
                    size: screenWidth * 0.9,
                    duration: const Duration(minutes: 25),
                    startPulse: 1440,
                    breakTomato: 1430,
                    onStart: () {
                      
                    },
                    ),
                ],
              ),
            ),

            // Positioned logo above the tomato
            const Positioned(
              top: 500, // Adjust this value as needed
              child: AppLogo(),
            ),
          ],
        ),
      ),
    );
  }
}
