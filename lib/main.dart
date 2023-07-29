import 'package:flutter/material.dart';
import "package:paw_planner/forms/add_pet_form.dart";
import "package:paw_planner/forms/add_task_form.dart";
import "package:paw_planner/pet.dart";
import "package:paw_planner/pets_page.dart";
import "package:paw_planner/task.dart";
import "package:paw_planner/tasks_page.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Pet> _pets = [
    Pet(
      idx: 0,
      name: "Eve",
      species: "Dog",
      breed: "Anime girl",
      age: 999,
      weight: 999,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addPet(Pet pet) {
    setState(() {
      _pets.add(pet);
    });
  }

  void _setPet(Pet pet) {
    setState(() {
      _pets[pet.idx] = pet;
    });
  }

  void _deletePet(int index) {
    setState(() {
      _pets.removeAt(index);
    });
  }

  void _deleteTask(int petIdx, int taskIdx) {
    setState(() {
      _pets[petIdx].tasks.removeAt(taskIdx);
    });
  }

  void _addTask(int petIdx, Task task) {
    setState(() {
      _pets[petIdx].tasks.add(task);
    });
  }

  void _setTask(int petIdx, Task task) {
    setState(() {
      _pets[petIdx].tasks[task.idx] = task;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            TasksPage(
              pets: _pets,
              deleteTask: _deleteTask,
              addTask: _addTask,
              setTask: _setTask,
            ),
            PetsPage(
              pets: _pets,
              addPet: _addPet,
              deletePet: _deletePet,
              setPet: _setPet,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pets),
              label: 'Pets',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    if (_selectedIndex == 0) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskForm(pets: _pets),
            ),
          ).then((data) {
            // type safety uhhhh wuts that
            if (data == null) {
              return;
            }

            // iterate through all the pet ids and add the tasks to them
            setState(() {
              for (int petId in data["petIds"]) {
                _pets[petId].tasks.add(data["task"]);
              }
            });
          });
        },
        child: const Icon(Icons.add),
      );
    } else if (_selectedIndex == 1) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<Pet>(
              builder: (context) => AddPetForm(
                nextIdx: _pets.length,
              ),
            ),
          ).then((newPet) {
            if (newPet == null) {
              return;
            }

            setState(() {
              _pets.add(newPet);
            });
          });
        },
        child: const Icon(Icons.add),
      );
    }

    // Default case, return an empty FloatingActionButton with no onPressed action.
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add),
    );
  }
}
