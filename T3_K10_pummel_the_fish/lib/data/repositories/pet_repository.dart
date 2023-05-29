import 'package:pummel_the_fish/data/models/pet.dart';

/// Diese abstrakte Klasse dient als Schablone
/// für das RestPetRepository, FakePetRepository und
/// FirebasePetRepository. Alle Methoden müssen beim
/// Verwenden dieser Schablone mit @override überschrieben werden
abstract class PetRepository {
  /// Gibt ein [Pet]-Objekt anhand seiner [id] zurück
  Pet? getPetById(String id);

  /// Gibt alle [Pet]-Objekte in Form einer Liste zurück
  List<Pet> getAllPets();

  /// Fügt ein [Pet]-Objekt hinzu
  void addPet(Pet pet);

  /// Löscht ein [Pet]-Objekt anhand seiner [id]
  void deletePetById(String id);

  /// Aktualisiert ein [Pet]-Objekt
  void updatePet(Pet pet);
}
