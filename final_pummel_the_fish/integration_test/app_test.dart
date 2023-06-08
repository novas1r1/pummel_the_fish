import "package:firebase_core/firebase_core.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";
import "package:pummel_the_fish/firebase_options.dart";
import "package:pummel_the_fish/main.dart";
import "package:pummel_the_fish/screens/home_screen.dart";
import "package:pummel_the_fish/screens/splash_screen.dart";

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  testWidgets(
      "SplashScreen shows first and changes to HomeScreen after 3 seconds",
      (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(SplashScreen), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
