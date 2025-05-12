import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class BreakButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const BreakButton({
    super.key,
    required this.onPressed,
    required this.label, // now required to force label input
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.punchBerry,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 8,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
          child: Text(
            label,
            style: AppTextStyles.buttons,
          ),
        ),
      ),
    );
  }
}
