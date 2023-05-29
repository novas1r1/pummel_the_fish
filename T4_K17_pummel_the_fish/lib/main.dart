import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pummel_the_fish/firebase_options.dart';
import 'package:pummel_the_fish/screens/create_pet_screen.dart';
import 'package:pummel_the_fish/screens/home_screen.dart';
import 'package:pummel_the_fish/screens/splash_screen.dart';
import 'package:pummel_the_fish/theme/custom_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Firebase initialisieren
  /// Hierfür müssen Sie die Datei lib/firebase_options.dart generieren
  /// Folgen Sie dazu den Anweisungen im Buch
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pummel The Fish",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: CustomColors.blueDark,
          onPrimary: CustomColors.white,
          secondary: CustomColors.orange,
          onSecondary: CustomColors.white,
          error: CustomColors.red,
          onError: CustomColors.white,
          background: CustomColors.white,
          onBackground: CustomColors.blueMedium,
          surface: CustomColors.blueLight,
          onSurface: CustomColors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            fontFamily: "Titillium Web",
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: CustomColors.blueDark,
          ),
          floatingLabelStyle: TextStyle(
            fontFamily: "Titillium Web",
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: CustomColors.blueDark,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: CustomColors.blueDark),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: CustomColors.blueLight,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: CustomColors.red),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: CustomColors.red),
          ),
        ),
        fontFamily: "Comfortaa",
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: "Titillium Web",
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: CustomColors.blueDark,
          ),
          titleMedium: TextStyle(
            fontFamily: "Comfortaa",
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: CustomColors.blueMedium,
          ),
          bodyLarge: TextStyle(
            fontFamily: "Titillium Web",
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: CustomColors.blueDark,
          ),
          bodyMedium: TextStyle(
            fontFamily: "Titillium Web",
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: CustomColors.white,
          ),
          bodySmall: TextStyle(
            fontFamily: "Titillium Web",
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: CustomColors.blueDark,
          ),
        ),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        "/home": (context) => const HomeScreen(),
        "/create": (context) => const CreatePetScreen(),
        // T4K17 Übung: Bearbeiten eines Pets
        // Wir verwenden hierfür keine Named Route, sondern
        // MaterialPageRoute, da wir zur besseren Verarbeitung
        // das Pet-Objekt übergeben müssen
        // "/detail": (context) => const DetailPetScreen(),
      },
    );
  }
}
