import 'package:flutter/material.dart';
import 'package:paw_planner/forms/edit_pet_form.dart';
import 'pet.dart';

class PetProfilePage extends StatelessWidget {
  final Pet pet;
  final Function(Pet pet) setPet;

  const PetProfilePage({Key? key, required this.pet, required this.setPet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${pet.name}'s Profile"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPetForm(
                    pet: pet,
                  ),
                ),
              ).then((newPet) {
                if (newPet == null) {
                  return;
                }

                // edit the pet with the new info
                setPet(pet);
              });
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Hero(
              tag: pet.name,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset("assets/eve.png", width: 256, height: 256),
              ),
            ),
            const SizedBox(height: 8),

            // name
            Text(
              pet.name,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),

            // species | breed
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  pet.species,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  ' | ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  pet.breed,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Age: ${pet.age} years old'),
            Text('Weight: ${pet.weight} lbs'),
            pet.dietaryRestrictions != null
                ? Text('Dietary Restrictions: ${pet.dietaryRestrictions}')
                : const Text("No dietary restrictions"),

            pet.medication != null
                ? Text('Medication: ${pet.medication}')
                : const Text("No medication required"),
          ],
        ),
      ),
    );
  }
}
