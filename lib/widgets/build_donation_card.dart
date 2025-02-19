import 'package:flutter/material.dart';
import 'package:givenget/models/donation_item.dart';

Widget buildDonationCard(DonationItem item) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // Rounded card
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12)), // Rounded top image
          child: Container(
            height: 120, // Total height of the card
            width: double.infinity, // Make the image fill the width
            color: Colors.grey[300], // Grey background for placeholder
            child: const Center(
              child: Icon(
                Icons.image,
                size: 50,
                color: Colors.grey,
              ),
            ), // Placeholder icon
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
                item.donor,
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
  );
}
