import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:pummel_the_fish/data/models/pet.dart";
import "package:pummel_the_fish/data/repositories/firestore_pet_repository.dart";
import "package:pummel_the_fish/widgets/pet_list_error.dart";
import "package:pummel_the_fish/widgets/pet_list_loaded.dart";
import "package:pummel_the_fish/widgets/pet_list_loading.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final FirestorePetRepository firestorePetRepository;

  // T4K17: FutureBuilder
  // late Future<List<Pet>> pets;
  // T4K17: StreamBuilder
  late Stream<List<Pet>> petStream;

  @override
  void initState() {
    super.initState();
    firestorePetRepository = FirestorePetRepository(
      firestore: FirebaseFirestore.instance,
    );

    // FutureBuilder
    // pets = firestorePetRepository.getAllPets();
    // StreamBuilder
    petStream = firestorePetRepository.getPetsStream();
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
          child:
              // T4K17: StreamBuilder
              StreamBuilder<List<Pet>>(
            stream: petStream,
            initialData: const [],
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const PetListLoading();
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return PetListLoaded(pets: snapshot.data!);
                  } else {
                    return const PetListError(
                      message: "Fehler beim Laden der Kuscheltiere",
                    );
                  }
              }
            },
          ),
          // FutureBuilder
          /* FutureBuilder<List<Pet>>(
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
          ), */
        ),
      ),
      // StreamBuidler
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/create");
        },
        child: const Icon(Icons.add),
      ),
      // FutureBuilder
      /* floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, "/create");
          setState(() {
            pets = firestorePetRepository.getAllPets();
          });
        },
        child: const Icon(Icons.add),
      ), */
    );
  }
}
