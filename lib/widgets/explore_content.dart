import 'package:flutter/material.dart';
import 'package:givenget/widgets/build_donation_card.dart';
import '../data/mock_data.dart';
// import '../models/donation_item.dart';
import '../widgets/custom_search_delegate.dart';

class ExploreContent extends StatefulWidget {
  const ExploreContent({super.key});

  @override
  State<ExploreContent> createState() => _ExploreContentState();
}

class _ExploreContentState extends State<ExploreContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

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
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.black, // Color for active tab text
              unselectedLabelColor:
                  Colors.grey.shade600, // Color for inactive tab text
              indicatorColor:
                  Colors.blueAccent, // Active tab indicator color
              indicatorWeight: 3.0, // Thickness of the active tab indicator
              labelPadding: EdgeInsets.zero, // No padding between tabs
              onTap: (index) {
                setState(
                    () {}); // Refresh to ensure the selected tab is updated correctly
              },
              tabs: _categories.map((category) {
                _categories
                    .indexOf(category); // Get the index of the category
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0), // Horizontal spacing
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold, // Bold text for clarity
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 10),

            // Search Input Field (New Position)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(mockDonationItems),
                  );
                },
                decoration: InputDecoration(
                  hintText: "Search items...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  suffixIcon: const Icon(Icons.search, color: Colors.black),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // TabBarView (Explore Items)
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _categories.map((category) {
                  return _buildCategoryContent(
                      category); // Filter content for each category
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Explore Grid content
  Widget _buildCategoryContent(String category) {
    // Filter donation items based on the selected category
    final filteredItems =
        mockDonationItems.where((item) => item.category == category).toList();

    // If the category is "All", show all items
    if (category == "All") {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.75,
        ),
        padding: const EdgeInsets.all(8.0),
        itemCount: mockDonationItems.length, // Show all items
        itemBuilder: (context, index) {
          return buildDonationCard(mockDonationItems[index]);
        },
      );
    }
    // Show filtered items based on the selected category
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.75,
      ),
      padding: const EdgeInsets.all(8.0),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        return buildDonationCard(filteredItems[index]);
      },
    );
  }
}
