import 'package:flutter/material.dart';
import './../models/habit_model.dart';

class HabitProvider with ChangeNotifier {
  final List<Habit> _habits = [];

  List<Habit> get habits => _habits;

  void addHabit(Habit habit) {
    _habits.add(habit);
    notifyListeners();
  }

  void resetHabits() {
    for (var habit in _habits) {
      if (habit.isCompleted) {
        habit.isCompleted = false;
        habit.resetCount = 0;
      } else {
        habit.resetCount++;
      }
    }
    notifyListeners();
  }

  void toggleHabitCompletion(Habit habit) {
    habit.isCompleted = !habit.isCompleted;
    notifyListeners();
  }
}