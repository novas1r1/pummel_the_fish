import "package:flutter/material.dart";
import "package:pummel_the_fish/theme/custom_colors.dart";

class AdoptionBag extends StatelessWidget {
  final int petCount;

  const AdoptionBag({
    super.key,
    required this.petCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: CustomColors.orange,
        child: Text(
          "$petCount",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
