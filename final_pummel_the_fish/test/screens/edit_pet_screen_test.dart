import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/screens/edit_pet_screen.dart';
import 'package:pummel_the_fish/widgets/adoption_bag_wrapper.dart';

import '../logic/cubits/manage_pets_simple_cubit_test.dart';

void main() {
  late Pet tPet;
  late MockFirestorePetRepository mockFirestorePetRepository;

  setUp(() {
    mockFirestorePetRepository = MockFirestorePetRepository();

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

  testWidgets('EditPetScreen: all states', (tester) async {
    await tester.pumpWidget(
      AdoptionBagWrapper(
        child: MaterialApp(
          home: EditPetScreen(
            pet: tPet,
            firestorePetRepository: mockFirestorePetRepository,
          ),
        ),
      ),
    );

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(4));
    expect(find.byType(Form), findsOneWidget);

    // text
    expect(find.text("Neues Tier anlegen"), findsOneWidget);
    expect(find.text("Name"), findsOneWidget);
    expect(find.text("Alter (Jahre)"), findsOneWidget);
    expect(find.text("Höhe (cm)"), findsOneWidget);
    expect(find.text("Gewicht (Gramm)"), findsOneWidget);
    expect(find.text("Weiblich"), findsOneWidget);
    expect(find.text("Speichern"), findsOneWidget);

    // pet data
    expect(find.text("Test Pet"), findsOneWidget);
    expect(find.text("Katze"), findsOneWidget);
    expect(find.text("10.0"), findsOneWidget);
    expect(find.text("5.0"), findsOneWidget);

    // golden test
    await expectLater(
      find.byType(AdoptionBagWrapper),
      matchesGoldenFile("edit_pet_screen.png"),
    );
  });
}
