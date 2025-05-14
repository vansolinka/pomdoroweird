import 'dart:async';
import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class DigitalTimer extends StatefulWidget {
  final Duration initialTime;
  final TextStyle? textStyle;
  final void Function(Duration)? onTick; // 👈 onTick callback

  const DigitalTimer({
    super.key,
    required this.initialTime,
    this.textStyle,
    this.onTick, // 👈 Add it to the constructor too
  });

  @override
  State<DigitalTimer> createState() => DigitalTimerState();
}

class DigitalTimerState extends State<DigitalTimer> {
  late Duration _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = widget.initialTime;
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining.inSeconds > 0) {
        setState(() {
          _remaining -= const Duration(seconds: 1);
        });
        widget.onTick?.call(_remaining); // ✅ Call the onTick callback
      } else {
        _timer?.cancel();
      }
    });
  }

  void pauseTimer() {
    _timer?.cancel();
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      _remaining = widget.initialTime;
    });
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
    return StrokedText(
      text: _format(_remaining),
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
        // Stroke
        Text(
          text,
          style: style.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        // Fill
        Text(
          text,
          style: style,
        ),
      ],
    );
  }
}
