import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userStatus = 'guest';
  String _userName = 'Guest';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data from SharedPreferences
  _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userStatus = prefs.getString('userStatus') ?? 'guest'; // Get user status
      _userName = prefs.getString('email') ?? 'Guest'; // Get user email (or username)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 20),
            Text(
              _userName, // Display the username or guest
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(_userStatus), // Display whether the user is admin, user, or guest
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Clear stored data and navigate back to the login screen
                SharedPreferences.getInstance().then((prefs) {
                  prefs.remove('userStatus');
                  prefs.remove('email');
                  prefs.remove('password');
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import '../auth/login_screen.dart';
//
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false, // Remove the back button
//         title: const Text('Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const CircleAvatar(
//               radius: 50,
//               child: Icon(Icons.person, size: 50),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'John Doe', // Placeholder name
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             const Text('johndoe@example.com'), // Placeholder email
//             const SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate back to the Login Screen
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const LoginScreen(),
//                   ),
//                 );
//               },
//               child: const Text('Logout'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }