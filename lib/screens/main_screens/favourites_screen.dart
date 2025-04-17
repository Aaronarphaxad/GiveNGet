import 'package:flutter/material.dart';
import 'package:givenget/models/donation_item.dart';
import 'package:givenget/models/user.dart';
import 'package:givenget/services/items_service.dart';
import 'package:givenget/services/session_manager.dart';
import 'package:givenget/widgets/favourites/favourite_list_item.dart';
// assuming currentUser is defined there

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<DonationItem> favouriteItems = [];
  bool isLoading = true;
  final currentUser = SessionManager().getCurrentUser();

  @override
  void initState() {
    super.initState();
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    if (currentUser == null) {
      print("❌ No user logged in.");
      return;
    }

    final items = await ItemsService().fetchLikedItems(currentUser!.id);
    setState(() {
      favouriteItems = items;
      isLoading = false;
    });
  }

  void _refreshFavorites() {
    _loadFavourites();
  }

  void removeFromFavourites(BuildContext context, DonationItem donationItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Remove from Favourites", style: TextStyle(color: Colors.black)),
          content: const Text(
            "Are you sure you want to remove this item from your favourites?",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel", style: TextStyle(color: Color(0xFF3A6351))),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();

                setState(() {
                  favouriteItems.removeWhere((item) => item.id == donationItem.id);
                  currentUser!.likedItems.removeWhere((item) => item.id == donationItem.id);
                });

                final success = await ItemsService().updateUserLikedItems(
                  userId: currentUser!.id,
                  currentUser: currentUser!,
                  likedItem: donationItem,
                );

                if (!success) {
                  print("❌ Failed to sync removed item with backend.");
                }
              },
              child: const Text("Remove", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Favourites'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : favouriteItems.isEmpty
              ? const Center(child: Text('No liked items yet.'))
              : Column(
                  children: [
                    const SizedBox(height: 5),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        SizedBox(
                          width: 360,
                          child: TextField(
                            cursorColor: const Color(0xFF3A6351),
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF3A6351), width: 2),
                              ),
                              border: OutlineInputBorder(),
                              label: Text('Search items...'),
                              floatingLabelStyle: TextStyle(
                                color: Color(0xFF3A6351),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search, color: Color(0xFF3A6351)),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 6,
                            mainAxisSpacing: 6,
                            childAspectRatio: 0.78,
                          ),
                          itemCount: favouriteItems.length,
                          itemBuilder: (context, index) {
                            return FavouriteDonationGridListItem(
                              favouriteItems: favouriteItems,
                              index: index,
                              removeFromFavourites: removeFromFavourites,
                              refreshFavourites: _refreshFavorites,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}