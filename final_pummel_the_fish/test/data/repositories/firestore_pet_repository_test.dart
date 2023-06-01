import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/data/repositories/firestore_pet_repository.dart';

void main() {
  late FirestorePetRepository petRepository;
  late FakeFirebaseFirestore mockFirestore;

  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    petRepository = FirestorePetRepository(firestore: mockFirestore);
  });

  test('getPetsStream returns a stream of pets', () async {
    final pets = [
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

    // Add the pets to the repository
    for (final pet in pets) {
      await petRepository.addPet(pet, testDocId: pet.id);
    }

    // Get the stream of pets
    final petStream = petRepository.getPetsStream();

    // Listen to the stream and collect the emitted pets
    final emittedPets = await petStream.first;

    expect(emittedPets, containsAll(pets));
  });

  test('getAllPets()', () async {
    const pet = Pet(
      name: 'Test Pet',
      species: Species.cat,
      age: 2,
      weight: 5.0,
      height: 10.0,
      isFemale: true,
      owner: null,
      id: '1',
    );

    final pet2 = pet.copyWith(id: '2');

    await mockFirestore.collection('pets').add(pet.toMap());
    await mockFirestore.collection('pets').add(pet2.toMap());

    final pets = await petRepository.getAllPets();

    expect(pets, isA<List<Pet>>());
    expect(pets.length, 2);
  });

  test('addPet()', () async {
    const pet = Pet(
      name: 'Test Pet',
      species: Species.cat,
      age: 2,
      weight: 5.0,
      height: 10.0,
      isFemale: true,
      owner: null,
      id: 'xKQzJnetXmkOMYtQgKNm',
    );

    await petRepository.addPet(pet, testDocId: 'xKQzJnetXmkOMYtQgKNm');

    final pets = await petRepository.getAllPets();

    expect(pets, contains(pet));
  });

  /*test('updatePet updates a pet in the repository', () async {
    const pet = Pet(
      id: '1hdajhjkwad',
      name: 'Test Pet',
      species: Species.cat,
      age: 2,
      weight: 5.0,
      height: 10.0,
      isFemale: true,
      owner: null,
    );

    await petRepository.addPet(pet, testDocId: pet.id);

    final updatedPet = pet.copyWith(name: 'Updated Test Pet');

    await petRepository.updatePet(updatedPet, testDocId: pet.id);

    final pets = await petRepository.getAllPets();

    expect(pets, contains(updatedPet));
  });*/

  /*test('getPetById returns the correct pet', () async {
    const pet = Pet(
      id: '1',
      name: 'Test Pet',
      species: Species.cat,
      age: 2,
      weight: 5.0,
      height: 10.0,
      isFemale: true,
      owner: null,
    );

    await petRepository.addPet(pet, testDocId: pet.id);

    final retrievedPet = await petRepository.getPetById(pet.id);

    expect(retrievedPet, equals(pet));
  });*/

  /*test('deletePetById deletes a pet from the repository', () async {
    const pet = Pet(
      id: '1',
      name: 'Test Pet',
      species: Species.cat,
      age: 2,
      weight: 5.0,
      height: 10.0,
      isFemale: true,
      owner: null,
    );

    await petRepository.addPet(pet, testDocId: pet.id);

    await petRepository.deletePetById(pet.id);

    final pets = await petRepository.getAllPets();

    expect(pets, isNot(contains(pet)));
  });*/
}
