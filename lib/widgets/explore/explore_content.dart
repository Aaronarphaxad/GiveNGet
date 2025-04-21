import 'package:flutter/material.dart';
import 'package:givenget/models/donation_item.dart';
import 'package:givenget/services/items_service.dart';
import 'package:givenget/widgets/explore/build_donation_card.dart';

import '../components/custom_search_delegate.dart';

class ExploreContent extends StatefulWidget {
  const ExploreContent({super.key});

  @override
  State<ExploreContent> createState() => _ExploreContentState();
}

class _ExploreContentState extends State<ExploreContent> {
  final TextEditingController _searchController = TextEditingController();
  final ItemsService _itemService = ItemsService();

  List<DonationItem> allItems = [];
  bool isLoading = true;

  final List<String> categories = [
    'All',
    'Clothing',
    'Furniture',
    'Electronics',
    'Books',
    'Other',
  ];

  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      final items = await _itemService.fetchDonationItems();
      setState(() {
        allItems = items;
        isLoading = false;
      });
    } catch (e) {

    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.green,
                ))
              : Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Column(
                    children: [
                      // Scrollable Category Filters
                      SizedBox(
                        height: 50,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: categories.map((category) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: ChoiceChip(
                                  label: Text(category),
                                  showCheckmark: false,
                                  selected: _selectedCategory == category,
                                  onSelected: (bool isSelected) {
                                    setState(() {
                                      _selectedCategory =
                                          isSelected ? category : 'All';
                                    });
                                  },
                                  selectedColor: const Color(0xFF3A6351),
                                  labelStyle: TextStyle(
                                    color: _selectedCategory == category
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Search Input
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _searchController,
                          onTap: () {
                            showSearch(
                              context: context,
                              delegate: CustomSearchDelegate(allItems),
                            );
                          },
                          decoration: InputDecoration(
                            hintText: "Search items...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                            ),
                            suffixIcon:
                                const Icon(Icons.search, color: Colors.black),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Grid Content
                      Expanded(
                        child: _buildCategoryContent(_selectedCategory),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildCategoryContent(String category) {
    final filteredItems = category == "All"
        ? allItems
        : allItems.where((item) => item.category == category).toList();

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
