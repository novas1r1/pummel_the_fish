import "dart:async";

import "package:flutter/material.dart";
import "package:pummel_the_fish/theme/custom_colors.dart";

/// 2025-01-17: Anpassung sodass Fehlermeldung von Flutter verschwindet:
/// Unhandled Exception: Looking up a deactivated widget's ancestor is unsafe.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(64),
            child: Image.asset(
              "assets/images/logo.png",
            ),
          ),
        ),
      ),
      backgroundColor: CustomColors.blueLight,
    );
  }
}
