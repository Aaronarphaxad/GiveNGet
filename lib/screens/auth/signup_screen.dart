import 'package:flutter/material.dart';
import 'package:givenget/screens/auth/login_screen.dart';
import 'package:givenget/widgets/custom_green_button.dart';
import 'package:givenget/widgets/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_service.dart';
import '../home/explore_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with signup
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final email = _emailController.text;
      final phone = _phoneController.text;
      final password = _passwordController.text;

      // Check if the email is already registered
      final existingUser = await AuthService.getUserByEmail(email);
      if (existingUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email already registered'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      await AuthService.saveUserDetails(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        password: password,
        userStatus: 'user',
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('currentUserEmail', email);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ExploreScreen()),
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
          padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 16.0,top: 10),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/givenget-logo.png',
                    width: 120,
                    height: 50,         
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: (){},
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
                        children: [
                          SizedBox(height: 16),
                          const Text(
                            'Profile Image',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 10), 
                          const Icon(
                            Icons.upload_rounded,
                            size: 30, 
                            color: Color(0xFF3A6351), 
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    formFieldController: _firstNameController, 
                    formFieldIcon: Icon(Icons.person), 
                    labelText: 'First Name', 
                    validation: (value) {
                     if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                  }),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    formFieldController: _lastNameController, 
                    formFieldIcon: Icon(Icons.person), 
                    labelText: 'Last Name', 
                    validation: (value) {
                     if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                  }),         
                  const SizedBox(height: 10),
                   CustomTextFormField(
                    formFieldController: _emailController, 
                    formFieldIcon: Icon(Icons.email), 
                    labelText: 'Email Address', 
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                   }),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    formFieldController: _phoneController, 
                    formFieldIcon: Icon(Icons.phone), 
                    labelText: 'Phone Number', 
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (value.length < 10) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                   }),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    formFieldController: _passwordController, 
                    formFieldIcon: Icon(Icons.lock), 
                    labelText: 'Password', 
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                   }),               
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    formFieldController: _confirmPasswordController, 
                    formFieldIcon: Icon(Icons.lock), 
                    labelText: 'Confirm Password', 
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                   }),  
                  const SizedBox(height: 20),
                 CustomGreenButton(
                  text: 'Sign Up', 
                  onPressed: (){ // removing sign up logic for now
                     
                      // Simulate sign up 
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sign Up Successful!'),
                          duration: const Duration(seconds: 2),
                        ),
                      );

                       Navigator.pushReplacementNamed(context, '/login');
                   }),
                SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [ 
                    Text('Already have an account?',style: TextStyle(fontSize: 16,color: const Color.fromARGB(255, 115, 114, 114)),),
                    TextButton(                      
                      onPressed: (){

                        Navigator.pushReplacementNamed(context, '/login');
                      }, 
                            style: TextButton.styleFrom(
                        padding: EdgeInsets.only(left: 4), 
                        minimumSize: Size(0, 0), 
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap, 
                      ),
                      child: Text('Login',                                          
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
      ),
    );
  }
}

