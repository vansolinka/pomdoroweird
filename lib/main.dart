import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'utils/screen_awake.dart';
import 'utils/notification_service.dart'; // ✅ Add this import
import 'utils/responsive.dart';
import 'package:permission_handler/permission_handler.dart';

void requestNotificationPermission() async {
  final status = await Permission.notification.status;
  if (!status.isGranted) {
    await Permission.notification.request();
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenAwake.enable();
  await NotificationService.init(); // ✅ Will now work
  requestNotificationPermission(); // 👈 Add this
  runApp(const PomodoroApp());
}

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Weird Clock',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        fontFamily: 'RobotoMono',
      ),
      home: HomeScreen(),
    );
  }
}
