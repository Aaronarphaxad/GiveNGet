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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Send a message to the donor",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _messageController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Enter your message...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Handle sending message logic here
                Navigator.pop(context); // Close modal after sending
              },
              child: const Text("Send Message"),
            ),
          ],
        ),
      ),
    );
  }
}
