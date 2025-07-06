import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/buttons.dart';
import '../screens/short_break.dart';
import '../utils/responsive.dart';

class PomodoroEndDialog extends StatelessWidget {
  final String message;
  final VoidCallback onReplay;

  const PomodoroEndDialog({
    super.key,
    required this.message,
    required this.onReplay,
  });

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

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
            fontSize: Responsive.sp(2.4),
          ),
          textAlign: TextAlign.center,
        ),
      ),
      content: SizedBox(
        width: Responsive.w(80),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMessages.copyWith(
            color: AppColors.plumCalm,
            fontSize: Responsive.sp(2),
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
              SizedBox(width: Responsive.w(4)),
              BreakButton(
                label: 'Replay',
                onPressed: () {
                  Navigator.of(context).pop();
                  onReplay();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
