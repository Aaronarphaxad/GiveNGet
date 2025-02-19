import 'package:flutter/material.dart';
import 'package:givenget/widgets/explore_content.dart';
import 'donate_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _screens = [
    const ExploreContent(),
    const DonateScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black, // Keep the text color same
        unselectedItemColor: Colors.grey.shade600, // Inactive text color
        selectedIconTheme: const IconThemeData(color: Colors.blueAccent), // More vibrant active icon color
        unselectedIconTheme: const IconThemeData(color: Colors.grey), // Inactive icon color
        backgroundColor: Colors.white, // Background color for the bottom bar
        elevation: 5, // Shadow for the bottom bar
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Donate'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
