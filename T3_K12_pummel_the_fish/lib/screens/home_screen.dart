import "package:flutter/material.dart";
import "package:pummel_the_fish/data/models/pet.dart";
import "package:pummel_the_fish/data/repositories/fake_pet_repository.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final petRepository = FakePetRepository();
  List<Pet> pets = [];

  @override
  void initState() {
    super.initState();
    pets = petRepository.getAllPets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.asset("assets/images/pummel.png"),
        ),
        title: const Text("Pummel The Fish"),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: pets.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.pets),
              title: Text(pets[index].name),
              subtitle: Text(
                "Alter: ${pets[index].age} Jahre ",
              ),
              trailing: const Icon(
                Icons.chevron_right_rounded,
              ),
              onTap: () {},
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
