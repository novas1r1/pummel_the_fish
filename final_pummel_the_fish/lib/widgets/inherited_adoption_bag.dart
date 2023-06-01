import "package:flutter/material.dart";

class InheritedAdoptionBag extends InheritedWidget {
  final int petCount;
  final VoidCallback addPet;

  const InheritedAdoptionBag({
    super.key,
    required this.petCount,
    required super.child,
    required this.addPet,
  });

  @override
  bool updateShouldNotify(InheritedAdoptionBag oldWidget) => true;

  static InheritedAdoptionBag of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedAdoptionBag>()!;
  }
}
