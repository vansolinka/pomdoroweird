import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettings = InitializationSettings(
      android: androidSettings,
    );

    await _plugin.initialize(initializationSettings);

  }

  static Future<void> showNotification(String message) async {
    const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('ic_stat_pw'); // 👈 no file extension!
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'pomodoro_channel', // Channel ID
      'Pomodoro Notifications', // Channel name
      channelDescription: 'Notifications for Pomodoro timer',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      icon: 'ic_stat_pw', // default app icon
      fullScreenIntent: true, // 👈 Forces popup on lock screen
      visibility: NotificationVisibility.public, // 👈 Ensures lockscreen visibility
    );


    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await _plugin.show(
      0, // Notification ID
      'Pomodoro Complete ✅', // Notification title
      message, // Notification body
      platformDetails,
    );
  }
}
