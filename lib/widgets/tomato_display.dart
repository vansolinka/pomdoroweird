import 'package:flutter/material.dart';
import '../themes/app_assets.dart';
import '../themes/app_theme.dart';
import 'timer_widget.dart';

class TomatoDisplay extends StatefulWidget {
  final double size;

  const TomatoDisplay({super.key, required this.size});

  @override
  State<TomatoDisplay> createState() => _TomatoDisplayState();
}

class _TomatoDisplayState extends State<TomatoDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  final GlobalKey<DigitalTimerState> timerKey = GlobalKey<DigitalTimerState>();
  bool _isFastBreathing = false;
  bool _isPulsing = false;
  bool _isCracked = false;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void startTomatoPulse() {
    _isFastBreathing = false;
    _isPulsing = true;
    _controller.reset();
    _controller.duration = const Duration(seconds: 2);
    _controller.repeat(reverse: true);
    setState(() {});
  }

  void stopTomatoPulse() {
    _controller.stop();
    _isFastBreathing = false;
    _isPulsing = false;
    _controller.duration = const Duration(seconds: 2);
    setState(() {}); // ⚠️ force UI update when hiding pulse
  }

  void setFastPulse() {
    if (_isFastBreathing) return;
    _isFastBreathing = true;
    _controller.stop();
    _controller.reset();
    _controller.duration = const Duration(milliseconds: 300);
    _controller.repeat(reverse: true);
  }

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

  Widget _animatedOrStatic({required Widget child}) {
    return _isPulsing
        ? ScaleTransition(scale: _scaleAnimation, child: child)
        : child;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 🌀 Pulsing Tomato
        _animatedOrStatic(
          child: Image.asset(
            _isCracked ? AppAssets.tomatoCrackedImage : AppAssets.tomatoImage,
            width: widget.size,
            height: widget.size,
          )
        ),

        // ⏱️ Digital Timer
        Positioned(
          top: 165,
          child: DigitalTimer(
            key: timerKey,
            initialTime: const Duration(minutes: 25),
            textStyle: AppTextStyles.timer.copyWith(fontSize: 52),
            onTick: (remaining) {
              if (remaining.inSeconds <= 1440 && !_isFastBreathing) {
                setFastPulse(); // starts at 24 minute for testing, later change for 300 seconds already working
              }

              if (remaining.inSeconds == 1430 && !_isCracked) {
                setState(() {
                  _isCracked = true;
                });
                stopTomatoPulse(); // happens at 23:50 for testing pourposes, change to 0 in production optional: stop the animation
              }
            },

          ),
        ),

        // ▶️ Play
        Positioned(
          bottom: 60,
          left: 150,
          child: _animatedOrStatic(
            child: _buildIconButton(
              assetPath: AppAssets.playButton,
              size: 48,
              onTap: () {
                timerKey.currentState?.startTimer();
                startTomatoPulse();
                setState(() {
                  _isCracked = false;
                });
              },
            ),
          ),
        ),

        // ⏸ Pause
        Positioned(
          bottom: 65,
          left: 210,
          child: _animatedOrStatic(
            child: _buildIconButton(
              assetPath: AppAssets.pauseButton,
              size: 48,
              onTap: () {
                timerKey.currentState?.pauseTimer();
                stopTomatoPulse();
              },
            ),
          ),
        ),

        // 🔁 Reset
        Positioned(
          bottom: 55,
          left: 90,
          child: _animatedOrStatic(
            child: _buildIconButton(
              assetPath: AppAssets.replayButton,
              size: 70,
              onTap: () {
                timerKey.currentState?.resetTimer();
                stopTomatoPulse();
                setState(() {
                  _isCracked = false;
                });
             },
            ),
          ),
        ),
      ],
    );
  }
}
