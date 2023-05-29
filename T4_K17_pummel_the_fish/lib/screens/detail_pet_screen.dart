import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:pummel_the_fish/data/models/pet.dart";
import "package:pummel_the_fish/data/repositories/firestore_pet_repository.dart";
import "package:pummel_the_fish/screens/edit_pet_screen.dart";
import "package:pummel_the_fish/theme/custom_colors.dart";

class DetailPetScreen extends StatefulWidget {
  final Pet pet;

  const DetailPetScreen({
    super.key,
    required this.pet,
  });

  @override
  State<DetailPetScreen> createState() => _DetailPetScreenState();
}

class _DetailPetScreenState extends State<DetailPetScreen> {
  late final FirestorePetRepository firestorePetRepository;

  // T4K17 Übung: Bearbeiten eines Pets
  // Wir legen ein Pet-Objekt an, das wir später aktualisieren können
  late Pet pet;

  @override
  void initState() {
    super.initState();

    // T4K17 Übung: Bearbeiten eines Pets
    // Initial befüllen wir das Pet-Objekt mit den Daten des übergebenen Pets
    pet = widget.pet;

    firestorePetRepository = FirestorePetRepository(
      firestore: FirebaseFirestore.instance,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/home");
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, "/home");
            },
          ),
          title: Text(pet.name),
          actions: [
            // T4K17 Übung: Bearbeiten eines Pets
            // Wir fügen einen IconButton hinzu, der den EditPetScreen aufruft
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _onEditPet(pet),
            ),
            // T4K17 Übung: Löschen eines Pets
            // Wir fügen einen IconButton hinzu, der das Pet löscht
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _onDeletePet(pet.id),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  _buildImage(pet.species),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 40,
                      color: CustomColors.orangeTransparent,
                      child: Center(
                        child: Text(
                          "Adoptier mich!",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 24,
                ),
                child: Column(
                  children: <Widget>[
                    _InfoCard(
                      labelText: "Name des Kuscheltiers:",
                      infoText: pet.name,
                    ),
                    _InfoCard(
                      labelText: "Alter:",
                      infoText: "${pet.age} Jahre",
                    ),
                    _InfoCard(
                      labelText: "Größe & Gewicht:",
                      infoText: "${pet.height} cm / ${pet.weight} Gramm",
                    ),
                    _InfoCard(
                      labelText: "Geschlecht:",
                      infoText: pet.isFemale ? "Weiblich" : "Männlich",
                    ),
                    _InfoCard(
                      labelText: "Spezies:",
                      infoText: pet.species == Species.dog
                          ? "Hund"
                          : pet.species == Species.bird
                              ? "Vogel"
                              : pet.species == Species.cat
                                  ? "Katze"
                                  : "Fisch",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(Species species) {
    switch (species) {
      case Species.dog:
        return Image.asset("assets/images/dog.jpg");
      case Species.bird:
        return Image.asset("assets/images/bird.jpg");
      case Species.cat:
        return Image.asset("assets/images/cat.jpg");
      case Species.fish:
        return Image.asset("assets/images/fish.jpg");
    }
  }

  // T4K17 Übung: Löschen eines Pets per id
  // Anzeigen eines Snackbars mit Erfolgsmeldung oder Fehlermeldung
  void _onDeletePet(String id) {
    try {
      firestorePetRepository.deletePetById(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Kuscheltier erfolgreich gelöscht."),
        ),
      );
      Navigator.of(context).pop();
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Beim Löschen des Kuscheltiers ist etwas schief gelaufen.",
          ),
        ),
      );
    }
  }

  // T4K17 Übung: Bearbeiten eines Pets
  Future<void> _onEditPet(Pet petToUpdate) async {
    // Wir rufen den EditPetScreen auf, übergeben das aktuelle Pet-Objekt
    // und erwarten ein aktualisiertes Pet-Objekt zurück
    final updatedPet = await Navigator.push<Pet?>(context, MaterialPageRoute(
      builder: (context) {
        return EditPetScreen(pet: petToUpdate);
      },
    ));

    // Wenn das aktualisierte Pet-Objekt nicht null ist,
    // aktualisieren wir das Pet-Objekt im DetailPetScreen
    if (updatedPet != null) {
      setState(() {
        pet = updatedPet;
      });
    }
  }
}

class _InfoCard extends StatelessWidget {
  final String labelText;
  final String infoText;

  const _InfoCard({
    required this.labelText,
    required this.infoText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColors.blueMedium,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(labelText, style: Theme.of(context).textTheme.bodyMedium),
            Text(infoText, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
