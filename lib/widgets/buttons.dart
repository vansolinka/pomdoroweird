import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../utils/responsive.dart';


class BreakButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const BreakButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Material(
      color: AppColors.punchBerry,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 4,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.w(6),   // 6% of screen width
            vertical: Responsive.h(1.8),   // 1.8% of screen height
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: AppTextStyles.buttons.copyWith(fontSize: Responsive.sp(2.2)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
