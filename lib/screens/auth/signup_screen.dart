import 'package:flutter/material.dart';
import '../home/explore_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 20),
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
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Navigate back to the Login Screen
                Navigator.pop(context);
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}