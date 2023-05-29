import "package:flutter_test/flutter_test.dart";
import "package:http/http.dart" as http;
import "package:mocktail/mocktail.dart";
import "package:pummel_the_fish/data/models/pet.dart";
import "package:pummel_the_fish/data/repositories/rest_pet_repository.dart";

// T6K21: Testing, HashCode ergänzen
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
    test("should throw an Exception when something went wrong", () {});
  });

  group("addPet()", () {});
  group("updatePet()", () {});
  group("deletePetById()", () {});
  group("getPetById()", () {});
}
