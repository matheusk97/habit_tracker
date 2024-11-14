import 'package:flutter/material.dart';
import './../models/habit_model.dart';

class AddHabitScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  AddHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Hábito'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newHabit = Habit(
                  name: nameController.text,
                  description: descriptionController.text,
                );
                Navigator.pop(context, newHabit);
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}