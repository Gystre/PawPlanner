import 'package:flutter/material.dart';
import "pet_profile_page.dart";
import "pet.dart";

class PetsPage extends StatelessWidget {
  final List<Pet> pets;
  final Function(Pet pet) addPet;
  final Function(int index) deletePet;
  final Function(Pet pet) setPet;
  const PetsPage({
    super.key,
    required this.pets,
    required this.addPet,
    required this.deletePet,
    required this.setPet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pets'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: pets.length,
          itemBuilder: (context, index) {
            final pet = pets[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PetProfilePage(pet: pet, setPet: setPet),
                  ),
                );
              },
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
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
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.only(bottom: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: Row(
                    children: [
                      // placeholder image
                      Hero(
                        tag: pet.name,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset("assets/eve.png",
                              width: 96, height: 96),
                        ),
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                pet.breed,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
