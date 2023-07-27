import 'package:flutter/material.dart';
import 'package:paw_planner/pet.dart';
import 'package:paw_planner/task.dart';
import 'package:intl/intl.dart';

class TasksPage extends StatelessWidget {
  final List<Pet> pets;
  final Function(int petIdx, int taskIdx) deleteTask;
  final Function(int petIdx, Task task) addTask;
  TasksPage({
    super.key,
    required this.pets,
    required this.deleteTask,
    required this.addTask,
  });

  final format = DateFormat('h:mm a');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: pets.length,
          itemBuilder: (context, i) {
            final pet = pets[i];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pet.name,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Column(
                  children: pet.tasks.asMap().entries.map((entry) {
                    final j = entry.key;
                    final task = entry.value;

                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) => {
                        deleteTask(i, j),
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${task.name} deleted"),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                addTask(i, task);
                              },
                            ),
                          ),
                        ),
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Time: ${format.format(task.dueDate)}",
                            ),
                            Text(
                              "Frequency: ${task.frequency.name}",
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }
}
