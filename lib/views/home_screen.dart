import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_habit_screen.dart';
import 'habit_details_screen.dart';
import './../models/habit_model.dart';
import './../providers/habit_provider.dart';

class HomeScreen extends StatelessWidget {
  final String userName;

  HomeScreen({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home - Bem-vindo, $userName'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Provider.of<HabitProvider>(context, listen: false).resetHabits();
            },
          ),
        ],
      ),
      body: Consumer<HabitProvider>(
        builder: (context, habitProvider, child) {
          List<Habit> completedHabits = habitProvider.habits.where((habit) => habit.isCompleted).toList();
          List<Habit> incompleteHabits = habitProvider.habits.where((habit) => !habit.isCompleted).toList();

          return Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Hábitos Pendentes (${incompleteHabits.length})',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: incompleteHabits.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(incompleteHabits[index].name),
                            subtitle: Text(incompleteHabits[index].description),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  incompleteHabits[index].resetCount.toString(),
                                  style: TextStyle(color: Colors.red),
                                ),
                                Checkbox(
                                  value: incompleteHabits[index].isCompleted,
                                  onChanged: (bool? value) {
                                    Provider.of<HabitProvider>(context, listen: false)
                                        .toggleHabitCompletion(incompleteHabits[index]);
                                  },
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HabitDetailsScreen(habit: incompleteHabits[index]),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Hábitos Completos (${completedHabits.length})',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: completedHabits.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(completedHabits[index].name),
                            subtitle: Text(completedHabits[index].description),
                            trailing: Checkbox(
                              value: completedHabits[index].isCompleted,
                              onChanged: (bool? value) {
                                Provider.of<HabitProvider>(context, listen: false)
                                    .toggleHabitCompletion(completedHabits[index]);
                              },
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HabitDetailsScreen(habit: completedHabits[index]),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newHabit = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddHabitScreen()),
          );

          if (newHabit != null) {
            Provider.of<HabitProvider>(context, listen: false).addHabit(newHabit);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}