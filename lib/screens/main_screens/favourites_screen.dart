import 'package:flutter/material.dart';
import 'package:givenget/data/mock_data.dart';
import 'package:givenget/models/donation_item.dart';
import 'package:givenget/widgets/favourites/favourite_list_item.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
   void _refreshFavorites() {
    setState(() {});
  }
  
  void removeFromFavourites(BuildContext context, DonationItem donationItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, 
          title: Text("Remove from Favourites", style: TextStyle(color: Colors.black)),
          content: Text(
            "Are you sure you want to remove this item from your favourites?",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text("Cancel", style: TextStyle(color: Color(0xFF3A6351))),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                   mockFavouriteItems.remove(donationItem);
                });           
                Navigator.of(context).pop(); 
              },
              child: Text("Remove", style: TextStyle(color: Colors.red)),
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
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 5),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                SizedBox(
                width: 360,
                child: TextField(
                  cursorColor: Color(0xFF3A6351), 
                  decoration: InputDecoration(
                    focusedBorder:  OutlineInputBorder(
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
              IconButton(onPressed: (){}, icon: Icon(Icons.search, color: Color(0xFF3A6351),),),
              ],
            ),
           Expanded(
             child: Padding(
               padding: const EdgeInsets.all(12.0),
               child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, 
                    crossAxisSpacing: 6, 
                    mainAxisSpacing: 6,  
                    childAspectRatio: 0.78,  
                  ),
                  itemCount: mockFavouriteItems.length,  
                  itemBuilder: (context, index) {
                    return FavouriteDonationGridListItem(
                      favouriteItems: mockFavouriteItems, 
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
      ),
    );
  }
}


