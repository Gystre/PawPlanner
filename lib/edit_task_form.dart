import 'package:flutter/material.dart';
import 'package:paw_planner/task.dart';

class EditTaskForm extends StatefulWidget {
  final Task task;
  const EditTaskForm({super.key, required this.task});

  @override
  State<EditTaskForm> createState() => _EditTaskFormState();
}

class _EditTaskFormState extends State<EditTaskForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Task"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
