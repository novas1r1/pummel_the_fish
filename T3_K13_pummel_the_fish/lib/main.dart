import 'package:flutter/material.dart';
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

      /// Diese Screens können Sie einzeln einkommentieren, um sie zu testen:
      /// SplashScreen anzegen:
      home: const SplashScreen(),

      /// HomeScreen anzeigen:
      // home: const HomeScreen(),

      /// DetailPetScreen anzeigen:
      // home: const DetailPetScreen(
      //   pet: brunoTheDog,
      // ),

      /// CreatePetScreen anzeigen:
      // home: const CreatePetScreen(),
    );
  }
}
