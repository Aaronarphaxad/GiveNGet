import 'package:flutter/material.dart';
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
          Stack(
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
          ProfileItem(itemListIcon: Icons.person, itemListName: 'Account Details'),
          const SizedBox(height: 3),
          ProfileItem(itemListIcon: Icons.favorite, itemListName: 'My Donations'),
          const SizedBox(height: 3),
          ProfileItem(itemListIcon: Icons.language, itemListName: 'Change Language'),
          const SizedBox(height: 3),
          ProfileItem(itemListIcon: Icons.support_agent, itemListName: 'Help & Support'),
          const SizedBox(height: 40),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: LogoutButton(
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

class ProfileItem extends StatelessWidget {
  IconData itemListIcon;
  String itemListName;

  ProfileItem({
    super.key,
    required this.itemListIcon,
    required this.itemListName
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: Color(0xFF3A6351),
           borderRadius: BorderRadius.circular(3), 
        ),
        child: Row(
          children: [
            SizedBox(width: 20,),
            Icon(itemListIcon, color: Colors.white,),
            SizedBox(width: 10,),
            Text('$itemListName', style: TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }
}


class LogoutButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LogoutButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20),
      child: GestureDetector(
        onTap: () { },
        child: SizedBox(
          width: double.infinity, 
          height: 40, 
          child: ElevatedButton(
            onPressed: onPressed, 
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, 
              foregroundColor: Colors.white, 
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Color(0xFFBA0000), width: 1),
                borderRadius: BorderRadius.circular(20), 
              ),
              
            ),
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Color(0xFFBA0000)),
            ),
          ),
        ),
      ),
    );
  }
}
