import 'package:flutter/material.dart';
import 'package:givenget/screens/auth/login_screen.dart';
import 'package:givenget/screens/auth/password_screen.dart';
import 'package:givenget/screens/auth/signup_screen.dart';
import 'package:givenget/screens/home/explore_screen.dart';
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
      routes: {
        '/' : (context){ return IntroScreen();},
        '/signup' : (context) {return SignupScreen();},
        '/login' : (context) {return LoginScreen();},
        '/forgotpassword' : (context) {return ForgotPasswordScreen();},
        '/explore' : (context) {return ExploreScreen();}
      },
    );
  }
}