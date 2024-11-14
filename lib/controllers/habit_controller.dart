import '../models/habit_model.dart';

class HabitController {
  List<Habit> habits = [];

  void addHabit(String name, String description) {
    habits.add(Habit(name: name, description: description));
  }

  void completeHabit(int index) {
    habits[index].isCompleted = true;
  }

  void removeHabit(int index) {
    habits.removeAt(index);
  }
}
