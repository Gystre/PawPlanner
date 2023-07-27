import 'package:flutter/material.dart';
import "pet_profile_page.dart";
import "pet.dart";

class PetsPage extends StatelessWidget {
  final List<Pet> pets;
  const PetsPage({super.key, required this.pets});

  @override
  Widget build(BuildContext context) {
    print("buliding pets page");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pets'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];

          return Padding(
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
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
