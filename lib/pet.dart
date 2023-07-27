import "task.dart";

class Pet {
  String name;
  String species;
  String breed; // ex. siamese cat
  int age;
  double weight;
  String? dietaryRestrictions;
  String? medication;

  // the tasks associated with this pet
  List<Task> tasks = [
    Task(
      name: "Eat",
      frequency: TaskFrequency.daily,
      description: "Eat the dog",
      dueDate: DateTime.now(),
    )
  ];

  Pet({
    required this.name,
    required this.species,
    required this.age,
    required this.weight,
    required this.breed,
    this.dietaryRestrictions,
    this.medication,
  });
}
