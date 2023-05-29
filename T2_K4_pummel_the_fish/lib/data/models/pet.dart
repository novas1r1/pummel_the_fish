import 'package:pummel_the_fish/data/models/owner.dart';

// T2K4: Die erste Klasse
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
}
