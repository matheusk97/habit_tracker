import 'package:flutter/material.dart';
import 'package:habit_tracker/views/login_screen.dart';
import 'package:provider/provider.dart';
import 'views/home_screen.dart';
import 'providers/habit_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HabitProvider()),
      ],
      child: MaterialApp(
        title: 'Habit Tracker',
        home: LoginScreen(),
      ),
    );
  }
}