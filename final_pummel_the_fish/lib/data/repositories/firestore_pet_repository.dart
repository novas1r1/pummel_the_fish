import "dart:async";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/foundation.dart";
import "package:pummel_the_fish/data/models/pet.dart";
import "package:pummel_the_fish/data/repositories/pet_repository.dart";

/// Name der Collection in Firestore
const petCollection = "pets";

/// Mit dem FirestorePetRepository werden Daten aus Firestore geladen und
/// in der App angezeigt. Hier finden Sie alle Methoden,
/// um Ihre Kuscheltiere zu verwalten.
class FirestorePetRepository implements PetRepository {
  /// Der [firestore] wird benötigt, um mit Firestore zu kommunizieren
  final FirebaseFirestore firestore;

  /// Der Konstruktor des [FirestorePetRepository] erwartet einen [firestore]
  const FirestorePetRepository({
    required this.firestore,
  });

  /// Gibt einen Stream mit einer Liste an [Pet]-Objekten zurück
  Stream<List<Pet>> getPetsStream() {
    return firestore.collection(petCollection).snapshots().map(
          (snapshot) =>
              snapshot.docs.map((doc) => Pet.fromMap(doc.data())).toList(),
        );
  }

  /// Gibt eine Liste an [Pet]-Objekten zurück
  /// Wenn das Laden erfolgreich war, wird eine Liste an [Pet]-Objekten zurückgegeben
  @override
  Future<List<Pet>> getAllPets() async {
    final petSnapshots = await firestore.collection(petCollection).get();
    final petList = petSnapshots.docs
        .map((snapshot) => Pet.fromMap(snapshot.data()))
        .toList();

    return petList;
  }

  /// ACHTUNG! Mit dem Update der Firebase Packages sind hier einige Änderungen notwendig.
  /// ALT:
  /* @override
  Future<void> addPet(Pet pet) async {
    final emptyDocument = firestore.collection(petCollection).add();
    final petWithId = Pet(
      id: docId.id,
      name: pet.name,
      species: pet.species,
      age: pet.age,
      weight: pet.weight,
      height: pet.height,
      isFemale: pet.isFemale,
      owner: pet.owner,
    );
    emptyDocument.set(petWithId.toMap());
  } */

  /// NEU:
  /// Fügt ein [Pet]-Objekt hinzu, indem zunächst ein leeres Dokument erstellt wird
  /// und anschließend die Daten des [Pet]-Objekts in das Dokument geschrieben werden.

  @override
  Future<void> addPet(
    Pet pet, {
    /// visibleForTesting ist eine Annotation, die nur für Tests innerhalb des /test
    /// Ordners sichtbar ist. An dieser Stelle müssen wir darauf zurückgreifen,
    /// da wir in den Tests die ID des Dokuments festlegen müssen. Ansonsten würde immer
    /// eine neue ID generiert werden und der Test jedes Mal fehlschlagen.
    @visibleForTesting String? testDocId,
  }) async {
    final emptyDocument = await firestore.collection(petCollection).add({});

    final petWithId = Pet(
      id: testDocId ?? emptyDocument.id,
      name: pet.name,
      species: pet.species,
      age: pet.age,
      weight: pet.weight,
      height: pet.height,
      isFemale: pet.isFemale,
      owner: pet.owner,
    );

    if (testDocId != null) {
      firestore.collection(petCollection).doc(testDocId).set(petWithId.toMap());
    } else {
      emptyDocument.set(petWithId.toMap());
    }
  }

  /// Aktualisiert ein [Pet]-Objekt
  @override
  Future<void> updatePet(
    Pet pet, {
    @visibleForTesting String? testDocId,
  }) async {
    await firestore
        .collection(petCollection)
        .doc(testDocId ?? pet.id)
        .update(pet.toMap());
  }

  /// Gibt ein [Pet]-Objekt anhand der [petId] zurück
  /// Wenn das gewünschte Pet-Objekt gefunden wurde, wird es zurückgegeben
  /// ansonsten wird null zurückgegeben.
  @override
  Future<Pet?> getPetById(String petId) async {
    final document = await firestore.collection(petCollection).doc(petId).get();

    if (document.data() != null) {
      return Pet.fromMap(document.data()!);
    }

    return null;
  }

  /// Löscht ein [Pet]-Objekt anhand der [petId]
  @override
  Future<void> deletePetById(String petId) async {
    await firestore.collection(petCollection).doc(petId).delete();
  }

  /// Gibt eine Liste an [Pet]-Objekten zurück, die der gewünschten [species] entsprechen
  Future<List<Pet>> getPetBySpecies(Species species) async {
    final petsSnapshot = await firestore
        .collection(petCollection)
        .where("species", isEqualTo: species.index)
        .get();

    final petList = petsSnapshot.docs
        .map(
          (doc) => Pet.fromMap(doc.data()),
        )
        .toList();

    return petList;
  }

  /// Gibt eine Liste an [Pet]-Objekten zurück, die nach Höhe sortiert sind
  Future<List<Pet>> getPetsOrderedByHeight() async {
    final petsSnapshot = await firestore
        .collection(petCollection)
        .orderBy("height", descending: true)
        .get();

    final petList =
        petsSnapshot.docs.map((doc) => Pet.fromMap(doc.data())).toList();

    return petList;
  }
}
