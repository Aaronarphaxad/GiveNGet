import 'package:flutter/material.dart';
import 'package:givenget/services/auth_service.dart';
import 'package:givenget/widgets/components/custom_green_button.dart';
import 'package:givenget/widgets/components/custom_text_form_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _registerUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: Colors.green),
      ),
    );

    final authService = AuthService();
    final token = await authService.getAccessToken();

    if (token == null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to get access token'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final result = await authService.registerUser(
        name:
            '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}',
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        password: _passwordController.text,
        // token: token,
      );

      Navigator.pop(context);

      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/givenget-logo.png',
                  width: 120,
                  height: 50,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 120,
                    height: 120,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(height: 16),
                        Text('Profile Image', style: TextStyle(fontSize: 14)),
                        SizedBox(height: 10),
                        Icon(Icons.upload_rounded,
                            size: 30, color: Color(0xFF3A6351)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  formFieldController: _firstNameController,
                  formFieldIcon: const Icon(Icons.person),
                  labelText: 'First Name',
                  validation: (value) => value == null || value.isEmpty
                      ? 'Please enter your first name'
                      : null,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  formFieldController: _lastNameController,
                  formFieldIcon: const Icon(Icons.person),
                  labelText: 'Last Name',
                  validation: (value) => value == null || value.isEmpty
                      ? 'Please enter your last name'
                      : null,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  formFieldController: _emailController,
                  formFieldIcon: const Icon(Icons.email),
                  labelText: 'Email Address',
                  validation: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter your email';
                    if (!value.contains('@'))
                      return 'Please enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  formFieldController: _phoneController,
                  formFieldIcon: const Icon(Icons.phone),
                  labelText: 'Phone Number',
                  validation: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter your phone number';
                    if (value.length < 10)
                      return 'Please enter a valid phone number';
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  formFieldController: _passwordController,
                  formFieldIcon: const Icon(Icons.lock),
                  labelText: 'Password',
                  validation: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter a password';
                    if (value.length < 8)
                      return 'Password must be at least 8 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  formFieldController: _confirmPasswordController,
                  formFieldIcon: const Icon(Icons.lock),
                  labelText: 'Confirm Password',
                  validation: (value) => value != _passwordController.text
                      ? 'Passwords do not match'
                      : null,
                ),
                const SizedBox(height: 20),
                CustomGreenButton(text: 'Sign Up', onPressed: _registerUser),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 115, 114, 114)),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/login'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(left: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Login',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
