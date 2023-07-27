import "task.dart";

class Pet {
  // this is for the edit functions so that I can just pass in the object and the object will know where it is in the pets list
  int idx;

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
      name: "Eat the dog",
      frequency: TaskFrequency.daily,
      description: "Consume while fresh",
      dueDate: DateTime.now(),
    )
  ];

  Pet({
    required this.idx,
    required this.name,
    required this.species,
    required this.age,
    required this.weight,
    required this.breed,
    this.dietaryRestrictions,
    this.medication,
  });
}
