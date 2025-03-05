import 'package:flutter/material.dart';
import 'package:givenget/widgets/intro/onboarding.dart';
import 'package:givenget/widgets/intro/spash_screen.dart';
import 'dart:async';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool showOnboarding = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        showOnboarding = true; // Show onboarding after splash
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return showOnboarding ? const OnboardingScreen() : const SplashScreen();
  }
}




