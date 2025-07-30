import 'dart:async';
import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class DigitalTimer extends StatefulWidget {
  final Duration initialTime;
  final TextStyle? textStyle;
  final void Function(Duration)? onTick;
  final VoidCallback? onComplete;

  const DigitalTimer({
    super.key,
    required this.initialTime,
    this.textStyle,
    this.onTick,
    this.onComplete,
  });

  @override
  DigitalTimerState createState() => DigitalTimerState();
}

class DigitalTimerState extends State<DigitalTimer> {
  Timer? _timer;
  DateTime? _endTime;
  Duration _lastDuration = Duration.zero;

  bool get _isRunning => _endTime != null;

  @override
  void initState() {
    super.initState();
    _lastDuration = widget.initialTime;
  }

  void startTimer() {
    _endTime = DateTime.now().add(_lastDuration);

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final remaining = _getRemaining();
      if (remaining <= Duration.zero) {
        _timer?.cancel();
        _endTime = null;
        widget.onTick?.call(Duration.zero); // ensure last tick is 00:00
        widget.onComplete?.call();
      } else {
        widget.onTick?.call(remaining);
      }
      setState(() {});
    });

    setState(() {});
  }

  void pauseTimer() {
    if (_isRunning) {
      _lastDuration = _getRemaining();
      _endTime = null;
      _timer?.cancel();
      setState(() {});
    }
  }

  void resetTimer() {
    _timer?.cancel();
    _endTime = null;
    _lastDuration = widget.initialTime;
    setState(() {});
  }

  Duration _getRemaining() {
    if (_endTime == null) return _lastDuration;
    final remaining = _endTime!.difference(DateTime.now());
    return remaining.isNegative ? Duration.zero : remaining;
  }

  String _format(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remaining = _getRemaining();
    return StrokedText(
      text: _format(remaining),
      style: widget.textStyle ?? AppTextStyles.timer,
      strokeColor: Colors.black,
      strokeWidth: 2,
    );
  }
}

class StrokedText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color strokeColor;
  final double strokeWidth;

  const StrokedText({
    super.key,
    required this.text,
    required this.style,
    this.strokeColor = Colors.black,
    this.strokeWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: style.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        Text(
          text,
          style: style,
        ),
      ],
    );
  }
}
