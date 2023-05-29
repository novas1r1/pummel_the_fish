import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:pummel_the_fish/data/models/owner.dart';

enum Species { dog, cat, bird, fish }

class Pet extends Equatable {
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

  factory Pet.fromJson(String source) => Pet.fromMap(jsonDecode(source));
  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map["id"],
      name: map["name"],
      species: Species.values[map["species"]],
      // ACHTUNG: Unser JavaScript Backend liefert für einen Wert von "1.0" nur "1" zurück,
      // daher müssen wir das an dieser Stelle zunächst in einen String umwandeln,
      // um danach einen double daraus machen zu können.
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
    // T6K21: Testing, HashCode ergänzen
    return 'Pet(hashCode: $hashCode, id: $id, name: $name, species: $species, age: $age, weight: $weight, height: $height, isFemale: $isFemale, owner: $owner)';
  }

  Pet copyWith({
    String? id,
    String? name,
    Species? species,
    int? age,
    double? weight,
    double? height,
    bool? isFemale,
    Owner? owner,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      species: species ?? this.species,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      isFemale: isFemale ?? this.isFemale,
      owner: owner ?? this.owner,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      species,
      weight,
      height,
      age,
      isFemale,
      owner,
    ];
  }
}
