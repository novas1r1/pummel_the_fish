import 'dart:convert';

import 'package:pummel_the_fish/data/models/owner.dart';

enum Species { dog, cat, bird, fish }

class Pet {
  final String id;
  final String name;
  final Species species;
  final int age;
  final double weight;
  final double height;
  final bool isFemale;
  final Owner? owner;

  const Pet({
    required this.id,
    required this.name,
    required this.species,
    required this.age,
    required this.weight,
    required this.height,
    this.isFemale = true,
    this.owner,
  });

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map["id"],
      name: map["name"],
      species: Species.values[map["species"]],
      // T4K16 Übung: Unser Backend liefert das Gewicht als Integer-Wert, wenn es keine Nachkommazahl
      // ist. Das ist nicht korrekt, aber wir müssen damit umgehen können und es zu einem Double umwandeln.
      // ALT:
      //weight: map["weight"],
      // WORKAROUND:
      weight: double.parse(map["weight"].toString()),
      height: double.parse(map["height"].toString()),
      age: map["age_in_years"] as int,
      isFemale: map["is_female"],
      owner: map["owner"] != null ? Owner.fromMap(map["owner"]) : null,
    );
  }

  String toJson() => jsonEncode(toMap());
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({"id": id});
    result.addAll({"name": name});
    result.addAll({"species": species.index});
    result.addAll({"age_in_years": age});
    result.addAll({"weight": weight});
    result.addAll({"height": height});
    result.addAll({"is_female": isFemale});
    if (owner != null) {
      result.addAll({"owner": owner!.toMap()});
    }
    return result;
  }

  @override
  String toString() {
    return 'Pet(id: $id, name: $name, species: $species, age: $age, weight: $weight, height: $height, isFemale: $isFemale, owner: $owner)';
  }
}
