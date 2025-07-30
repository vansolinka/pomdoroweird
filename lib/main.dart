import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // 👈 you’ll create this next
import 'utils/screen_awake.dart'; // 👈 import the new file



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenAwake.enable(); // ✅ keeps screen on
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
        fontFamily: 'RobotoMono', // optional weird font if you use it
      ),
      home: HomeScreen(), // 👈 your landing page
    );
  }
}
