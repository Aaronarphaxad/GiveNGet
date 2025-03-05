import 'package:flutter/material.dart';
import 'package:givenget/widgets/explore/explore_content.dart';
import '../donate_screen.dart';
import '../favourites_screen.dart';
import '../profile/profile_screen.dart';

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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: Color(0xFF3A6351))
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF3A6351), //active color
          unselectedItemColor: Colors.grey.shade600, // Inactive color
          selectedIconTheme: const IconThemeData(color: Color(0xFF3A6351),),//active color
          unselectedIconTheme: const IconThemeData(color: Colors.grey),// Inactive color
          backgroundColor: Colors.white, // Background color for the bottom bar
          elevation: 5, // Shadow for the bottom bar
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(Icons.explore),
               ), 
              label: 'Explore'
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(Icons.add_box),
              ), 
              label: 'Donate'
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(Icons.favorite),
                ), 
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(Icons.person),
                ), 
              label: 'Profile'
            ),
          ],
        ),
      ),
    );
  }
}
