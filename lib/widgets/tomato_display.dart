import 'package:flutter/material.dart';
import '../themes/app_assets.dart';
import '../themes/app_theme.dart';
import 'timer_widget.dart';

class TomatoDisplay extends StatelessWidget {
  final double size;

  const TomatoDisplay({super.key, required this.size});
  
  Widget _buildIconButton({
  required String assetPath,
  required double size,
  required VoidCallback onTap,
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      splashColor: AppColors.mintFocus,
      highlightColor: AppColors.plumCalm,
      borderRadius: BorderRadius.circular(100),
      child: Image.asset(
        assetPath,
        width: size,
        height: size,
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Tomato Image
        Image.asset(
          AppAssets.tomatoImage,
          width: size,
          height: size,
        ),
        //Digital timer
        Positioned(
          top: 165,
          child: DigitalTimer(
          initialTime: const Duration(minutes: 25),
          textStyle: AppTextStyles.timer.copyWith(
            fontSize: 52,
          ),
        ),
        ),

        // Play Button (center)
        Positioned(
          bottom: 60,
          left: 150,
          child: _buildIconButton(
            assetPath: AppAssets.playButton,
            size: 48,
            onTap: () => print('Play pressed'),
          ),
        ),
        // Pause Button (bottom left)
        Positioned(
          bottom: 65,
          left: 210,
            child: _buildIconButton(
              assetPath: AppAssets.pauseButton, 
              size: 48, 
              onTap: () => print('Pause pressed'),
              )
        ),

        // Replay Button (bottom right)
        Positioned(
          bottom: 55,
          left: 90,
            child: _buildIconButton(assetPath: AppAssets.replayButton, 
            size: 70, 
             onTap: () => print('Replay pressed'),
            )
        ),
      ],
    );
  }
}
