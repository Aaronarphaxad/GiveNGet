import 'package:flutter/material.dart';
import 'package:givenget/data/mock_data.dart';
import 'package:givenget/models/donation_item.dart';
import 'package:givenget/screens/main_screens/explore/interest_form_modal.dart';
import 'package:givenget/widgets/explore/details.dart';
import 'package:givenget/widgets/explore/details_interested_nav.dart';
import 'package:givenget/widgets/explore/interested.dart';

class DonationDetailScreen extends StatefulWidget {
  final DonationItem item;
  final VoidCallback? refreshFavorites; 

  const DonationDetailScreen({super.key, required this.item, this.refreshFavorites});

  @override
  State<DonationDetailScreen> createState() => _DonationDetailScreenState();
}

class _DonationDetailScreenState extends State<DonationDetailScreen> {
  bool isLiked = false; // Track if the donation item is liked
  int selected = 1; // 1 for details, 2 for interested

  void _toggleLike() {
    setState(() {
      if (mockFavouriteItems.contains(widget.item)) {
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
                    mockFavouriteItems.remove(widget.item);
                    widget.refreshFavorites?.call();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Removed ${widget.item.title} from Liked Items',
                          style: TextStyle(color: Colors.black),
                        ),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.white,
                      ),
                    );
                  });           
                  Navigator.of(context).pop(); // Close dialog
                },
                child: Text("Remove", style: TextStyle(color: Colors.red)),
              ),
            ],
          );
        },
      );     
      } else {
        mockFavouriteItems.add(widget.item);
        widget.refreshFavorites?.call();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Added ${widget.item.title} to Liked Items',
              style: TextStyle(color: Colors.black),
            ),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.white,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.item.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _toggleLike,
            icon: Icon(
              mockFavouriteItems.contains(widget.item) ? Icons.favorite : Icons.favorite_border,
              color: mockFavouriteItems.contains(widget.item) ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.item.imageUrl.isNotEmpty
                ? Image.asset(
                    widget.item.imageUrl,
                    width: double.infinity,  
                    height: 300,  
                    fit: BoxFit.fill,  
                  )
                : Container(
                    height: 300,
                    width: double.infinity,  
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.image, size: 60, color: Colors.grey),
                    ),
                  ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0xFF3A6351)
                  ),
                  width: 20,
                  height: 4,               
                ),
                SizedBox(width: 2),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey
                  ),
                  width: 20,
                  height: 4,               
                ),
                SizedBox(width: 2),
               Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey
                  ),
                  width: 20,
                  height: 4,               
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DetailsAndInterestedNav(
                  currentSelected: selected, 
                  tabValue: 1, 
                  text: 'Details',
                  onPressed: () {
                    setState(() {
                      selected = 1;
                    });
                  },
                ),
                SizedBox(width: 4),
                DetailsAndInterestedNav(
                  currentSelected: selected, 
                  tabValue: 2,
                  text: 'Interested',
                  onPressed: () {
                    setState(() {
                      selected = 2;
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 10,right: 10,top: 16),
              child: selected == 1 ? Details(widget: widget) : Interested(),
            )            
          ],
        ),
      ),

      // Floating Action Button to Open Interest Form Modal
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) => InterestFormModal(item: widget.item),
        ),
        backgroundColor:
            const Color(0xFF3A6351), 
        foregroundColor: Colors.white, 
        elevation: 4,
        child: const Icon(Icons.add),
      ),
    );
  }
}



