import 'package:flutter/material.dart';

class MyDonations extends StatelessWidget {
  MyDonations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('My Donations'),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Cover Fit
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: const Center(
                child: Icon(Icons.image, size: 300, color: Colors.grey),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: const Center(
                child: Icon(Icons.image, size: 300, color: Colors.grey),
              ),
            ),
          ],
      ),
    ));
  }
}
