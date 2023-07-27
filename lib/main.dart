import 'package:flutter/material.dart';
import "package:paw_planner/add_pet_form.dart";
import "package:paw_planner/add_task_form.dart";
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
  List<Pet> _pets = [
    Pet(
        name: "bruh",
        species: "dog",
        breed: "ballerman69",
        age: 1,
        weight: 1.0),
    Pet(name: "ez", species: "cat", breed: "bruhmobile123", age: 2, weight: 2.0)
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: Scaffold(
        // body: _pages[_selectedIndex],
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            TasksPage(
              pets: _pets,
              deleteTask: _deleteTask,
              addTask: _addTask,
            ),
            PetsPage(pets: _pets, addPet: _addPet, deletePet: _deletePet),
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
            MaterialPageRoute<Task>(
              builder: (context) => AddTaskForm(pets: _pets),
            ),
          ).then((newTask) {
            if (newTask == null) {
              return;
            }

            print(newTask.petIds);

            // iterate through all the pet ids and add the tasks to them
            setState(() {
              for (int petId in newTask.petIds) {
                _pets[petId].tasks.add(newTask);
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
            MaterialPageRoute<Pet>(builder: (context) => const AddPetForm()),
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
