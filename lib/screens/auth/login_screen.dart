import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_service.dart';
import 'signup_screen.dart';
import 'password_screen.dart';
import '../home/explore_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    // Admin login
    if (email == 'admin' && password == 'admin') {
      await AuthService.saveUserDetails(
        firstName: 'Admin',
        lastName: 'User',
        email: email,
        phone: 'N/A',
        password: password,
        userStatus: 'admin',
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ExploreScreen()),
      );
    }
    // Validate email
    else if (email.isEmpty || !emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Regular user login
    if (await AuthService.authenticate(email, password)) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('currentUserEmail', email);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ExploreScreen()),
      );
    }
    // Invalid credentials
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _continueAsGuest() async {
    await AuthService.saveUserDetails(
      firstName: 'Guest',
      lastName: 'User',
      email: 'guest@test.com',
      phone: 'N/A',
      password: 'N/A',
      userStatus: 'guest',
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ExploreScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/givenget_icon.png',
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                    'Welcome to GiveNGet',
                    style: TextStyle(fontSize: 32),
                  )
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: _continueAsGuest,
                child: const Text('Continue as guest'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupScreen()),
                  );
                },
                child: const Text('Don’t have an account? Sign up'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                  );
                },
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}