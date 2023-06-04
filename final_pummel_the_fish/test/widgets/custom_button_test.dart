import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pummel_the_fish/widgets/custom_button.dart';

void main() {
  testWidgets('custom button ...', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(onPressed: () {}, label: "Test Custom Button"),
        ),
      ),
    );

    expect(find.text("Test Custom Button"), findsOneWidget);
    expect(find.byType(CustomButton), findsOneWidget);

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile("custom_button.png"),
    );
  });
}
