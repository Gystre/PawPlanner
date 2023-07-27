import 'package:flutter/material.dart';
import "pet_profile_page.dart";
import "pet.dart";

class PetsPage extends StatelessWidget {
  final List<Pet> pets;
  final Function(Pet pet) addPet;
  final Function(int index) deletePet;
  const PetsPage({
    super.key,
    required this.pets,
    required this.addPet,
    required this.deletePet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pets'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];

          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              // figure out how to delete pet
              deletePet(index);

              // show snackbar to undo it
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${pet.name} deleted"),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      // Add the card back to the list if the user undoes the deletion
                      addPet(pet);
                    },
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PetProfilePage(pet: pet),
                    ),
                  );
                },
                child: Card(
                  child: Row(
                    children: [
                      // placeholder image
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey,
                      ),

                      // pet info
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pet.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                pet.breed,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
