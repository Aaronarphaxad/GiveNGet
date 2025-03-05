import 'package:flutter/material.dart';
import 'package:givenget/models/donation_item.dart';
import 'package:givenget/screens/interest_form_modal.dart';

class DonationDetailScreen extends StatefulWidget {
  final DonationItem item;

  const DonationDetailScreen({super.key, required this.item});

  @override
  State<DonationDetailScreen> createState() => _DonationDetailScreenState();
}

class _DonationDetailScreenState extends State<DonationDetailScreen> {
  bool isLiked = false; // Track if the donation item is liked

  void toggleLike() {
    setState(() {
      isLiked = !isLiked; // Toggle like state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Details"),
        actions: [
          IconButton(
            onPressed: toggleLike,
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Cover Fit
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: widget.item.imageUrl.isNotEmpty
                  ? Image.asset(
                      widget.item.imageUrl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image, size: 60, color: Colors.grey),
                      ),
                    ),
            ),
            const SizedBox(height: 16),

            // Donor Name
            const Text("Donor",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            Text(widget.item.donor,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Description
            const Text("Description",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            Text(widget.item.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),

            // Availability
            const Text("Availability",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            Text(widget.item.availability ? "Available" : "Unavailable",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color:
                        widget.item.availability ? Colors.green : Colors.red)),
            const SizedBox(height: 10),

            // Category & Condition (Side by Side)
            Row(
              children: [
                // Category Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    widget.item.category,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                // Condition Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    widget.item.condition,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Pickup Location, Email, Phone
            const Divider(),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(Icons.location_on, color: Colors.blue),
                SizedBox(width: 6),
                Text("500 Agnes Street", style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 6),
            const Text("email",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            const Text("email@gmail.com", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 6),
            const Text("Phone Number",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            const Text("+1 800 youre-broke", style: TextStyle(fontSize: 16)),
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
            const Color(0xFF3A6351), // Updated to match green color scheme
        foregroundColor: Colors.white, // Ensures the icon contrasts well
        elevation: 4, // Adds a subtle shadow for a modern look
        child: const Icon(Icons.add),
      ),
    );
  }
}
