import "dart:async";
import "dart:convert";

import "package:http/http.dart" as http;
import "package:pummel_the_fish/data/models/pet.dart";
import 'package:pummel_the_fish/data/repositories/pet_repository.dart';

/// Die Basis-URL der REST-API mit der das RestPetRepository kommuniziert
const baseUrl = "https://losfluttern.de/pummelthefish/api";

/// Diese Klasse implementiert das [PetRepository] und
/// stellt die Verbindung zur REST-API her.
/// Hier können Sie die Kuscheltiere von unserer REST-API verwalten.
/// Bitte achten Sie darauf, dass wir lediglich erfolgreiche Status-Codes
/// zurückgeben und keine neuen Pet-Objekte serverseitig angelegt, geupdated
/// oder gelöscht werden können, um unsere API vor Missbrauch zu schützen.
class RestPetRepository implements PetRepository {
  /// Der [httpClient] wird benötigt, um mit der REST-API zu kommunizieren
  final http.Client httpClient;

  /// Der Konstruktor des [RestPetRepository] erwartet einen [httpClient]
  const RestPetRepository({required this.httpClient});

  /// Fügt ein [Pet]-Objekt hinzu
  /// Wenn das Hinzufügen erfolgreich war (Status-Code 200), wird nichts zurückgegeben
  /// Wenn das Hinzufügen nicht erfolgreich war, wird eine Exception geworfen
  @override
  Future<void> addPet(Pet pet) async {
    final uri = Uri.parse("$baseUrl/pets");
    final response = await httpClient.post(
      uri,
      body: pet.toJson(),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 201) {
      print("Kuscheltier erfolgreich hinzugefügt");
      return;
    } else {
      throw Exception("Beim Hinzufügen des Kuscheltiers ging etwas schief");
    }
  }

  /// Gibt alle [Pet]-Objekte in Form einer Liste zurück
  /// Wenn das Laden erfolgreich war (Status-Code 200), wird eine Liste an [Pet]-Objekten zurückgegeben
  /// Wenn das Laden nicht erfolgreich war, wird eine Exception geworfen
  @override
  Future<List<Pet>> getAllPets() async {
    final uri = Uri.parse("$baseUrl/pets");
    final response = await httpClient.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> dataList = jsonDecode(
        response.body,
      );
      final petList = dataList.map((petMap) => Pet.fromMap(petMap)).toList();
      return petList;
    } else {
      throw Exception(
        "Beim Laden der Kuscheltiere ging etwas schief.",
      );
    }
  }

  /// ACHTUNG! Diese Methode ist im Buch an einer Stelle nicht vorhanden
  /// und muss ergänzt werden
  /// Aktualisiert ein [Pet]-Objekt
  /// Wenn das Aktualisieren erfolgreich war (Status-Code 200), wird nichts zurückgegeben
  /// Wenn das Aktualisieren nicht erfolgreich war, wird eine Exception geworfen
  @override
  Future<void> updatePet(Pet pet) async {
    final uri = Uri.parse("$baseUrl/pets/${pet.id}");
    final response = await httpClient.put(
      uri,
      body: pet.toJson(),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      print("Kuscheltier erfolgreich aktualisiert");
    } else {
      throw Exception(
        "Beim Aktualisieren des Pets ging etwas schief",
      );
    }
  }

  /// Löscht ein [Pet]-Objekt anhand seiner [id]
  /// Wenn das Löschen erfolgreich war (Status-Code 204), wird nichts zurückgegeben
  /// Wenn das Löschen nicht erfolgreich war, wird eine Exception geworfen
  @override
  Future<void> deletePetById(String petId) async {
    final uri = Uri.parse("$baseUrl/pets/$petId");
    final response = await httpClient.delete(uri);

    if (response.statusCode == 204) {
      print("Pet wurde erfolgreich gelöscht");
      return;
    } else {
      throw Exception("Beim Löschen des Kuscheltiers ging etwas schief");
    }
  }

  /// T4K16 Übung: Ergänzung der Methode mit REST-API-Call
  /// ACHTUNG: Diese Methode ist im Buch nicht gelistet worden und muss ergänzt werden
  /// Gibt ein [Pet]-Objekt anhand seiner [id] zurück
  /// Wenn das Laden erfolgreich war (Status-Code 200), wird ein [Pet]-Objekt zurückgegeben
  /// Wenn das Laden nicht erfolgreich war, wird eine Exception geworfen
  @override
  Future<Pet?> getPetById(String id) async {
    final uri = Uri.parse("$baseUrl/pets/$id");
    final response = await httpClient.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(
        response.body,
      );

      return Pet.fromMap(data);
    } else {
      throw Exception(
        "Beim Laden des Kuscheltiers mit der Id $id ging etwas schief.",
      );
    }
  }
}
