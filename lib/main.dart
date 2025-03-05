import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:givenget/screens/auth/login_screen.dart';
import 'package:givenget/screens/auth/password_screen.dart';
import 'package:givenget/screens/auth/signup_screen.dart';
import 'package:givenget/screens/main_screens/profile/account_details_screen.dart';
import 'package:givenget/screens/main_screens/explore/explore_screen.dart';
import 'package:givenget/screens/main_screens/profile/notification_screen.dart';
import 'screens/splash_onboarding/intro_screen.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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
        '/explore' : (context) {return ExploreScreen();},
        '/account-details' : (context) {return AccountDetailsScreen();},
        '/notifications' : (context) {return NotificationsScreen();}
      },
    );
  }
}