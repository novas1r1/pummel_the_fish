import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pummel_the_fish/data/models/pet.dart";
import "package:pummel_the_fish/logic/cubits/manage_pets_simple_cubit.dart";
import "package:pummel_the_fish/screens/edit_pet_screen.dart";
import "package:pummel_the_fish/theme/custom_colors.dart";
import "package:pummel_the_fish/widgets/custom_button.dart";
import "package:pummel_the_fish/widgets/inherited_adoption_bag.dart";

/// Dieser Screen wurde so angepasst, dass er über den ManagePetsCubit kommuniziert,
/// anstatt über das FirestoreRepository zu gehen. Schließlich wollen wir Logic und UI
/// voneinander trennen und nicht direkt über das Repository kommunizieren.
class DetailPetScreen extends StatelessWidget {
  final Pet pet;

  /// Wir definieren hier einen zusätzlichen
  /// Testing Parameter, damit wir im Test
  /// den Cubit mocken können. Dieser Parameter
  /// ist dank @visibleForTesting nur innerhalb des test-Ordners
  /// sichtbar.
  @visibleForTesting
  final ManagePetsSimpleCubit? managePetsSimpleCubit;

  const DetailPetScreen({
    super.key,
    required this.pet,
    this.managePetsSimpleCubit,
  });

  @override
  Widget build(BuildContext context) {
    /// Wenn der managePetsSimpleCubit nicht null ist, dann können wir den
    /// normalen BlocProvider verwenden, der in der main.dart definiert wurde
    /// und per BlocPorvider.value übergeben.
    /// Wenn er null ist, dann verwenden wir BlocProvider.value mit
    /// dem frisch übergebenen ManagePetsSimpleCubit, damit wir den Cubit mocken können.
    return managePetsSimpleCubit == null
        ? BlocProvider.value(
            value: context.read<ManagePetsSimpleCubit>(),
            child: _DetailPetView(pet: pet),
          )
        : BlocProvider.value(
            value: managePetsSimpleCubit!,
            child: _DetailPetView(pet: pet),
          );
  }
}

class _DetailPetView extends StatefulWidget {
  final Pet pet;

  const _DetailPetView({
    required this.pet,
  });

  @override
  State<_DetailPetView> createState() => _DetailPetViewState();
}

class _DetailPetViewState extends State<_DetailPetView> {
  late Pet localPet;

  @override
  void initState() {
    super.initState();
    localPet = widget.pet;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManagePetsSimpleCubit, ManagePetsSimpleState>(
      listener: (context, state) {
        if (state.status == ManagePetsStatus.deleteSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Kuscheltier erfolgreich gelöscht."),
            ),
          );
        } else if (state.status == ManagePetsStatus.deleteError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Beim Löschen des Kuscheltiers ist etwas schief gelaufen.",
              ),
            ),
          );
        } else if (state.status == ManagePetsStatus.updateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Kuscheltier erfolgreich aktualisiert."),
            ),
          );
        } else if (state.status == ManagePetsStatus.updateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Beim Aktualisieren des Kuscheltiers ist etwas schief gelaufen.",
              ),
            ),
          );
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamed(context, "/home");
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pushNamed(context, "/home"),
            ),
            title: Text(widget.pet.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _onEditPet(context, widget.pet),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _onDeletePet(context, widget.pet.id),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    _buildImage(widget.pet.species),
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
                        infoText: widget.pet.name,
                      ),
                      _InfoCard(
                        labelText: "Alter:",
                        infoText: "${widget.pet.age} Jahre",
                      ),
                      _InfoCard(
                        labelText: "Größe & Gewicht:",
                        infoText:
                            "${widget.pet.height} cm / ${widget.pet.weight} Gramm",
                      ),
                      _InfoCard(
                        labelText: "Geschlecht:",
                        infoText: widget.pet.isFemale ? "Weiblich" : "Männlich",
                      ),
                      _InfoCard(
                        labelText: "Spezies:",
                        infoText: widget.pet.species == Species.dog
                            ? "Hund"
                            : widget.pet.species == Species.bird
                                ? "Vogel"
                                : widget.pet.species == Species.cat
                                    ? "Katze"
                                    : "Fisch",
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        onPressed: () =>
                            InheritedAdoptionBag.of(context).addPet(),
                        label: 'Adoptieren',
                      ),
                    ],
                  ),
                ),
              ],
            ),
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

  void _onDeletePet(BuildContext context, String id) {
    try {
      context.read<ManagePetsSimpleCubit>().deletePet(id);
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

  Future<void> _onEditPet(BuildContext context, Pet petToUpdate) async {
    // Wir rufen den EditPetScreen auf, übergeben das aktuelle Pet-Objekt
    // und erwarten ein aktualisiertes Pet-Objekt zurück
    final updatedPet = await Navigator.push<Pet?>(
      context,
      MaterialPageRoute(
        builder: (context) => EditPetScreen(pet: petToUpdate),
      ),
    );

    // Wenn das aktualisierte Pet-Objekt nicht null ist,
    // aktualisieren wir das Pet-Objekt im ManagePetsSimpleCubit
    if (updatedPet != null && context.mounted) {
      localPet = updatedPet;
      context.read<ManagePetsSimpleCubit>().updatePet(updatedPet);
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
