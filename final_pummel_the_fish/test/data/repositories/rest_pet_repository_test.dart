import "package:flutter_test/flutter_test.dart";
import "package:http/http.dart" as http;
import "package:mocktail/mocktail.dart";
import "package:pummel_the_fish/data/models/pet.dart";
import "package:pummel_the_fish/data/repositories/rest_pet_repository.dart";

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late RestPetRepository restPetRepository;

  late String tPetsJson;
  late List<Pet> tPetList;

  setUp(() {
    mockHttpClient = MockHttpClient();
    restPetRepository = RestPetRepository(
      httpClient: mockHttpClient,
    );

    tPetsJson = '''[
    {
    "id": "1",
    "name": "Kira",
    "species": 0,
    "weight": 250.0,
    "height": 20.0,
    "age_in_years": 10,
    "is_female": true
    },
    {
    "id": "2",
    "name": "Harribart",
    "species": 3,
    "weight": 400.0,
    "height": 40.0,
    "age_in_years": 3,
    "is_female": false
    }
    ]''';

    tPetList = [
      const Pet(
        id: "1",
        name: "Kira",
        species: Species.dog,
        age: 10,
        weight: 250.0,
        height: 20.0,
        isFemale: true,
        owner: null,
      ),
      const Pet(
        id: "2",
        name: "Harribart",
        species: Species.fish,
        age: 3,
        weight: 400.0,
        height: 40.0,
        isFemale: false,
        owner: null,
      )
    ];
  });
  group("getAllPets()", () {
    test("should return a List<Pet> successfully", () async {
      when(
        () => mockHttpClient.get(Uri.parse("$baseUrl/pets")),
      ).thenAnswer(
        (_) async => http.Response(tPetsJson, 200),
      );

      final result = await restPetRepository.getAllPets();
      expect(result, tPetList);

      verify(
        () => mockHttpClient.get(Uri.parse("$baseUrl/pets")),
      ).called(1);
    });
    test('should throw an Exception when something went wrong', () async {
      when(
        () => mockHttpClient.get(Uri.parse('$baseUrl/pets')),
      ).thenAnswer(
        (_) async => http.Response('Error', 404),
      );

      expect(
        () => restPetRepository.getAllPets(),
        throwsA(isInstanceOf<Exception>()),
      );

      verify(
        () => mockHttpClient.get(Uri.parse('$baseUrl/pets')),
      ).called(1);
    });
  });

  group("addPet()", () {
    test('should add a pet successfully', () async {
      const pet = Pet(
        id: '3',
        name: 'Fluffy',
        species: Species.cat,
        age: 2,
        weight: 5.0,
        height: 10.0,
        isFemale: true,
        owner: null,
      );

      when(
        () => mockHttpClient.post(
          Uri.parse('$baseUrl/pets'),
          body: pet.toJson(),
          headers: {
            "Content-Type": "application/json",
          },
        ),
      ).thenAnswer(
        (_) async => http.Response('', 201),
      );

      await restPetRepository.addPet(pet);

      verify(
        () => mockHttpClient.post(
          Uri.parse('$baseUrl/pets'),
          body: pet.toJson(),
          headers: {
            "Content-Type": "application/json",
          },
        ),
      ).called(1);
    });

    test('should throw an Exception when something went wrong', () async {
      const pet = Pet(
        id: '3',
        name: 'Fluffy',
        species: Species.cat,
        age: 2,
        weight: 5.0,
        height: 10.0,
        isFemale: true,
        owner: null,
      );

      when(
        () => mockHttpClient.post(
          Uri.parse('$baseUrl/pets'),
          body: pet.toJson(),
          headers: {
            "Content-Type": "application/json",
          },
        ),
      ).thenAnswer(
        (_) async => http.Response('Error', 500),
      );

      expect(
        () => restPetRepository.addPet(pet),
        throwsA(isInstanceOf<Exception>()),
      );

      verify(
        () => mockHttpClient.post(
          Uri.parse('$baseUrl/pets'),
          body: pet.toJson(),
          headers: {
            "Content-Type": "application/json",
          },
        ),
      ).called(1);
    });
  });
  group("updatePet()", () {
    test('should update a pet successfully', () async {
      const pet = Pet(
        id: '1',
        name: 'Kira',
        species: Species.dog,
        age: 11,
        weight: 260.0,
        height: 21.0,
        isFemale: true,
        owner: null,
      );

      when(
        () => mockHttpClient.put(
          Uri.parse('$baseUrl/pets/${pet.id}'),
          body: pet.toJson(),
          headers: {
            "Content-Type": "application/json",
          },
        ),
      ).thenAnswer(
        (_) async => http.Response('', 200),
      );

      await restPetRepository.updatePet(pet);

      verify(
        () => mockHttpClient.put(
          Uri.parse('$baseUrl/pets/${pet.id}'),
          body: pet.toJson(),
          headers: {
            "Content-Type": "application/json",
          },
        ),
      ).called(1);
    });
    test('should throw an Exception when something went wrong', () async {
      const pet = Pet(
        id: '1',
        name: 'Kira',
        species: Species.dog,
        age: 11,
        weight: 260.0,
        height: 21.0,
        isFemale: true,
        owner: null,
      );

      when(
        () => mockHttpClient.put(
          Uri.parse('$baseUrl/pets/${pet.id}'),
          body: pet.toJson(),
          headers: {
            "Content-Type": "application/json",
          },
        ),
      ).thenAnswer(
        (_) async => http.Response('Error', 500),
      );

      expect(
        () => restPetRepository.updatePet(pet),
        throwsA(isInstanceOf<Exception>()),
      );

      verify(
        () => mockHttpClient.put(
          Uri.parse('$baseUrl/pets/${pet.id}'),
          body: pet.toJson(),
          headers: {
            "Content-Type": "application/json",
          },
        ),
      ).called(1);
    });
  });
  group("deletePetById()", () {
    test('should delete a pet successfully', () async {
      const petId = '1';

      when(
        () => mockHttpClient.delete(Uri.parse('$baseUrl/pets/$petId')),
      ).thenAnswer(
        (_) async => http.Response('', 204),
      );

      await restPetRepository.deletePetById(petId);

      verify(
        () => mockHttpClient.delete(Uri.parse('$baseUrl/pets/$petId')),
      ).called(1);
    });

    test('should throw an Exception when something went wrong', () async {
      const petId = '1';

      when(
        () => mockHttpClient.delete(Uri.parse('$baseUrl/pets/$petId')),
      ).thenAnswer(
        (_) async => http.Response('Error', 500),
      );

      expect(
        () => restPetRepository.deletePetById(petId),
        throwsA(isInstanceOf<Exception>()),
      );

      verify(
        () => mockHttpClient.delete(Uri.parse('$baseUrl/pets/$petId')),
      ).called(1);
    });
  });
  group("getPetById()", () {
    test('should return a Pet successfully', () async {
      const petId = '1';
      final tPet = tPetList.first;

      when(
        () => mockHttpClient.get(Uri.parse('$baseUrl/pets/$petId')),
      ).thenAnswer(
        (_) async => http.Response(tPet.toJson(), 200),
      );

      final result = await restPetRepository.getPetById(petId);
      expect(result, tPet);

      verify(
        () => mockHttpClient.get(Uri.parse('$baseUrl/pets/$petId')),
      ).called(1);
    });

    test('should throw an Exception when something went wrong', () async {
      const petId = '1';

      when(
        () => mockHttpClient.get(Uri.parse('$baseUrl/pets/$petId')),
      ).thenAnswer(
        (_) async => http.Response('Error', 500),
      );

      expect(
        () => restPetRepository.getPetById(petId),
        throwsA(isInstanceOf<Exception>()),
      );

      verify(
        () => mockHttpClient.get(Uri.parse('$baseUrl/pets/$petId')),
      ).called(1);
    });
  });
}
