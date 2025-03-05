import 'package:flutter/material.dart';
import 'package:givenget/data/mock_data.dart';
import 'package:givenget/models/donation_item.dart';
import 'package:givenget/screens/main_screens/explore/donation_detail_screen.dart';

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
          backgroundColor: Colors.white, // White background
          title: Text("Remove from Favourites", style: TextStyle(color: Colors.black)),
          content: Text(
            "Are you sure you want to remove this item from your favourites?",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text("Cancel", style: TextStyle(color: Color(0xFF3A6351))),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                   mockFavouriteItems.remove(donationItem);
                });           
                Navigator.of(context).pop(); // Close dialog
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


class FavouriteDonationGridListItem extends StatelessWidget {
  List<DonationItem> favouriteItems;
  int index;
  final Function(BuildContext, DonationItem) removeFromFavourites;
  final VoidCallback refreshFavourites;

  FavouriteDonationGridListItem({super.key, required this.favouriteItems, required this.index, required this.removeFromFavourites, required this.refreshFavourites});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          // Navigate to the detail page with the selected item
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DonationDetailScreen(
                item: favouriteItems[index],
                refreshFavorites: refreshFavourites,
              ),
            ),
          );
      },  // we navigate to detail screen here
      child: Card(
        elevation: 3,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white
            ),       
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    Container(
                      height: 156,  
                      width: double.infinity, 
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          favouriteItems[index].imageUrl,
                          fit: BoxFit.fill, 
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,  
                        children: [
                          Text(
                            favouriteItems[index].title,
                            textAlign: TextAlign.left,  
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Donated by ' + favouriteItems[index].donor,
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Posted ' + favouriteItems[index].datePosted,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(  
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: const Color.fromARGB(104, 0, 0, 0),
                      ),           
                      width: 30,
                      height: 30,
                      child: IconButton(onPressed: () {
                        
                        removeFromFavourites(context, favouriteItems[index]);
                      }, icon: Icon(Icons.clear, color: Colors.white, size: 14,),),
                    ),
                  ),
                )
              ],
            )
          ),
      ),
    );
  }
}