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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0, // Removes shadow
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // LOGO
              Image.asset(
                'assets/images/givenget-logo.png',
                width: 120,
                height: 50,
              ),
              const SizedBox(height: 20), 
          
              // EMAIL FIELD
              CustomTextFormField(
                formFieldController: _emailController,
                formFieldIcon: const Icon(Icons.email),
                labelText: 'Your Email',
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
          
              // PASSWORD FIELD
              CustomTextFormField(
                formFieldController: _passwordController,
                formFieldIcon: const Icon(Icons.lock),
                labelText: 'Password',
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
          
              // FORGOT PASSWORD
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgotpassword');
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Forgot Your Password?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 94, 155, 234),
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                      decorationColor: Color.fromARGB(255, 94, 155, 234),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
          
              // LOGIN BUTTON
              CustomGreenButton(
                text: 'Login', 
                onPressed: (){ // removing login logic for now
                  Navigator.pushReplacementNamed(context, '/explore');
                }
              ),
              const SizedBox(height: 5),
          
              // SIGNUP OPTION
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 115, 114, 114),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                     Navigator.pushReplacementNamed(context, '/signup');
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 94, 155, 234),
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        decorationColor: Color.fromARGB(255, 94, 155, 234),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Final spacing
            ],
          ),
        ),
      ),
    );
  }
}