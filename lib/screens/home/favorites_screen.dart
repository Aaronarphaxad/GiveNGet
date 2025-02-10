import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: const Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: 5, // Placeholder item count
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.favorite, color: Colors.red),
              title: Text('Favorite Item $index'),
              subtitle: const Text('Description of the favorite item'),
              onTap: () {
                // Handle favorite item tap (for now, do nothing)
              },
            ),
          );
        },
      ),
    );
  }
}