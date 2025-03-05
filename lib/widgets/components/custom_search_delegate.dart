import 'package:flutter/material.dart';
import '../../models/donation_item.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<DonationItem> allItems;

  CustomSearchDelegate(this.allItems);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = ''; // Clears the search input
            showSuggestions(context); // Refresh suggestions
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = allItems
        .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return const Center(
        child: Text(
          'No items found',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index].title),
          subtitle: Text(results[index].description),
          onTap: () => close(context, results[index].title),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context); // Show filtered results while typing
  }
}
