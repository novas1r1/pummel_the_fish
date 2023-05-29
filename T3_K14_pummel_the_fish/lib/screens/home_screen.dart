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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ListView.builder(
            itemCount: pets.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(
                  pets[index].isFemale ? Icons.female : Icons.male,
                  color: const Color(0xFFFFC942),
                  size: 40,
                ),
                title: Text(pets[index].name),
                subtitle: Text(
                  "Alter: ${pets[index].age} Jahre ",
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                ),
                onTap: () {
                  // T3K14 Übung: DetailPetScreen mit Argumenten aufrufen
                  // Hier wird das Pet-Objekt als Argument übergeben
                  Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: pets[index],
                  );

                  // T3K13: DetailPetScreen ohne Argumente aufrufen und stattdessen
                  // das Pet-Objekt im Konstruktor übergeben
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => const DetailPetScreen(pet:pet[index]),
                  //   ),
                  // );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/create");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
