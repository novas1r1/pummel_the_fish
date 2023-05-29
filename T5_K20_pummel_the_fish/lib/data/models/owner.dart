import 'dart:convert';

class Owner {
  final String id;
  final String name;

  const Owner({
    required this.id,
    required this.name,
  });

  factory Owner.fromMap(Map<String, dynamic> map) {
    return Owner(
      id: map["id"],
      name: map["name"],
    );
  }

  String toJson() => jsonEncode(toMap());
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({"id": id});
    result.addAll({"name": name});
    return result;
  }
}
