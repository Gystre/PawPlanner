enum TaskFrequency { daily, weekly, biweekly, monthly, oneTime }

class Task {
  // idx of the pet this task is associated with
  int petId;

  String name;
  String description;
  DateTime dueDate;
  TaskFrequency frequency;

  Task({
    required this.petId,
    required this.name,
    required this.description,
    required this.dueDate,
    required this.frequency,
  });
}
