import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paw_planner/forms/edit_task_form.dart';
import 'package:paw_planner/pet.dart';
import 'package:paw_planner/task.dart';

class TaskProfilePage extends StatelessWidget {
  final Pet pet;
  final Task task;
  final Function(int petIdx, Task task) setTask;
  TaskProfilePage({
    super.key,
    required this.task,
    required this.pet,
    required this.setTask,
  });

  final format = DateFormat('MMMM dd, yyyy h:mm a');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pet.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<Task>(
                  builder: (context) => EditTaskForm(
                    task: task,
                  ),
                ),
              ).then((newTask) {
                if (newTask == null) {
                  return;
                }

                // set the task
                setTask(pet.idx, newTask);
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "${pet.name} ${pet.idx} ${task.idx}",
              child: Material(
                color: Colors.transparent,
                child: Text(
                  task.name,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // description
            TaskInfo(caption: "Description", text: task.description),
            const SizedBox(height: 8),

            // due date
            TaskInfo(caption: "Due Date", text: format.format(task.dueDate)),
            const SizedBox(height: 8),

            // frequency
            TaskInfo(caption: "Frequency", text: task.frequency.name),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class TaskInfo extends StatelessWidget {
  const TaskInfo({
    super.key,
    required this.text,
    required this.caption,
  });

  final String caption;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // name
          Text(
            caption,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
