import "package:flutter/material.dart";
import "package:pummel_the_fish/data/models/pet.dart";
import "package:pummel_the_fish/widgets/custom_button.dart";

class CreatePetScreen extends StatefulWidget {
  const CreatePetScreen({super.key});

  @override
  State<CreatePetScreen> createState() => _CreatePetScreenState();
}

class _CreatePetScreenState extends State<CreatePetScreen> {
  final _formKey = GlobalKey<FormState>();

  bool currentIsFemale = false;
  String? currentName;
  int? currentAge;
  double? currentHeight;
  double? currentWeight;
  Species? currentSpecies;

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
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                  onChanged: (value) {
                    currentName = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Bitte einen Namen eingeben";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Alter (Jahre)",
                  ),
                  onChanged: (value) {
                    currentAge = int.tryParse(value);
                  },
                  // T3K11 Übung: spezielle Zahlen Tastatur öffnen
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Bitte ein Alter eingeben";
                    } else {
                      // T3K11 Übung: Validierung
                      if (int.tryParse(value) == null) {
                        return "Bitte eine Zahl eingeben";
                      }

                      return null;
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Höhe (cm)",
                  ),
                  onChanged: (value) {
                    currentHeight = double.tryParse(value);
                  },
                  // T3K11 Übung: spezielle Zahlen Tastatur öffnen
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Bitte eine Höhe eingeben";
                    } else {
                      // T3K11 Übung: Validierung
                      if (double.tryParse(value) == null) {
                        return "Bitte eine Zahl eingeben";
                      }

                      return null;
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Gewicht (Gramm)",
                  ),
                  onChanged: (value) {
                    currentWeight = double.tryParse(value);
                  },
                  // T3K11 Übung: spezielle Zahlen Tastatur öffnen
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Bitte ein Gewicht eingeben";
                    } else {
                      // T3K11: Übung Validierung
                      if (double.tryParse(value) == null) {
                        return "Bitte eine Zahl eingeben";
                      }

                      return null;
                    }
                  },
                ),
                DropdownButtonFormField<Species>(
                  hint: const Text("Bitte wählen Sie eine Tierart"),
                  items: const [
                    DropdownMenuItem(
                      value: Species.dog,
                      child: Text("Hund"),
                    ),
                    DropdownMenuItem(
                      value: Species.cat,
                      child: Text("Katze"),
                    ),
                    DropdownMenuItem(
                      value: Species.fish,
                      child: Text("Fisch"),
                    ),
                    DropdownMenuItem(
                      value: Species.bird,
                      child: Text("Vogel"),
                    ),
                  ],
                  onChanged: (Species? value) {
                    currentSpecies = value;
                  },
                  validator: (value) =>
                      value == null ? "Bitte eine Spezies angeben" : null,
                ),
                CheckboxListTile(
                  title: const Text("Weiblich"),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 0,
                  ),
                  value: currentIsFemale,
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
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final pet = Pet(
                        id: "test",
                        name: currentName!,
                        species: currentSpecies!,
                        age: currentAge!,
                        weight: currentWeight!,
                        height: currentHeight!,
                        isFemale: currentIsFemale,
                      );
                      print("$pet");
                    }
                  },
                  label: "Speichern",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
