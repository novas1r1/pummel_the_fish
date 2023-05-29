import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:pummel_the_fish/data/models/pet.dart";
import "package:pummel_the_fish/data/repositories/firestore_pet_repository.dart";
import "package:pummel_the_fish/theme/custom_colors.dart";
import "package:pummel_the_fish/widgets/custom_button.dart";

class EditPetScreen extends StatefulWidget {
  final Pet pet;

  const EditPetScreen({super.key, required this.pet});

  @override
  State<EditPetScreen> createState() => _EditPetScreenState();
}

class _EditPetScreenState extends State<EditPetScreen> {
  final _formKey = GlobalKey<FormState>();

  bool currentIsFemale = false;
  String? currentName;
  int? currentAge;
  double? currentHeight;
  double? currentWeight;
  Species? currentSpecies;

  late final FirestorePetRepository firestorePetRepository;

  @override
  void initState() {
    super.initState();

    firestorePetRepository = FirestorePetRepository(
      firestore: FirebaseFirestore.instance,
    );

    // Die Felder werden mit den Werten des übergebenen Pet-Objekts vorbefüllt
    currentName = widget.pet.name;
    currentAge = widget.pet.age;
    currentHeight = widget.pet.height;
    currentWeight = widget.pet.weight;
    currentSpecies = widget.pet.species;
    currentIsFemale = widget.pet.isFemale;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Neues Tier anlegen"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: MediaQuery.of(context).orientation == Orientation.portrait
              ? const EdgeInsets.all(24)
              : EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: MediaQuery.of(context).size.width / 5,
                ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: CustomColors.blueMedium),
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                  onChanged: (value) {
                    currentName = value;
                  },
                  initialValue: currentName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Bitte einen Namen eingeben";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: CustomColors.blueMedium),
                  decoration: const InputDecoration(
                    labelText: "Alter (Jahre)",
                  ),
                  onChanged: (value) {
                    currentAge = int.tryParse(value);
                  },
                  initialValue: currentAge.toString(),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Bitte ein Alter eingeben";
                    } else {
                      if (int.tryParse(value) == null) {
                        return "Bitte eine Zahl eingeben";
                      }

                      return null;
                    }
                  },
                ),
                TextFormField(
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: CustomColors.blueMedium),
                  decoration: const InputDecoration(
                    labelText: "Höhe (cm)",
                  ),
                  onChanged: (value) {
                    currentHeight = double.tryParse(value);
                  },
                  initialValue: currentHeight.toString(),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Bitte eine Höhe eingeben";
                    } else {
                      if (double.tryParse(value) == null) {
                        return "Bitte eine Zahl eingeben";
                      }

                      return null;
                    }
                  },
                ),
                TextFormField(
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: CustomColors.blueMedium),
                  decoration: const InputDecoration(
                    labelText: "Gewicht (Gramm)",
                  ),
                  onChanged: (value) {
                    currentWeight = double.tryParse(value);
                  },
                  initialValue: currentWeight.toString(),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Bitte ein Gewicht eingeben";
                    } else {
                      if (double.tryParse(value) == null) {
                        return "Bitte eine Zahl eingeben";
                      }

                      return null;
                    }
                  },
                ),
                DropdownButtonFormField<Species>(
                  hint: Text(
                    "Bitte wählen Sie eine Spezies",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  value: currentSpecies,
                  items: [
                    DropdownMenuItem(
                      value: Species.dog,
                      child: Text(
                        "Hund",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: CustomColors.blueMedium),
                      ),
                    ),
                    DropdownMenuItem(
                      value: Species.cat,
                      child: Text(
                        "Katze",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: CustomColors.blueMedium),
                      ),
                    ),
                    DropdownMenuItem(
                      value: Species.fish,
                      child: Text(
                        "Fisch",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: CustomColors.blueMedium),
                      ),
                    ),
                    DropdownMenuItem(
                      value: Species.bird,
                      child: Text(
                        "Vogel",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: CustomColors.blueMedium),
                      ),
                    ),
                  ],
                  onChanged: (Species? value) {
                    currentSpecies = value;
                  },
                  validator: (value) =>
                      value == null ? "Bitte eine Spezies angeben" : null,
                ),
                CheckboxListTile(
                  title: Text(
                    "Weiblich",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 16,
                  ),
                  value: currentIsFemale,
                  activeColor: CustomColors.blueMedium,
                  side: const BorderSide(color: CustomColors.blueDark),
                  onChanged: (bool? value) {
                    if (value != null) {
                      print(value);
                      setState(() {
                        currentIsFemale = value;
                      });
                    }
                  },
                ),
                CustomButton(
                  onPressed: () => _editPet(),
                  label: "Speichern",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _editPet() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Hier ist es wichtig, dass die ID des ursprünglichen
        // Pet-Objekts (widget.pet.id) mit übergeben wird.
        final petToUpdate = Pet(
          id: widget.pet.id,
          name: currentName!,
          species: currentSpecies!,
          age: currentAge!,
          weight: currentWeight!,
          height: currentHeight!,
          isFemale: currentIsFemale,
        );

        await firestorePetRepository.updatePet(petToUpdate);

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: CustomColors.blueDark,
            content: Text(
              "Kuscheltier erfolgreich aktualisiert",
            ),
          ),
        );

        // Das aktualisierte Pet-Objekt wird an die vorherige Seite zurückgegeben
        // Somit kann diese mit den aktualisierten Daten geladen werden.
        // Wird beim StreamBuilder-Ansatz nich mehr benötigt
        Navigator.pop<Pet>(context, petToUpdate);
      } on Exception {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: CustomColors.red,
            content: Text(
              "Fehler beim Aktualisieren des Kuscheltiers",
            ),
          ),
        );
      }
    }
  }
}
