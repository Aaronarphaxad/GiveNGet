import 'package:flutter/material.dart';
import 'package:givenget/widgets/profile/custom_red_button.dart';
import 'package:givenget/widgets/profile/profile_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userStatus = 'guest';
  String _firstName = 'Jonathan';
  String _lastName = 'Smith';
  String _email = 'jonathansmith@gmail.com';
  String _phone = '+1 800-need-free-stuff';
  int _donations = 24;

/* - taking this out for now, using static data
  @override
  void initState() {
    super.initState();
    _loadUserData(); 
  }
  */

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/notifications');
            },
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
              Icon(Icons.notifications_active, color: Color.fromARGB(255, 162, 1, 1),size: 30,),
               Container(
                width: 16,
                height: 16, 
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 162, 1, 1),
                  shape: BoxShape.circle, 
                ),
                alignment: Alignment.center, 
                child: const Text(
                  '5',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ]           
            ),
          ),
          SizedBox(width: 16,),
        ],
      ),
      body: Column(
        children: [
              Container(
                height: 280,
                decoration: BoxDecoration(
                  color: Color(0xFF3A6351),
                  borderRadius: BorderRadius.circular(8), 
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  CircleAvatar(
                  radius: 80,
                  child: Image.asset('assets/images/profile-image.png'),
                ),
                SizedBox(height: 20),
                Text(
                  '$_firstName $_lastName',
                  style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Color(0xFFFDCC0D),size: 20,),
                        Icon(Icons.star, color: Color(0xFFFDCC0D),size: 20,),
                        Icon(Icons.star, color: Color(0xFFFDCC0D),size: 20,),
                        Icon(Icons.star, color: Color(0xFFFDCC0D),size: 20,),
                        Icon(Icons.star_half, color: Color(0xFFFDCC0D),size: 20,)
                      ],
                    ),
                    Text(' | $_donations Donations', style: TextStyle(color: Colors.white, fontSize: 16),)
                  ],
                )
               ],
              ),
            ),
          SizedBox(height: 30,),
          ProfileItem(
            itemListIcon: Icons.person, 
            itemListName: 'Account Details',
            onPressed: (){
              Navigator.pushNamed(context, '/account-details');
            },
          ),
          const SizedBox(height: 3),
          ProfileItem(itemListIcon: Icons.favorite, itemListName: 'My Donations',onPressed: (){},),
          const SizedBox(height: 3),
          ProfileItem(itemListIcon: Icons.language, itemListName: 'Change Language',onPressed: (){},),
          const SizedBox(height: 3),
          ProfileItem(itemListIcon: Icons.support_agent, itemListName: 'Help & Support',onPressed: (){},),
          const SizedBox(height: 40),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomRedButton(
              onPressed: () async {
               // final prefs = await SharedPreferences.getInstance();
              //  await prefs.remove('currentUserEmail');
               Navigator.pushReplacementNamed(context, '/login');
              },
              text: 'Logout',
                        ),
            ), 
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}




