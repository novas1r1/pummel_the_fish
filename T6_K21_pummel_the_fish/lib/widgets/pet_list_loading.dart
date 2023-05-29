import "package:flutter/material.dart";

class PetListLoading extends StatelessWidget {
  const PetListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
