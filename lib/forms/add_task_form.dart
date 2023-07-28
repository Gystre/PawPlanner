import 'package:flutter/material.dart';
import 'package:paw_planner/pet.dart';
import 'package:paw_planner/task.dart';
import 'package:intl/intl.dart';

class AddTaskForm extends StatefulWidget {
  final List<Pet> pets;
  const AddTaskForm({super.key, required this.pets});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();

  final Task _newTask = Task(
    idx: 0,
    name: '',
    description: '',
    dueDate: DateTime.now(),
    frequency: TaskFrequency.daily,
  );

  final List<int> _petIds = [];

  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  void _submitForm() {
    if (_petIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one pet'),
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      // set the task index to the next available index in each pet
      for (final pet in widget.pets) {
        _newTask.idx = pet.tasks.length;
      }

      // pop the data as a map
      Navigator.pop(context, {
        'task': _newTask,
        'petIds': _petIds,
      });
    }
  }

  void _onPetCheckboxChanged(bool? isChecked, int petId) {
    if (isChecked != null && isChecked) {
      setState(() {
        _petIds.add(petId);
      });
    } else {
      setState(() {
        _petIds.remove(petId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onChanged: (value) => _newTask.name = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Description"),
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
              const SizedBox(height: 16),
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
              const Text("Pets"),
              ...widget.pets.asMap().entries.map<Widget>((entry) {
                return CheckboxListTile(
                  title: Text(entry.value.name),
                  value: _petIds.contains(entry.key),
                  onChanged: (bool? isChecked) {
                    _onPetCheckboxChanged(isChecked, entry.key);
                  },
                );
              }).toList(),
              const SizedBox(height: 16),
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
