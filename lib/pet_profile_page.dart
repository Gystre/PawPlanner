import 'package:flutter/material.dart';
import 'pet.dart';

class PetProfilePage extends StatelessWidget {
  final Pet pet;

  const PetProfilePage({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${pet.name}'s Profile"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${pet.name}'),
            Text('Species: ${pet.species}'),
            Text('Breed: ${pet.breed}'),
            Text('Age: ${pet.age}'),
            Text('Weight: ${pet.weight}'),
            if (pet.dietaryRestrictions != null)
              Text('Dietary Restrictions: ${pet.dietaryRestrictions!}'),
            if (pet.medication != null) Text('Medication: ${pet.medication!}'),
          ],
        ),
      ),
    );
  }
}
