import "package:flutter/material.dart";
import "package:pummel_the_fish/data/models/pet.dart";
import "package:pummel_the_fish/theme/custom_colors.dart";

class DetailPetScreen extends StatelessWidget {
  // T3K14: Übung: DetailPetScreen mit Argumenten aufrufen
  // Das Pet-Objekt wird nun nicht mehr direkt übergeben
  // final Pet pet;

  const DetailPetScreen({
    super.key,
    // Das Pet-Objekt wird nun nicht mehr direkt übergeben
    // required this.pet,
  });

  @override
  Widget build(BuildContext context) {
    // T3K14: Übung: DetailPetScreen mit Argumenten aufrufen
    // Das Pet-Objekt wird durch die ModalRoute.of(context)!.settings.arguments bezogen
    final pet = ModalRoute.of(context)!.settings.arguments as Pet;

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
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  // T3K13: Als Wenn-Dann-Verzweigung
                  /* Image.asset(
                  pet.species == Species.dog
                      ? "assets/images/dog.jpg"
                      : pet.species == Species.bird
                          ? "assets/images/bird.jpg"
                          : pet.species == Species.cat
                              ? "assets/images/cat.jpg"
                              : "assets/images/fish.jpg",
                ), */
                  // T3K14: Als Helper-Funktion
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

  // T3K13: Als Helper-Funktion
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
