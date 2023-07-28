enum TaskFrequency { daily, weekly, biweekly, monthly, oneTime }

extension TaskFrequencyExtension on TaskFrequency {
  String get name {
    switch (this) {
      case TaskFrequency.daily:
        return 'Daily';
      case TaskFrequency.weekly:
        return 'Weekly';
      case TaskFrequency.biweekly:
        return 'Biweekly';
      case TaskFrequency.monthly:
        return 'Monthly';
      case TaskFrequency.oneTime:
        return 'One Time';
      default:
        return '';
    }
  }
}

class Task {
  // tasks need to be able to know where in the list of tasks in the pet they're associated with
  // in order to be able update and delete the correct ones
  int idx;

  String name;
  String description;
  DateTime dueDate;
  TaskFrequency frequency;

  Task({
    required this.idx,
    required this.name,
    required this.description,
    required this.dueDate,
    required this.frequency,
  });
}
