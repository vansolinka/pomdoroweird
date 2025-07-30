import 'package:flutter/services.dart';

class ScreenAwake {
  static const MethodChannel _channel = MethodChannel('keep_screen_on');

  /// Call this to keep the screen awake
  static Future<void> enable() async {
    try {
      await _channel.invokeMethod('enable');
    } catch (e) {
      print('Failed to enable screen-on: $e');
    }
  }

  /// Call this to allow screen to sleep again (optional)
  static Future<void> disable() async {
    try {
      await _channel.invokeMethod('disable');
    } catch (e) {
      print('Failed to disable screen-on: $e');
    }
  }
}
