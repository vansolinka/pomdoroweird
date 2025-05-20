import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/buttons.dart';
import '../screens/short_break.dart';
import '../utils/app_responsive.dart'; // ✅ responsive helper

class PomodoroEndDialog extends StatelessWidget {
  final String message;
  final VoidCallback onReplay; // ✅ new callback

  const PomodoroEndDialog({
    super.key,
    required this.message,
    required this.onReplay, // ✅ receive from parent
  });

  @override
  Widget build(BuildContext context) {
    final r = AppResponsive(context);

    return AlertDialog(
      backgroundColor: AppColors.softTomato,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      title: Center(
        child: Text(
          'Time’s up!',
          style: AppTextStyles.buttons.copyWith(
            color: AppColors.plumCalm,
            fontSize: r.fontSize(18),
          ),
          textAlign: TextAlign.center,
        ),
      ),
      content: SizedBox(
        width: r.widthPercent(r.isSmallScreen ? 0.75 : 0.8),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMessages.copyWith(
            color: AppColors.plumCalm,
            fontSize: r.fontSize(16),
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.only(bottom: 16),
      actions: [
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BreakButton(
                label: 'Start Break',
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShortBreakScreen(),
                    ),
                  );
                },
              ),
              SizedBox(width: r.responsiveSize(12, 16)),
              BreakButton(
                label: 'Replay',
                onPressed: () {
                  Navigator.of(context).pop();
                  onReplay(); // ✅ triggers the timer reset
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
