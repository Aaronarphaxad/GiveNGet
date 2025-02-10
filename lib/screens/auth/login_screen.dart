import 'package:flutter/material.dart';
import 'package:givenget/screens/auth/signup_screen.dart';
import '../home/explore_screen.dart'; 

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Home Screen (Explore)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ExploreScreen()),
                );
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Navigate to the Signup Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                );
              },
              child: const Text('Don’t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}