import 'package:flutter/material.dart';
import 'package:pummel_the_fish/screens/create_pet_screen.dart';
import 'package:pummel_the_fish/screens/detail_pet_screen.dart';
import 'package:pummel_the_fish/screens/home_screen.dart';
import 'package:pummel_the_fish/screens/splash_screen.dart';
import 'package:pummel_the_fish/theme/custom_colors.dart';

void main() async {
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
        "/detail": (context) => const DetailPetScreen(),
      },
    );
  }
}
