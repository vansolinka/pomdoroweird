import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // 👈 you’ll create this next

void main() {
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
      home: const HomeScreen(), // 👈 your landing page
    );
  }
}
