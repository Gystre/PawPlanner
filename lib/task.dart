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
  // multiple tasks can be set to multiple pets
  List<int> petIds = [];

  String name;
  String description;
  DateTime dueDate;
  TaskFrequency frequency;

  Task({
    required this.name,
    required this.description,
    required this.dueDate,
    required this.frequency,
  });
}
