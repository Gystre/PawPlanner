import 'package:flutter/material.dart';
import 'package:paw_planner/pet.dart';
import 'package:paw_planner/task.dart';
import 'package:intl/intl.dart';
import 'package:paw_planner/task_profile_page.dart';

class TasksPage extends StatelessWidget {
  final List<Pet> pets;
  final Function(int petIdx, int taskIdx) deleteTask;
  final Function(int petIdx, Task task) addTask;
  final Function(int petIdx, Task task) setTask;
  TasksPage({
    super.key,
    required this.pets,
    required this.deleteTask,
    required this.addTask,
    required this.setTask,
  });

  final format = DateFormat('MM/dd/yyyy, h:mm a');

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
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child:
                          Image.asset("assets/eve.png", width: 64, height: 64),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      pet.name,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Column(
                  children: pet.tasks.asMap().entries.map((entry) {
                    final j = entry.key;
                    final task = entry.value;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskProfilePage(
                                task: task,
                                pet: pet,
                                setTask: setTask,
                              ),
                            ),
                          );
                        },
                        child: Dismissible(
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
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Hero(
                                      tag:
                                          "${pet.name} ${task.idx} $j", // requires pet's name, pet's id, and task's index to be truly unique
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Text(
                                          task.name,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Due: ${format.format(task.dueDate)}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "Frequency: ${task.frequency.name}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),

                                // make the arrow appear on the right most side
                                Expanded(child: Container()),
                                const Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
              ],
            );
          },
        ),
      ),
    );
  }
}
