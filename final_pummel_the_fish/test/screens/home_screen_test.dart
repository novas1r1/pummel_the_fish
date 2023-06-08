import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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
  });

  testWidgets('HomeScreen: success state', (tester) async {
    when(() => mockCubit.state).thenReturn(const ManagePetsSimpleState(
      status: ManagePetsStatus.success,
      pets: [],
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
  });
}
