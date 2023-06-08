import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/screens/detail_pet_screen.dart';

void main() {
  late Pet tPet;

  setUp(() {
    tPet = const Pet(
      name: 'Test Pet',
      species: Species.cat,
      age: 2,
      weight: 5.0,
      height: 10.0,
      isFemale: true,
      owner: null,
      id: '1',
    );
  });

  testWidgets('DetailPetScreen: all states', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DetailPetScreen(
          pet: tPet,
        ),
      ),
    );

    expect(find.byType(WillPopScope), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(IconButton), findsNWidgets(3));
    expect(find.byType(Positioned), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // text
    expect(find.text("Adoptier mich!"), findsOneWidget);
    expect(find.text("Name des Kuscheltiers:"), findsOneWidget);
    expect(find.text("Alter:"), findsOneWidget);
    expect(find.text("Größe & Gewicht:"), findsOneWidget);
    expect(find.text("Geschlecht:"), findsOneWidget);
    expect(find.text("Spezies:"), findsOneWidget);
    expect(find.text("Adoptieren"), findsOneWidget);

    // pet data
    expect(find.text("Test Pet"), findsNWidgets(2));
    expect(find.text("Katze"), findsOneWidget);
    expect(find.text("2 Jahre"), findsOneWidget);
    expect(find.text("10.0 cm / 5.0 Gramm"), findsOneWidget);
    expect(find.text("Weiblich"), findsOneWidget);
  });
}
