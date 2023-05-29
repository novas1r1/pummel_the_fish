import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:pummel_the_fish/data/models/pet.dart";
import "package:pummel_the_fish/widgets/pet_list_loaded.dart";

void main() {
  late List<Pet> tPets;

  setUp(() {
    tPets = [
      const Pet(
        id: "1",
        name: "Kira",
        species: Species.dog,
        age: 10,
        weight: 250.0,
        height: 20.0,
        isFemale: true,
      ),
      const Pet(
        id: "2",
        name: "Harribart",
        species: Species.fish,
        age: 3,
        weight: 100.0,
        height: 10.0,
        isFemale: true,
      ),
    ];
  });

  testWidgets("should display all given Pets", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PetListLoaded(pets: tPets),
        ),
      ),
    );

    expect(find.text("Kira"), findsOneWidget);
    expect(find.text("Harribart"), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byIcon(Icons.female), findsNWidgets(2));
    expect(find.byKey(const ValueKey("pet-1")), findsOneWidget);

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile("pet_list_loaded.png"),
    );
  });
}
