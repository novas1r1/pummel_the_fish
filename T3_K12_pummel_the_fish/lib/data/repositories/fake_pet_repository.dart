import 'package:collection/collection.dart';
import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/data/repositories/pet_repository.dart';

class FakePetRepository implements PetRepository {
  final List<Pet> _pets = [
    const Pet(
      id: "1",
      name: "Pummel",
      species: Species.fish,
      weight: 200.0,
      height: 20.0,
      age: 3,
    ),
    const Pet(
      id: "2",
      name: "Bruno",
      species: Species.dog,
      weight: 320.0,
      height: 60.0,
      age: 4,
      isFemale: false,
    ),
    const Pet(
      id: "3",
      name: "Leonie",
      species: Species.cat,
      weight: 400.0,
      height: 45.0,
      age: 6,
    ),
    const Pet(
      id: "4",
      name: "Harribart",
      species: Species.bird,
      weight: 220.0,
      height: 10.0,
      age: 1,
      isFemale: false,
    )
  ];

  FakePetRepository();

  // Gibt das Pet-Objekt mit der gewünschten id zurück
  // Wenn es das Pet-Objekt nicht gibt, wird null zurückgegeben
  @override
  Pet? getPetById(String id) {
    return _pets.firstWhereOrNull(
      (petElement) => petElement.id == id,
    );
  }

  // Gibt eine sortierte Liste an Pet-Objekten zurück
  @override
  List<Pet> getAllPets() {
    _sortPetsByName();
    return _pets;
  }

  // Fügt ein Pet-Objekt zur Liste hinzu
  @override
  void addPet(Pet pet) {
    _pets.add(pet);
  }

  // Löscht ein Pet-Objekt mit der gewünschten id aus der Liste
  @override
  void deletePetById(String id) {
    _pets.removeWhere((pet) => pet.id == id);
  }

  // Aktualisiert ein Objekt in der Liste, falls vorhanden
  @override
  void updatePet(Pet pet) {
    final index = _pets.indexWhere(
      (element) => element.id == pet.id,
    );
    if (index != -1) {
      _pets[index] = pet;
    }
  }

  // Sortiert die Pet-Liste nach Namen
  void _sortPetsByName() {
    _pets.sort(
      (pet1, pet2) => pet1.name.compareTo(pet2.name),
    );
  }

  /// Diese Methode wird verwendet, um die Daten aus dem Mock-Server mit einem
  /// simulierten Delay zu laden.
  Future<List<Pet>> getAllPetsFromMockServer() async {
    await Future.delayed(const Duration(seconds: 3));
    return _pets;
  }

  /// Mit dieser Methode, können Sie einen coolen Namen für Ihr Kuscheltier
  /// generieren lassen.
  static String makeACoolPetName(
    String nameILike, {
    String? titleOfNobility,
    required Species species,
    String coolAdjective = "gangsta",
  }) {
    titleOfNobility = titleOfNobility ?? "";
    String coolName =
        "$titleOfNobility $nameILike the $coolAdjective ${species.name}";
    return coolName;
  }
}
