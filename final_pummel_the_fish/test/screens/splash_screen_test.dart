import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pummel_the_fish/screens/home_screen.dart';
import 'package:pummel_the_fish/screens/splash_screen.dart';

void main() {
  testWidgets('SplashScreen', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SplashScreen(),
    ));
    await tester.pumpAndSettle();

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('SplashScreen changes to HomeScreen', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SplashScreen(),
    ));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
