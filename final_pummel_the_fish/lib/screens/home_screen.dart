import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pummel_the_fish/data/repositories/firestore_pet_repository.dart";
import "package:pummel_the_fish/logic/cubits/manage_pets_simple_cubit.dart";
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
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManagePetsSimpleCubit(
        context.read<FirestorePetRepository>(),
      )..getAllPets(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Image.asset("assets/images/pummel.png"),
              ),
              title: const Text("Pummel The Fish"),
              actions: [
                AdoptionBag(
                  petCount: InheritedAdoptionBag.of(context).petCount,
                ),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child:
                    BlocConsumer<ManagePetsSimpleCubit, ManagePetsSimpleState>(
                  listener: (context, state) {
                    if (state.status == ManagePetsStatus.error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Es ist ein Fehler aufgetreten."),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    switch (state.status) {
                      case ManagePetsStatus.initial:
                        return const PetListError(
                          message:
                              "Keine Kuscheltiere zur Adoption freigegeben",
                        );
                      case ManagePetsStatus.loading:
                        return const PetListLoading();
                      case ManagePetsStatus.success:
                        return PetListLoaded(pets: state.pets);
                      case ManagePetsStatus.error:
                        return const PetListError(
                          message: "Fehler beim Laden der Kuscheltiere",
                        );
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
        },
      ),
    );
  }
}
