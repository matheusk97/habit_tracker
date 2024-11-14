class Habit {
  String name;
  String description;
  int resetCount; 
  bool isCompleted;

  Habit({
    required this.name,
    required this.description,
    this.resetCount = 0,
    this.isCompleted = false,
  });
}
