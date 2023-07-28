import 'package:flutter/material.dart';
import 'package:paw_planner/pet.dart';

class EditPetForm extends StatefulWidget {
  final Pet pet;
  const EditPetForm({super.key, required this.pet});

  @override
  _EditPetFormState createState() => _EditPetFormState();
}

class _EditPetFormState extends State<EditPetForm> {
  final _formKey = GlobalKey<FormState>();
  late Pet _newPet;

  // Create TextEditingController instances for each field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _speciesController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _dietaryRestrictionsController =
      TextEditingController();
  final TextEditingController _medicationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _newPet = widget.pet;

    // Set initial values for the TextEditingController instances
    _nameController.text = _newPet.name;
    _speciesController.text = _newPet.species;
    _breedController.text = _newPet.breed;
    _ageController.text = _newPet.age.toString();
    _weightController.text = _newPet.weight.toString();
    _dietaryRestrictionsController.text =
        _newPet.dietaryRestrictions != null ? _newPet.dietaryRestrictions! : '';
    _medicationController.text =
        _newPet.medication != null ? _newPet.medication! : '';
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, _newPet);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${_newPet.name}'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // name
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onChanged: (value) => _newPet.name = value,
              ),

              // species
              TextFormField(
                decoration: const InputDecoration(labelText: 'Species'),
                controller: _speciesController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a species';
                  }
                  return null;
                },
                onChanged: (value) => _newPet.species = value,
              ),

              // breed
              TextFormField(
                decoration: const InputDecoration(labelText: 'Breed'),
                controller: _breedController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a breed';
                  }
                  return null;
                },
                onChanged: (value) => _newPet.breed = value,
              ),

              // age
              TextFormField(
                decoration: const InputDecoration(labelText: 'Age'),
                controller: _ageController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
                onChanged: (value) => _newPet.age = int.parse(value),
              ),

              // weight
              TextFormField(
                decoration: const InputDecoration(labelText: 'Weight'),
                controller: _weightController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a weight';
                  }
                  return null;
                },
                onChanged: (value) => _newPet.weight = double.parse(value),
              ),

              // dietary restrictions
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Dietary Restrictions'),
                controller: _dietaryRestrictionsController,
                onChanged: (value) => _newPet.dietaryRestrictions = value,
              ),

              // medication
              TextFormField(
                decoration: const InputDecoration(labelText: 'Medication'),
                controller: _medicationController,
                onChanged: (value) => _newPet.medication = value,
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
