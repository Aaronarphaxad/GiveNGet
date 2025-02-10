import 'package:flutter/material.dart';
import 'screens/intro_screen.dart';

void main() {
  runApp(const GiveNGetApp());
}

class GiveNGetApp extends StatelessWidget {
  const GiveNGetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GiveNGet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IntroScreen(), // Start with the Intro Screen
    );
  }
}