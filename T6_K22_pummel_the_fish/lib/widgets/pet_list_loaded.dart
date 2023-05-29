import "package:flutter/material.dart";
import "package:pummel_the_fish/data/models/pet.dart";
import "package:pummel_the_fish/screens/detail_pet_screen.dart";
import "package:pummel_the_fish/theme/custom_colors.dart";

class PetListLoaded extends StatelessWidget {
  final List<Pet> pets;

  const PetListLoaded({
    super.key,
    required this.pets,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pets.length,
      itemBuilder: (context, index) {
        return ListTile(
          key: ValueKey("pet-${pets[index].id}"),
          leading: Icon(
            pets[index].isFemale ? Icons.female : Icons.male,
            color: CustomColors.orange,
            size: 40,
          ),
          title: Text(
            pets[index].name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            "Alter: ${pets[index].age} Jahre",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: const Icon(
            Icons.chevron_right_rounded,
            color: CustomColors.blueDark,
          ),
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPetScreen(
                  pet: pets[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
