import 'package:flutter/material.dart';
import 'package:givenget/data/mock_data.dart';
import 'package:givenget/models/donation_item.dart';
import 'package:givenget/screens/main_screens/explore/interest_form_modal.dart';
import 'package:givenget/services/items_service.dart';
import 'package:givenget/services/session_manager.dart';
import 'package:givenget/widgets/explore/details.dart';
import 'package:givenget/widgets/explore/details_interested_nav.dart';
import 'package:givenget/widgets/explore/interested.dart';

import '../../../models/user.dart';

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
 // final currentUser = SessionManager().getCurrentUser();

  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = SessionManager().getCurrentUser();
  }
  

void _toggleLike() async {
  if (currentUser == null) {
    print("❌ No logged-in user found.");
    return;
  }

  final alreadyLiked = currentUser?.likedIDItems.any((item) => item.id == widget.item.id)??false;

  if (alreadyLiked) {
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
                Navigator.of(context).pop(); // Dismiss dialog first

                await Future.delayed(const Duration(milliseconds: 100)); // Wait a bit for dialog to close

                setState(() {
                  currentUser!.likedIDItems.removeWhere((item) => item.id == widget.item.id);
                });

                final success = await ItemsService().updateUserLikedItems(
                  userId: currentUser!.id,
                  currentUser: currentUser!,
                  likedItem: widget.item,
                );

                if (success) {
                  widget.refreshFavorites?.call();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Removed ${widget.item.title} from Liked Items',
                        style: const TextStyle(color: Colors.black),
                      ),
                      backgroundColor: const Color(0xFFDFF5E3), // Light green
                      duration: const Duration(seconds: 2),
                    ),
                  );
                } else {
                  print('❌ Failed to update user');
                }
              },
              child: const Text("Remove", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  } else {
    setState(() {
      currentUser!.likedIDItems.add(widget.item);
    });

    final success = await ItemsService().updateUserLikedItems(
      userId: currentUser!.id,
      currentUser: currentUser!,
      likedItem: widget.item,
    );

    if (success) {
      widget.refreshFavorites?.call();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Added ${widget.item.title} to Liked Items',
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: const Color(0xFFDFF5E3),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      print('❌ Failed to update user');
    }
  }
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
              currentUser?.likedIDItems.any((item) => item.id == widget.item.id) ?? false
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: currentUser?.likedIDItems.any((item) => item.id == widget.item.id)??false
                  ? Colors.red
                  : Colors.grey,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.item.imageUrl.isNotEmpty
                ? Image.network(
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



