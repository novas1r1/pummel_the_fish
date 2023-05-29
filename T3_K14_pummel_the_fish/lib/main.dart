import 'package:flutter/material.dart';
import 'package:pummel_the_fish/screens/create_pet_screen.dart';
import 'package:pummel_the_fish/screens/detail_pet_screen.dart';
import 'package:pummel_the_fish/screens/home_screen.dart';
import 'package:pummel_the_fish/screens/splash_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        "/home": (context) => const HomeScreen(),
        "/create": (context) => const CreatePetScreen(),
        // T3K14 Übung: DetailPetScreen mit Argumenten aufrufen
        "/detail": (context) => const DetailPetScreen(),
      },

      /// FLUTTER 3.10.X / DART 3.0: Änderung von primarySwatch auf colorScheme
      /// FLUTTER 3.10.X / DART 3.0: useMaterial3 wurde hier hinzugefügt und auf true gesetzt
      /// ALT:
      /* theme: ThemeData(
        primarySwatch: Colors.blue,
      ), */
      /// NEU:
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}
