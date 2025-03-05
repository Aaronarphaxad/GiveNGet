import 'package:flutter/material.dart';
import 'package:givenget/widgets/components/custom_green_button.dart';
import 'package:givenget/widgets/components/custom_text_form_field.dart';
import '../auth/auth_service.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    void _resetPassword() async {
      final email = _emailController.text;

      // Validate email
      if (email.isEmpty || !emailRegex.hasMatch(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid email'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      // Check if the email exists
      final user = await AuthService.getUserByEmail(email);
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email not found'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      // Simulate sending password reset instructions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset instructions sent to $email'),
          duration: const Duration(seconds: 2),
        ),
      );

      // Navigate back to the LoginScreen
      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Reset Password'),
        centerTitle: true,
        elevation: 0, // Removes shadow for cleaner look
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image at the Top
            Image.asset(
              'assets/images/givenget-logo.png',
              width: 120,
              height: 50,
            ),
            const SizedBox(height: 40),

            // Centered Content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center content
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Forgot Your Password?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 110, 110, 110),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  CustomTextFormField(
                    formFieldController: _emailController,
                    formFieldIcon: const Icon(Icons.email),
                    labelText: 'Email Address',
                    validation: (value) {},
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 250,
                    child: const Text(
                    'Please enter your email to update your password',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  ),
                  
                ],
              ),
            ),

            // Button at the Bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20), // Bottom padding
                child: CustomGreenButton(
                  text: 'Reset Password',
                  onPressed: () {
                      // Simulate sending password reset instructions
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Password reset instructions sent to your email'),
                          duration: const Duration(seconds: 2),
                        ),
                      );

                      // Navigate back to the LoginScreen
                      Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}