import "task.dart";

class Pet {
  String name;
  String species;
  int age;
  double weight;
  String? dietaryRestrictions;
  String? medication;

  // the tasks associated with this pet
  List<Task> tasks = [];

  Pet({
    required this.name,
    required this.species,
    required this.age,
    required this.weight,
    this.dietaryRestrictions,
    this.medication,
  });
}
