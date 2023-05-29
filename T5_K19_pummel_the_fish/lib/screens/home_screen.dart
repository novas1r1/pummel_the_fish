import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:pummel_the_fish/data/models/pet.dart";
import "package:pummel_the_fish/data/repositories/firestore_pet_repository.dart";
import "package:pummel_the_fish/widgets/adoption_bag.dart";
import "package:pummel_the_fish/widgets/inherited_adoption_bag.dart";
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

  late Stream<List<Pet>> petStream;

  @override
  void initState() {
    super.initState();
    firestorePetRepository = FirestorePetRepository(
      firestore: FirebaseFirestore.instance,
    );

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
        // T5K19: Inherited Widget
        actions: [
          AdoptionBag(
            petCount: InheritedAdoptionBag.of(context).petCount,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: StreamBuilder<List<Pet>>(
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
