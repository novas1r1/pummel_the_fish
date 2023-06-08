import 'package:flutter_test/flutter_test.dart';
import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/logic/cubits/manage_pets_simple_cubit.dart';

void main() {
  late List<Pet> tPetList;

  setUp(() {
    tPetList = [
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
  });
  group('ManagePetsSimpleState', () {
    test(
        'copyWith method should create a new instance with the specified changes',
        () {
      const originalState = ManagePetsSimpleState(
        status: ManagePetsStatus.initial,
        pets: [],
        errorMessage: null,
      );

      final newState = originalState.copyWith(
        status: ManagePetsStatus.loading,
        pets: tPetList,
        errorMessage: 'An error occurred',
      );

      expect(newState.status, ManagePetsStatus.loading);
      expect(newState.pets.length, 2);
      expect(newState.pets, tPetList);
      expect(newState.errorMessage, 'An error occurred');
    });

    test('copyWith method should create a new instance with no changes', () {
      const originalState = ManagePetsSimpleState(
        status: ManagePetsStatus.initial,
        pets: [],
        errorMessage: null,
      );

      final newState = originalState.copyWith();

      expect(newState.status, ManagePetsStatus.initial);
      expect(newState.pets.length, 0);
      expect(newState.pets, []);
      expect(newState.errorMessage, null);
    });
  });
}
