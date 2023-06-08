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
      id: '1',
    );

    await petRepository.addPet(pet, testDocId: '1');

    final pets = await petRepository.getAllPets();

    expect(pets, contains(pet));
  });

  test('addPet() without test document (coverage only)', () async {
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

    await petRepository.addPet(pet);
  });

  test('updatePet updates a pet in the repository', () async {
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
  });

  test('getPetById returns the correct pet', () async {
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
  });

  test('deletePetById deletes a pet from the repository', () async {
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
  });

  test('getPetBySpecies returns the correct pets', () async {
    const cat = Pet(
      id: '1',
      name: 'Test Pet',
      species: Species.cat,
      age: 2,
      weight: 5.0,
      height: 10.0,
      isFemale: true,
      owner: null,
    );

    const dog = Pet(
      id: '2',
      name: 'Test Pet',
      species: Species.dog,
      age: 2,
      weight: 5.0,
      height: 10.0,
      isFemale: true,
      owner: null,
    );

    const cat2 = Pet(
      id: '3',
      name: 'Test Pet',
      species: Species.cat,
      age: 2,
      weight: 5.0,
      height: 10.0,
      isFemale: true,
      owner: null,
    );

    await petRepository.addPet(cat, testDocId: cat.id);
    await petRepository.addPet(dog, testDocId: dog.id);
    await petRepository.addPet(cat2, testDocId: cat2.id);

    final result = await petRepository.getPetBySpecies(Species.cat);

    expect(result.length, 2);
  });

  test('getPetsOrderedByHeight returns the pets in correct order', () async {
    const pet1 = Pet(
      id: '1',
      name: 'Test Pet',
      species: Species.cat,
      age: 2,
      weight: 5.0,
      height: 3,
      isFemale: true,
      owner: null,
    );

    const pet2 = Pet(
      id: '2',
      name: 'Test Pet',
      species: Species.dog,
      age: 2,
      weight: 5.0,
      height: 1,
      isFemale: true,
      owner: null,
    );

    const pet3 = Pet(
      id: '3',
      name: 'Test Pet',
      species: Species.cat,
      age: 2,
      weight: 5.0,
      height: 2,
      isFemale: true,
      owner: null,
    );

    await petRepository.addPet(pet1, testDocId: pet1.id);
    await petRepository.addPet(pet2, testDocId: pet2.id);
    await petRepository.addPet(pet3, testDocId: pet3.id);

    final result = await petRepository.getPetsOrderedByHeight();

    expect(result.length, 3);
    expect(result[0], pet1);
    expect(result[1], pet3);
    expect(result[2], pet2);
  });
}
