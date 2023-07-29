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
      idx: 0,
      name: "Find the dog",
      frequency: TaskFrequency.daily,
      description:
          "Enim nostrum atque itaque. Enim nostrum fugit nobis culpa quod error ut quidem. Ut saepe mollitia accusantium error quis nihil cupiditate tenetur. Accusantium voluptas ea iste. Quisquam enim placeat repellat vel.",
      dueDate: DateTime.now(),
    ),
    Task(
      idx: 1,
      name: "It's probably out there",
      frequency: TaskFrequency.daily,
      description:
          "Enim nostrum atque itaque. Enim nostrum fugit nobis culpa quod error ut quidem. Ut saepe mollitia accusantium error quis nihil cupiditate tenetur. Accusantium voluptas ea iste. Quisquam enim placeat repellat vel.",
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
