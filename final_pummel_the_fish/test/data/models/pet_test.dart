import 'package:flutter_test/flutter_test.dart';
import 'package:pummel_the_fish/data/models/owner.dart';
import 'package:pummel_the_fish/data/models/pet.dart';

void main() {
  late String tPetJsonString;
  late String tPetJsonStringSpecial;

  setUp(() {
    tPetJsonString =
        '{"id":"123","name":"Buddy","species":1,"age_in_years":5,"weight":10.5,"height":0.8,"is_female":false,"owner":{"id":"456","name":"John Doe"}}';

    tPetJsonStringSpecial =
        '{"id":"123","name":"Buddy","species":2,"age_in_years":6,"weight":10.0,"height":0.0,"is_female":true,"owner":{"id":"456","name":"John Doe"}}';
  });

  group('doubles with x.y', () {
    test('fromJson(): Pet object can be created from JSON', () {
      // Act
      final pet = Pet.fromJson(tPetJsonString);

      // Assert
      expect(pet.id, "123");
      expect(pet.name, "Buddy");
      expect(pet.species, Species.cat);
      expect(pet.age, 5);
      expect(pet.weight, 10.5);
      expect(pet.height, 0.8);
      expect(pet.isFemale, false);
      expect(pet.owner!.id, "456");
      expect(pet.owner!.name, "John Doe");
    });

    test('Pet object can be converted to JSON', () {
      // Arrange
      const owner = Owner(id: "456", name: "John Doe");
      const pet = Pet(
        id: "123",
        name: "Buddy",
        species: Species.cat,
        age: 5,
        weight: 10.5,
        height: 0.8,
        isFemale: false,
        owner: owner,
      );

      // Act
      final json = pet.toJson();

      // Assert
      expect(json, tPetJsonString);
    });

    test('Pet object can be converted to map', () {
      // Arrange
      const owner = Owner(id: "456", name: "John Doe");
      const pet = Pet(
        id: "123",
        name: "Buddy",
        species: Species.cat,
        age: 5,
        weight: 10.5,
        height: 0.8,
        isFemale: false,
        owner: owner,
      );

      // Act
      final map = pet.toMap();

      // Assert
      final expectedMap = {
        "id": "123",
        "name": "Buddy",
        "species": 1,
        "age_in_years": 5,
        "weight": 10.5,
        "height": 0.8,
        "is_female": false,
        "owner": {"id": "456", "name": "John Doe"}
      };

      expect(map, expectedMap);
    });
  });

  group('doubles with x.0 or x', () {
    test('Pet object can be created from JSON with special double', () {
      // Act
      final pet = Pet.fromJson(tPetJsonStringSpecial);

      // Assert
      expect(pet.id, "123");
      expect(pet.name, "Buddy");
      expect(pet.species, Species.bird);
      expect(pet.age, 6);
      expect(pet.weight, 10.0);
      expect(pet.height, 0.0);
      expect(pet.isFemale, true);
      expect(pet.owner!.id, "456");
      expect(pet.owner!.name, "John Doe");
    });

    test('Pet object can be converted to JSON', () {
      // Arrange
      const owner = Owner(id: "456", name: "John Doe");
      const pet = Pet(
        id: "123",
        name: "Buddy",
        species: Species.bird,
        age: 6,
        weight: 10,
        height: 0,
        isFemale: true,
        owner: owner,
      );

      // Act
      final json = pet.toJson();

      // Assert
      expect(json, tPetJsonStringSpecial);
    });

    test('Pet object can be converted to map', () {
      // Arrange
      const owner = Owner(id: "456", name: "John Doe");
      const pet = Pet(
        id: "123",
        name: "Buddy",
        species: Species.bird,
        age: 6,
        weight: 10.0,
        height: 0.0,
        isFemale: true,
        owner: owner,
      );

      // Act
      final map = pet.toMap();

      // Assert
      final expectedSpecialMap = {
        "id": "123",
        "name": "Buddy",
        "species": 2,
        "age_in_years": 6,
        "weight": 10.0,
        "height": 0.0,
        "is_female": true,
        "owner": {"id": "456", "name": "John Doe"}
      };

      expect(map, expectedSpecialMap);
    });
  });

  test('Pet object can be copied with all properties new', () {
    // Arrange
    const owner = Owner(id: "456", name: "John Doe");
    const pet = Pet(
      id: "123",
      name: "Buddy",
      species: Species.cat,
      age: 5,
      weight: 10.5,
      height: 0.8,
      isFemale: false,
      owner: owner,
    );

    // Act
    const newOwner = Owner(id: "456", name: "John Doe");
    final copiedPet = pet.copyWith(
      id: "456",
      name: "Charlie",
      age: 6,
      weight: 9.5,
      height: 0.9,
      isFemale: true,
      species: Species.bird,
      owner: newOwner,
    );

    // Assert
    expect(copiedPet.id, "456");
    expect(copiedPet.name, "Charlie");
    expect(copiedPet.species, Species.bird);
    expect(copiedPet.age, 6);
    expect(copiedPet.weight, 9.5);
    expect(copiedPet.height, 0.9);
    expect(copiedPet.isFemale, true);
    expect(copiedPet.owner, newOwner);
  });

  test('Pet object can be copied with one property new', () {
    // Arrange
    const owner = Owner(id: "456", name: "John Doe");
    const pet = Pet(
      id: "123",
      name: "Buddy",
      species: Species.cat,
      age: 5,
      weight: 10.5,
      height: 0.8,
      isFemale: false,
      owner: owner,
    );

    // Act
    final copiedPet = pet.copyWith();

    // Assert
    expect(copiedPet.id, pet.id);
    expect(copiedPet.name, pet.name);
    expect(copiedPet.species, pet.species);
    expect(copiedPet.age, pet.age);
    expect(copiedPet.weight, pet.weight);
    expect(copiedPet.height, pet.height);
    expect(copiedPet.isFemale, pet.isFemale);
    expect(copiedPet.owner, pet.owner);
  });

  test('Pet objects with same properties are considered equal', () {
    // Arrange
    const owner = Owner(id: "456", name: "John Doe");
    const pet1 = Pet(
      id: "123",
      name: "Buddy",
      species: Species.cat,
      age: 5,
      weight: 10.5,
      height: 0.8,
      isFemale: false,
      owner: owner,
    );
    const pet2 = Pet(
      id: "123",
      name: "Buddy",
      species: Species.cat,
      age: 5,
      weight: 10.5,
      height: 0.8,
      isFemale: false,
      owner: owner,
    );

    // Act
    final areEqual = pet1 == pet2;

    // Assert
    expect(areEqual, true);
  });

  test('Pet objects with different properties are not considered equal', () {
    // Arrange
    const owner1 = Owner(id: "456", name: "John Doe");
    const owner2 = Owner(id: "789", name: "Jane Smith");

    const pet1 = Pet(
      id: "123",
      name: "Buddy",
      species: Species.cat,
      age: 5,
      weight: 10.5,
      height: 0.8,
      isFemale: false,
      owner: owner1,
    );
    const pet2 = Pet(
      id: "123",
      name: "Charlie",
      species: Species.cat,
      age: 6,
      weight: 9.5,
      height: 0.9,
      isFemale: true,
      owner: owner2,
    );

    // Act
    final areEqual = pet1 == pet2;

    // Assert
    expect(areEqual, false);
  });
}
