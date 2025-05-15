import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/buttons.dart';
import '../screens/short_break.dart'; // adjust path if needed

class PomodoroEndDialog extends StatelessWidget {
  final String message;

  const PomodoroEndDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
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
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      content: SizedBox(
        width: 300,
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMessages.copyWith(
            color: AppColors.plumCalm,
            fontSize: 16,
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
              const SizedBox(width: 16),
              BreakButton(
                label: 'Replay',
                onPressed: () {
                  Navigator.of(context).pop();
                  // Optional: trigger timer reset
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
