import 'package:flutter/material.dart';
import 'package:paw_planner/task.dart';
import 'package:intl/intl.dart';

class EditTaskForm extends StatefulWidget {
  final Task task;
  const EditTaskForm({super.key, required this.task});

  @override
  State<EditTaskForm> createState() => _EditTaskFormState();
}

class _EditTaskFormState extends State<EditTaskForm> {
  final _formKey = GlobalKey<FormState>();
  late Task _newTask;

  // Create TextEditingController instances for each field
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _frequencyController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _newTask = widget.task;

    // set form values
    _nameController.text = _newTask.name;
    _descriptionController.text = _newTask.description;
    _frequencyController.text = _newTask.frequency.toString();
    _dateController.text = DateFormat.yMd().format(_newTask.dueDate);
    _timeController.text = DateFormat.jm().format(_newTask.dueDate);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print(_newTask.name);
      Navigator.pop(context, _newTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Task"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onChanged: (value) => _newTask.name = value,
              ),

              // description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onChanged: (value) => _newTask.description = value,
              ),

              // due date and time picker
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _dateController,
                      decoration: const InputDecoration(labelText: "Due Date"),
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _newTask.dueDate,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        );
                        if (date != null) {
                          setState(() {
                            _newTask.dueDate = date;
                            _dateController.text =
                                DateFormat.yMd().format(date);

                            // set the time picker text
                            _timeController.text =
                                DateFormat.jm().format(_newTask.dueDate);
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _timeController,
                      decoration: const InputDecoration(labelText: "Due Time"),
                      readOnly: true,
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(_newTask.dueDate),
                        );

                        if (time != null) {
                          // set the time of the due date
                          setState(() {
                            _newTask.dueDate = DateTime(
                              _newTask.dueDate.year,
                              _newTask.dueDate.month,
                              _newTask.dueDate.day,
                              time.hour,
                              time.minute,
                            );
                            _timeController.text =
                                DateFormat.jm().format(_newTask.dueDate);
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              // frequency
              DropdownButtonFormField<TaskFrequency>(
                decoration: const InputDecoration(labelText: "Frequency"),
                value: _newTask.frequency,
                onChanged: (value) {
                  setState(() {
                    _newTask.frequency = value!;
                  });
                },
                items: TaskFrequency.values.map((TaskFrequency frequency) {
                  return DropdownMenuItem<TaskFrequency>(
                    value: frequency,
                    child: Text(frequency.name),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a frequency';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // submit button
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
