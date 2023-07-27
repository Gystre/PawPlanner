import 'package:flutter/material.dart';
import "pet.dart";

class PetsPage extends StatelessWidget {
  // final List<Pet> pets;
  // const PetsPage({super.key, required this.pets});
  const PetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pets'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(child: Text('Pets Page')),
    );
  }
}
