import 'package:flutter/material.dart';
import 'donate_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _selectedIndex = 0; // Index for the bottom navigation bar

  // List of screens for the bottom navigation bar
  static const List<Widget> _screens = [
    ExploreContent(), // Explore content
    DonateScreen(),   // Donate screen
    FavoritesScreen(), // Favorites screen
    ProfileScreen(),  // Profile screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Ensure all labels are visible
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Donate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Placeholder content for the Explore Screen (Grid View)
class ExploreContent extends StatefulWidget {
  const ExploreContent({super.key});

  @override
  State<ExploreContent> createState() => _ExploreContentState();
}

class _ExploreContentState extends State<ExploreContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // List of categories
  final List<String> _categories = [
    'All',
    'Clothing',
    'Furniture',
    'Electronics',
    'Books',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: const Text('Explore'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true, // Allow horizontal scrolling for many tabs
          tabs: _categories.map((category) {
            return Tab(text: category);
          }).toList(),
        ),
        actions: [
          // Search Icon (only for Explore Screen)
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(), // Custom search delegate
              );
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: _categories.map((category) {
          return _buildCategoryContent(category);
        }).toList(),
      ),
    );
  }

  // Build content for each category
  Widget _buildCategoryContent(String category) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 items per row
        crossAxisSpacing: 8.0, // Spacing between columns
        mainAxisSpacing: 8.0, // Spacing between rows
        childAspectRatio: 0.75, // Aspect ratio of items
      ),
      padding: const EdgeInsets.all(8.0),
      itemCount: 10, // Placeholder item count
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey[300], // Placeholder for image
                  child: const Center(
                    child: Icon(Icons.image, size: 50, color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$category Item $index',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Description of the item',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


// Custom Search Delegate for the search feature
class CustomSearchDelegate extends SearchDelegate<String> {
  // Placeholder search results
  final List<String> _searchResults = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      // Clear button (appears when there is text in the search bar)
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = ''; // Clear the search query
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        // Close the search bar and return to the Explore Screen
        close(context, null!);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Display search results
    final results = _searchResults.where((item) => item.contains(query)).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            close(context, results[index]); // Close the search bar and return the selected item
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Display search suggestions
    final suggestions = _searchResults.where((item) => item.contains(query)).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index]; // Autofill the search bar with the selected suggestion
          },
        );
      },
    );
  }
}