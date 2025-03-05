import 'package:flutter/material.dart';
import 'package:givenget/screens/home/profile_branch/account_details_screen.dart';
import 'package:givenget/screens/home/profile_branch/change_language_screen.dart';
import 'package:givenget/screens/home/profile_branch/help_support_screen.dart';
import 'package:givenget/screens/home/profile_branch/my_donations_screen.dart';
import 'package:givenget/screens/home/profile_branch/notification_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login_screen.dart';
import '../auth/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userStatus = 'guest';
  String _firstName = 'Guest';
  String _lastName = '';
  String _email = '';
  String _phone = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data from SharedPreferences
  _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('currentUserEmail') ?? '';

    if (email.isNotEmpty) {
      final user = await AuthService.getUserByEmail(email);
      if (user != null) {
        setState(() {
          _firstName = user['firstName'] ?? 'Guest';
          _lastName = user['lastName'] ?? '';
          _email = user['email'] ?? '';
          _phone = user['phone'] ?? '';
          _userStatus = user['userStatus'] ?? 'guest';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('Profile'),),
        actions: [
          IconButton(onPressed: (){//move to notification page
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=>NotificationScreen()));
          }, icon: const Icon(Icons.notifications))
        ],
          
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(//------------------------------main
                width: double.infinity,
                height: 300,
                child: Column(
                  children: [
                    Text(""),
                    Text(""),
                    const CircleAvatar(
                      radius: 75,
                      child: Icon(Icons.person, size: 50),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '$_firstName $_lastName',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 20,),
                          Icon(Icons.star, color: Colors.yellow, size: 20,),
                          Icon(Icons.star, color: Colors.yellow, size: 20,),
                          Icon(Icons.star, color: Colors.yellow, size: 20,),
                          Icon(Icons.star, color: Colors.yellow, size: 20,),
                          Text(" | 24 Donations")
                        ],
                      ),
                    )
                  ]
                ),
                decoration: BoxDecoration(
                  color: Colors.cyan[100],
                ),
              ),


              const SizedBox(height: 10,),
              Container(//---------------------Account Details
                width: 300,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    Icon(Icons.account_circle),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>AccountDetails()));
                        },
                        child: Text("Account Details"),
                      ),
                    ),

                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.cyan[100],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 10,),
              Container(//---------------------My Donations
                width: 300,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    Icon(Icons.volunteer_activism),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>MyDonations()));
                        },
                        child: Text("My Donations"),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.cyan[100],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 10,),
              Container(//---------------------Change Language
                width: 300,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    Icon(Icons.language),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>ChangeLanguage()));
                        },
                        child: Text("Change Language"),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.cyan[100],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 10,),
              Container(//---------------------Help & Support
                width: 300,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    Icon(Icons.support_agent),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>HelpSupport()));
                        },
                        child: Text("Help & Support"),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.cyan[100],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              // Text(_email, ),
              // const SizedBox(height: 10),
              // Text(_phone),
              // const SizedBox(height: 10),
              // Text(_userStatus),
              const SizedBox(height: 60),



              ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('currentUserEmail');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  // minimumSize: MaterialStateProperty.all(Size(300, 40)),
                  minimumSize: Size(300, 40),
                  side: BorderSide(
                    color: Colors.red, // Border color
                    width: 1.0,
                  ),

                ),
                child: const Text('Logout',style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}