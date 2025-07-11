import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../themes/app_assets.dart';
import '../themes/app_theme.dart';
import '../utils/responsive.dart';
import 'timer_widget.dart';
import 'dart:math';

class TomatoDisplay extends StatefulWidget {
  final double? size;
  final Duration duration;
  final int startPulse;
  final int breakTomato;
  final VoidCallback? onStart;
  final VoidCallback? onComplete;
  final VoidCallback? onReset;

  const TomatoDisplay({
    super.key,
    this.size,
    required this.duration,
    required this.startPulse,
    required this.breakTomato,
    this.onStart,
    this.onComplete,
    this.onReset,
  });

  @override
  TomatoDisplayState createState() => TomatoDisplayState();
}

class TomatoDisplayState extends State<TomatoDisplay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  final GlobalKey<DigitalTimerState> timerKey = GlobalKey<DigitalTimerState>();
  bool _isFastBreathing = false;
  bool _isPulsing = false;
  bool _isCracked = false;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    player.setSourceAsset(AppAssets.crackSound);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void resetFromOutside() {
    timerKey.currentState?.resetTimer();
    stopTomatoPulse();
    setState(() {
      _isCracked = false;
    });
  }

  void startTomatoPulse() {
    _isFastBreathing = false;
    _isPulsing = true;
    _controller.duration = const Duration(seconds: 2);
    _controller.repeat(reverse: true);
  }

  void stopTomatoPulse() {
    _controller.stop();
    _isFastBreathing = false;
    _isPulsing = false;
    _controller.duration = const Duration(seconds: 2);
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
    Responsive.init(context);


    final double size = widget.size ??
    (Responsive.screenWidth >= 600 // tablet check
        ? min(Responsive.w(90), 750) // allow larger on tablets
        : min(Responsive.w(90), 600));


    final double timerOffset = size * 0.43;

    return Stack(
      alignment: Alignment.center,
      children: [
        _animatedOrStatic(
          child: Image.asset(
            _isCracked ? AppAssets.tomatoCrackedImage : AppAssets.tomatoImage,
            width: size,
            height: size,
          ),
        ),

        Positioned(
          top: timerOffset,
          child: DigitalTimer(
            key: timerKey,
            initialTime: widget.duration,
            textStyle: AppTextStyles.timer.copyWith(
              fontSize: min(Responsive.sp(8), 50)
              ),
            onTick: (remaining) {
              if (remaining.inSeconds <= widget.startPulse && !_isFastBreathing) {
                setFastPulse();
              }
              if (remaining.inSeconds == widget.breakTomato && !_isCracked) {
                setState(() => _isCracked = true);
                stopTomatoPulse();
                player.resume();
                widget.onComplete?.call();
              }
            },
          ),
        ),

        Positioned(
          bottom: size * 0.17,
          left: size * 0.22,
          child: _animatedOrStatic(
            child: _buildIconButton(
              assetPath: AppAssets.replayButton,
              size: size * 0.18,
              onTap: () {
                timerKey.currentState?.resetTimer();
                stopTomatoPulse();
                widget.onStart?.call();
                widget.onReset?.call();
                setState(() => _isCracked = false);
              },
            ),
          ),
        ),

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
                setState(() => _isCracked = false);
              },
            ),
          ),
        ),

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
      ],
    );
  }
}
