import 'package:flutter_test/flutter_test.dart';
import 'package:pummel_the_fish/data/models/owner.dart';

void main() {
  test('Owner object can be created from map', () {
    // Arrange
    final Map<String, dynamic> ownerMap = {
      "id": "123",
      "name": "John Doe",
    };

    // Act
    final owner = Owner.fromMap(ownerMap);

    // Assert
    expect(owner.id, "123");
    expect(owner.name, "John Doe");
  });

  test('Owner object can be converted to JSON', () {
    // Arrange
    const owner = Owner(id: "123", name: "John Doe");

    // Act
    final json = owner.toJson();

    // Assert
    const expectedJson = '{"id":"123","name":"John Doe"}';

    expect(json, expectedJson);
  });

  test('Owner object can be converted to map', () {
    // Arrange
    const owner = Owner(id: "123", name: "John Doe");

    // Act
    final map = owner.toMap();

    // Assert
    final expectedMap = {
      "id": "123",
      "name": "John Doe",
    };

    expect(map, expectedMap);
  });
}
