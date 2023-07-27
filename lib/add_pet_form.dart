import 'package:flutter/material.dart';
import 'pet.dart';

class AddPetForm extends StatefulWidget {
  const AddPetForm({super.key});

  @override
  _AddPetFormState createState() => _AddPetFormState();
}

class _AddPetFormState extends State<AddPetForm> {
  final _formKey = GlobalKey<FormState>();
  final Pet _newPet = Pet(name: '', species: '', breed: '', age: 0, weight: 0);

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, _newPet);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Pet'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onChanged: (value) => _newPet.name = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Species'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a species';
                  }
                  return null;
                },
                onChanged: (value) => _newPet.species = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Breed'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a breed';
                  }
                  return null;
                },
                onChanged: (value) => _newPet.breed = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
                onChanged: (value) => _newPet.age = int.tryParse(value) ?? 0,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Weight'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a weight';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid weight';
                  }
                  return null;
                },
                onChanged: (value) =>
                    _newPet.weight = double.tryParse(value) ?? 0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Dietary Restrictions (optional)'),
                onChanged: (value) => _newPet.dietaryRestrictions = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Medication (optional)'),
                onChanged: (value) => _newPet.medication = value,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Pet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
