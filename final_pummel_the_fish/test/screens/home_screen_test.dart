import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/logic/cubits/manage_pets_simple_cubit.dart';
import 'package:pummel_the_fish/screens/home_screen.dart';
import 'package:pummel_the_fish/widgets/adoption_bag.dart';
import 'package:pummel_the_fish/widgets/adoption_bag_wrapper.dart';
import 'package:pummel_the_fish/widgets/pet_list_error.dart';
import 'package:pummel_the_fish/widgets/pet_list_loaded.dart';
import 'package:pummel_the_fish/widgets/pet_list_loading.dart';

class MockManagePetsSimpleCubit extends MockCubit<ManagePetsSimpleState>
    implements ManagePetsSimpleCubit {}

void main() {
  late MockManagePetsSimpleCubit mockCubit;

  setUp(() {
    mockCubit = MockManagePetsSimpleCubit();
  });

  testWidgets('HomeScreen: all states', (tester) async {
    when(() => mockCubit.state).thenReturn(const ManagePetsSimpleState());

    await tester.pumpWidget(
      AdoptionBagWrapper(
        child: MaterialApp(
          home: HomeScreen(
            managePetsSimpleCubit: mockCubit,
          ),
        ),
      ),
    );

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(AdoptionBag), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('HomeScreen: initial state', (tester) async {
    when(() => mockCubit.state).thenReturn(const ManagePetsSimpleState());

    await tester.pumpWidget(
      AdoptionBagWrapper(
        child: MaterialApp(
          home: HomeScreen(
            managePetsSimpleCubit: mockCubit,
          ),
        ),
      ),
    );

    expect(find.byType(PetListError), findsOneWidget);

    // golden test
    await expectLater(
      find.byType(AdoptionBagWrapper),
      matchesGoldenFile("home_screen_initial.png"),
    );
  });

  testWidgets('HomeScreen: loading state', (tester) async {
    when(() => mockCubit.state).thenReturn(
        const ManagePetsSimpleState(status: ManagePetsStatus.loading));

    await tester.pumpWidget(
      AdoptionBagWrapper(
        child: MaterialApp(
          home: HomeScreen(
            managePetsSimpleCubit: mockCubit,
          ),
        ),
      ),
    );

    expect(find.byType(PetListLoading), findsOneWidget);

    // golden test
    await expectLater(
      find.byType(AdoptionBagWrapper),
      matchesGoldenFile("home_screen_loading.png"),
    );
  });

  testWidgets('HomeScreen: success state', (tester) async {
    final tPets = [
      const Pet(
        name: 'Test Pet 1',
        species: Species.cat,
        age: 2,
        weight: 5.0,
        height: 10.0,
        isFemale: true,
        owner: null,
        id: '1',
      ),
      const Pet(
        name: 'Test Pet 2',
        species: Species.dog,
        age: 3,
        weight: 10.0,
        height: 20.0,
        isFemale: false,
        owner: null,
        id: '2',
      ),
    ];

    when(() => mockCubit.state).thenReturn(ManagePetsSimpleState(
      status: ManagePetsStatus.success,
      pets: tPets,
    ));

    await tester.pumpWidget(
      AdoptionBagWrapper(
        child: MaterialApp(
          home: HomeScreen(
            managePetsSimpleCubit: mockCubit,
          ),
        ),
      ),
    );

    expect(find.byType(PetListLoaded), findsOneWidget);

    // golden test
    await expectLater(
      find.byType(AdoptionBagWrapper),
      matchesGoldenFile("home_screen_success.png"),
    );
  });

  testWidgets('HomeScreen: error state', (tester) async {
    when(() => mockCubit.state).thenReturn(const ManagePetsSimpleState(
      status: ManagePetsStatus.error,
    ));

    await tester.pumpWidget(
      AdoptionBagWrapper(
        child: MaterialApp(
          home: HomeScreen(
            managePetsSimpleCubit: mockCubit,
          ),
        ),
      ),
    );

    expect(find.byType(PetListError), findsOneWidget);

    // golden test
    await expectLater(
      find.byType(AdoptionBagWrapper),
      matchesGoldenFile("home_screen_error.png"),
    );
  });
}
