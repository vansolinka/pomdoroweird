import 'package:flutter/material.dart';
import '../themes/app_assets.dart';
import '../themes/app_theme.dart';
import 'timer_widget.dart';

class TomatoDisplay extends StatefulWidget {
  final double? size;
  final Duration duration;
  final int startPulse;
  final int breakTomato;
  final VoidCallback? onStart;
  final VoidCallback? onComplete;

  const TomatoDisplay({
    super.key,
    this.size,
    required this.duration,
    required this.startPulse,
    required this.breakTomato,
    required this.onStart,
    this.onComplete,
  });

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
    setState(() {});
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700 || screenWidth < 390;

    final double size = widget.size ??
        (isSmallScreen ? screenWidth * 0.68 : screenWidth * 0.9);

    final double timerOffset = size * (isSmallScreen ? 0.45 : 0.43);

    return Stack(
      alignment: Alignment.center,
      children: [
        // 🌀 Pulsing Tomato
        _animatedOrStatic(
          child: Image.asset(
            _isCracked ? AppAssets.tomatoCrackedImage : AppAssets.tomatoImage,
            width: size,
            height: size,
          ),
        ),

        // ⏱️ Digital Timer
        Positioned(
          top: timerOffset,
          child: DigitalTimer(
            key: timerKey,
            initialTime: widget.duration,
            textStyle: AppTextStyles.timer.copyWith(
              fontSize: isSmallScreen ? 44 : 52,
            ),
            onTick: (remaining) {
              if (remaining.inSeconds <= widget.startPulse &&
                  !_isFastBreathing) {
                setFastPulse();
              }
              if (remaining.inSeconds == widget.breakTomato &&
                  !_isCracked) {
                setState(() {
                  _isCracked = true;
                });
                stopTomatoPulse();
                widget.onComplete?.call();
              }
            },
          ),
        ),

        // ▶️ Play
        Positioned(
          bottom: size * 0.17,
          left: size * 0.41,
          child: _animatedOrStatic(
            child: _buildIconButton(
              assetPath: AppAssets.playButton,
              size: size * 0.13,
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
          bottom: size * 0.19,
          left: size * 0.58,
          child: _animatedOrStatic(
            child: _buildIconButton(
              assetPath: AppAssets.pauseButton,
              size: size * 0.13,
              onTap: () {
                timerKey.currentState?.pauseTimer();
                stopTomatoPulse();
              },
            ),
          ),
        ),

        // 🔁 Reset
        Positioned(
          bottom: size * 0.17,
          left: size * 0.23,
          child: _animatedOrStatic(
            child: _buildIconButton(
              assetPath: AppAssets.replayButton,
              size: size * 0.19,
              onTap: () {
                timerKey.currentState?.resetTimer();
                stopTomatoPulse();
                widget.onStart?.call();
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
