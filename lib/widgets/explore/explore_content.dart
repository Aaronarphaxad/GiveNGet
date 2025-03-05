import 'package:flutter/material.dart';
import 'package:givenget/widgets/explore/build_donation_card.dart';
import '../../data/mock_data.dart';
import '../components/custom_search_delegate.dart';

class ExploreContent extends StatefulWidget {
  const ExploreContent({super.key});

  @override
  State<ExploreContent> createState() => _ExploreContentState();
}

class _ExploreContentState extends State<ExploreContent> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> categories = [
    'All',
    'Clothing',
    'Furniture',
    'Electronics',
    'Books',
    'Other',
  ];

  String _selectedCategory = 'All'; // Default selected category

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          children: [
            // Scrollable Category Filters using ChoiceChip
            SizedBox(
              height: 50, // Limit height for horizontal scrolling
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: categories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: ChoiceChip(
                        label: Text(category),
                        showCheckmark: false,
                        selected: _selectedCategory == category,
                        onSelected: (bool isSelected) {
                          setState(() {
                            _selectedCategory = isSelected ? category : 'All';
                          });
                        },
                        selectedColor: const Color(0xFF3A6351), // Green color
                        labelStyle: TextStyle(
                          color: _selectedCategory == category
                              ? Colors.white
                              : Colors.black, // Contrast text color
                          fontWeight: FontWeight.bold,
                        ),
                        backgroundColor: Colors.white, // Unselected color
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Search Input Field
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

            // Explore Grid Content (Filtered by Category)
            Expanded(
              child: _buildCategoryContent(_selectedCategory),
            ),
          ],
        ),
      ),
    );
  }

  // Explore Grid content
  Widget _buildCategoryContent(String category) {
    final filteredItems =
        category == "All" ? mockDonationItems : mockDonationItems.where((item) => item.category == category).toList();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.78,
      ),
      padding: const EdgeInsets.all(8.0),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        return buildDonationCard(context, filteredItems[index]);
      },
    );
  }
}
