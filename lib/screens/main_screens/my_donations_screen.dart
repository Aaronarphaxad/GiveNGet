import 'package:flutter/material.dart';
import 'package:givenget/models/donation_item.dart';
import 'package:givenget/services/items_service.dart';
import 'package:givenget/services/session_manager.dart';
import 'package:givenget/widgets/favourites/favourite_list_item.dart';

class MyDonationsScreen extends StatefulWidget {
  const MyDonationsScreen({super.key});

  @override
  State<MyDonationsScreen> createState() => _MyDonationsScreenState();
}

class _MyDonationsScreenState extends State<MyDonationsScreen> {
  List<DonationItem> myDonations = [];
  bool isLoading = true;
  final currentUser = SessionManager().getCurrentUser();

  @override
  void initState() {
    super.initState();
    _loadMyDonations();
  }

  Future<void> _loadMyDonations() async {
    if (currentUser == null) {
      print("❌ No user logged in.");
      return;
    }

    final items = await ItemsService().fetchUserDonations(currentUser!.id);
    setState(() {
      myDonations = items;
      isLoading = false;
    });
  }

  void _refreshDonations() {
    _loadMyDonations();
  }

  void removeDonation(BuildContext context, DonationItem donationItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Delete Donation", style: TextStyle(color: Colors.black)),
          content: const Text(
            "Are you sure you want to delete this donation?",
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

                final success = await ItemsService().deleteDonationItem(donationItem.id);

                if (success) {
                  setState(() {
                    myDonations.removeWhere((item) => item.id == donationItem.id);
                  });
                } else {
                  print("❌ Failed to delete donation.");
                }
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
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
        automaticallyImplyLeading: true,
        title: const Text('My Donations'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : myDonations.isEmpty
          ? const Center(child: Text('You haven\'t made any donations yet.'))
          : Column(
          children: [
          const SizedBox(height: 5),
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
              itemCount: myDonations.length,
              itemBuilder: (context, index) {
                return FavouriteDonationGridListItem(
                  favouriteItems: myDonations,
                  index: index,
                  removeFromFavourites: removeDonation,
                  refreshFavourites: _refreshDonations,
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