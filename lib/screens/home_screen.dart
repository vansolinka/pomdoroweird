import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../themes/app_assets.dart';
import '../widgets/buttons.dart';
import '../widgets/logo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = screenWidth * 0.9;

    return Scaffold(
      backgroundColor: AppColors.plumCalm,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Row for the two buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BreakButton(
                    label: 'Short Break',
                    onPressed: () => print('Short Break'),
                  ),
                  BreakButton(
                    label: 'Long Break',
                    onPressed: () => print('Long Break'),
                  ),
                ],
              ),
            ),
            const AppLogo(), // 👈 Here’s your reusable logo
            const SizedBox(height: 30),
            Image.asset(
              AppAssets.tomatoImage,
              width: imageSize,
              height: imageSize,
            ),
          ],
        ),
      ),
    );
  }
}
