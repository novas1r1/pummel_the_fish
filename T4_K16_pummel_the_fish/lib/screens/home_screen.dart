import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import "package:pummel_the_fish/data/models/pet.dart";
import "package:pummel_the_fish/data/repositories/rest_pet_repository.dart";
import "package:pummel_the_fish/widgets/pet_list_error.dart";
import "package:pummel_the_fish/widgets/pet_list_loaded.dart";
import "package:pummel_the_fish/widgets/pet_list_loading.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final RestPetRepository restPetRepository;

  late Future<List<Pet>> pets;

  @override
  void initState() {
    super.initState();
    final httpClient = http.Client();
    restPetRepository = RestPetRepository(
      httpClient: httpClient,
    );
    pets = restPetRepository.getAllPets();
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
        actions: const [
          // _updatePet.Aufruf
          /* IconButton(
            onPressed: () => _updatePet(),
            icon: const Icon(Icons.update),
          ), */
          // _deletePetById-Aufruf
          /* IconButton(
            onPressed: () => _deletePetById("646cec352db7d3a191a48f7b"),
            icon: const Icon(Icons.delete),
          ), */
          // _addNewPet-Aufruf
          /* IconButton(
            onPressed: () => _addNewPet(),
            icon: const Icon(Icons.add),
          ), */
          // T4K16 Übung: _getPetById-Aufruf
          // Verwenden Sie eine gültige ID von einem Pet-Objekt, das Sie von
          // der REST-API durch getAllPets erhalten haben.
          /* IconButton(
            onPressed: () => _getPetById("646cebd72db7d3a191a48f78"),
            icon: const Icon(Icons.download),
          ), */
          // _getAllPets-Aufruf
          /* IconButton(
            onPressed: () => _getAllPets(),
            icon: const Icon(Icons.download),
          ), */
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: FutureBuilder<List<Pet>>(
            initialData: const [],
            future: pets,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const PetListLoading();
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return PetListLoaded(pets: snapshot.data!);
                  } else {
                    return const PetListError(
                      message: "Fehler beim Laden der Tiere",
                    );
                  }
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, "/create");
          setState(() {
            pets = restPetRepository.getAllPets();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<List<Pet>> _getAllPets() async {
    final httpClient = http.Client();
    final restPetRepository = RestPetRepository(
      httpClient: httpClient,
    );
    final pets = await restPetRepository.getAllPets();

    return pets;
  }

  Future<void> _getPetById(String id) async {
    final httpClient = http.Client();
    final restPetRepository = RestPetRepository(
      httpClient: httpClient,
    );

    final pet = await restPetRepository.getPetById(id);
    print(pet);
  }

  Future<void> _addNewPet() async {
    final httpClient = http.Client();
    final restPetRepository = RestPetRepository(
      httpClient: httpClient,
    );

    const keksTheDog = Pet(
      id: "646cebd72db7d3a191a48f78",
      name: "Keks",
      species: Species.dog,
      weight: 250.0,
      height: 45.0,
      age: 10,
    );

    await restPetRepository.addPet(keksTheDog);
  }

  Future<void> _updatePet() async {
    final httpClient = http.Client();
    final restPetRepository = RestPetRepository(
      httpClient: httpClient,
    );

    const keksTheDog = Pet(
      id: "646cebd72db7d3a191a48f78",
      name: "Keks",
      species: Species.dog,
      weight: 250.0,
      height: 45.0,
      age: 10,
    );

    await restPetRepository.updatePet(keksTheDog);
  }

  Future<void> _deletePetById(String id) async {
    final httpClient = http.Client();
    final restPetRepository = RestPetRepository(
      httpClient: httpClient,
    );

    await restPetRepository.deletePetById(id);
  }
}
