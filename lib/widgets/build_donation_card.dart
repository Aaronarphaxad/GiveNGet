import 'package:flutter/material.dart';
import 'package:givenget/models/donation_item.dart';
import 'package:givenget/screens/donation_detail_screen.dart';

Widget buildDonationCard(BuildContext context, DonationItem item) {
  return GestureDetector(
    onTap: () {
      // Navigate to the detail page with the selected item
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DonationDetailScreen(item: item),
        ),
      );
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      color: Colors.white,
      elevation: 3, // Slight shadow for depth
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              height: 140, // Fixed height for image container
              width: double.infinity,
              color: Colors.grey[300], // Placeholder background
              child: item.imageUrl.isNotEmpty
                  ? Image.asset(item.imageUrl, width: double.infinity, fit: BoxFit.cover,height: 140,)                
                  : const Center(
                      child: Icon(Icons.image, size: 50, color: Colors.grey),
                    ), // Placeholder icon if no image URL
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Donor: ${item.donor}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  item.datePosted,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
