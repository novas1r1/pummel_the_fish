import "dart:async";

import "package:pummel_the_fish/data/models/pet.dart";

/// Diese abstrakte Klasse dient als Schablone
/// für das RestPetRepository, FakePetRepository und
/// FirebasePetRepository. Alle Methoden müssen beim
/// Verwenden dieser Schablone mit @override überschrieben werden
abstract class PetRepository {
  /// Gibt ein [Pet]-Objekt anhand seiner [id] zurück
  /// Dabei kann es sowohl als [Future<Pet>], als auch als [Pet]-Objekt
  /// zurückgegeben werden.
  FutureOr<Pet?> getPetById(String id);

  /// Gibt alle [Pet]-Objekte in Form einer Liste zurück
  /// Dabei kann es sowohl als [Future<List<Pet>>], als auch als [List<Pet>]
  /// zurückgegeben werden.
  FutureOr<List<Pet>> getAllPets();

  /// Fügt ein [Pet]-Objekt hinzu
  /// Der Rückgabewert kann sowohl [Future<void>], als auch [void] sein.
  FutureOr<void> addPet(Pet pet);

  /// Aktualisiert ein [Pet]-Objekt
  /// Der Rückgabewert kann sowohl [Future<void>], als auch [void] sein.
  FutureOr<void> updatePet(Pet pet);

  /// Löscht ein [Pet]-Objekt anhand seiner [id]
  /// Der Rückgabewert kann sowohl [Future<void>], als auch [void] sein.
  FutureOr<void> deletePetById(String id);
}
