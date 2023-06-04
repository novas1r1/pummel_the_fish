import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";
import "package:pummel_the_fish/data/models/pet.dart";
import "package:pummel_the_fish/data/repositories/firestore_pet_repository.dart";
import "package:pummel_the_fish/logic/cubits/manage_pets_simple_cubit.dart";

// T6K21: Testing, ManagePetsCubit Variante 2 (Tests im Buch beschrieben)
class MockFirestorePetRepository extends Mock
    implements FirestorePetRepository {}

void main() {
  late ManagePetsSimpleCubit cubit;
  late MockFirestorePetRepository mockFirestorePetRepository;
  late List<Pet> tPetList;

  setUp(() {
    mockFirestorePetRepository = MockFirestorePetRepository();
    cubit = ManagePetsSimpleCubit(mockFirestorePetRepository);

    tPetList = [
      const Pet(
        id: "1",
        name: "Kira",
        species: Species.dog,
        age: 10,
        weight: 250.0,
        height: 20.0,
      ),
      const Pet(
        id: "2",
        name: "Space",
        species: Species.fish,
        age: 3,
        weight: 10.0,
        height: 10.0,
      ),
    ];
  });
  group("getAllPets()", () {
    blocTest<ManagePetsSimpleCubit, ManagePetsSimpleState>(
      "emits [ManagePetsStatus.loading, ManagePetsStatus.success] when getAllPets() is called successfully.",
      setUp: () {
        when(() => mockFirestorePetRepository.getAllPets())
            .thenAnswer((_) async => tPetList);
      },
      build: () => cubit,
      act: (cubit) => cubit.getAllPets(),
      expect: () => <ManagePetsSimpleState>[
        const ManagePetsSimpleState(
          status: ManagePetsStatus.loading,
        ),
        ManagePetsSimpleState(
          status: ManagePetsStatus.success,
          pets: tPetList,
        ),
      ],
      verify: (_) =>
          verify(() => mockFirestorePetRepository.getAllPets()).called(1),
    );

    blocTest<ManagePetsSimpleCubit, ManagePetsSimpleState>(
      "emits [ManagePetsStatus.loading, ManagePetsStatus.error] when getAllPets() throws an Exception",
      setUp: () {
        when(() => mockFirestorePetRepository.getAllPets())
            .thenThrow(Exception());
      },
      build: () => cubit,
      act: (cubit) => cubit.getAllPets(),
      expect: () => <ManagePetsSimpleState>[
        const ManagePetsSimpleState(status: ManagePetsStatus.loading),
        const ManagePetsSimpleState(status: ManagePetsStatus.error),
      ],
      verify: (_) =>
          verify(() => mockFirestorePetRepository.getAllPets()).called(1),
    );
  });
}
