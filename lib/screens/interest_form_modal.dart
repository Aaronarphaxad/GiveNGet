import 'package:flutter/material.dart';
import 'package:givenget/models/donation_item.dart';

class InterestFormModal extends StatefulWidget {
  final DonationItem item;

  const InterestFormModal({super.key, required this.item});

  @override
  _InterestFormModalState createState() => _InterestFormModalState();
}

class _InterestFormModalState extends State<InterestFormModal> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Center(
              child: Text(
                "Show Interest",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3A6351), // Green color for theme consistency
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Message Input Field
            TextField(
              controller: _messageController,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: "Please write a short message to the donor of why you would like to have the item...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF3A6351), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Send Message Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle sending message logic here
                  Navigator.pop(context); // Close modal after sending
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A6351), // Theme color
                  foregroundColor: Colors.white, // White text
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Send Message",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
