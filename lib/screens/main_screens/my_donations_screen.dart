import 'package:flutter/material.dart';
import 'package:givenget/models/donation_item.dart';
import 'package:givenget/services/items_service.dart';
import 'package:givenget/services/session_manager.dart';
import 'package:givenget/widgets/favourites/favourite_list_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDonationsScreen extends StatefulWidget {
  const MyDonationsScreen({super.key});

  @override
  State<MyDonationsScreen> createState() => _MyDonationsScreenState();
}

class _MyDonationsScreenState extends State<MyDonationsScreen> {
  List<DonationItem> myDonations = [];
  bool isLoading = true;
  // final currentUser = SessionManager().getCurrentUser();

  // final prefs = await SharedPreferences.getInstance();
  // // final token = await getAccessToken();
  // final token = prefs.getString('token');
  // final userId = prefs.getString('userId');

  @override
  void initState() {
    super.initState();
    _loadMyDonations();
  }

  // Future<void> _loadMyDonations() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final donorId = prefs.getString('userId');
  //   final token = prefs.getString('token');
  //
  //   if (donorId == null || token == null) {
  //     print("❌ No userId or token found in SharedPreferences.");
  //     return;
  //   }
  //
  //   try {
  //     print("📡 Fetching donations for: $donorId");
  //     final items = await ItemsService().fetchUserDonations(donorId);
  //     print("📦 Donations fetched: ${items.length}");
  //
  //     setState(() {
  //       myDonations = items;
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     print("❌ Error loading donations: $e");
  //   }
  // }

  Future<void> _loadMyDonations() async {
    // if (isLoading) return; // Prevent multiple calls

    setState(() => isLoading = true);

    final prefs = await SharedPreferences.getInstance();
    final donorId = prefs.getString('userId');
    final token = prefs.getString('token');

    if (donorId == null || token == null) {
      print("❌ No userId or token found in SharedPreferences.");
      setState(() => isLoading = false);
      return;
    }

    try {
      print("📡 Fetching donations for: $donorId");
      final items = await ItemsService().fetchUserDonations(donorId);
      print("📦 Donations fetched: ${items.length}");

      setState(() {
        myDonations = items;
      });
    } catch (e) {
      print("❌ Error loading donations: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }


  void _refreshDonations() {
    if (!isLoading) {
      setState(() => isLoading = true);
      _loadMyDonations();
    }
  }

  Future<void> removeDonation(BuildContext context, DonationItem donationItem) async {
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

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✅ Donation deleted successfully'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );

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