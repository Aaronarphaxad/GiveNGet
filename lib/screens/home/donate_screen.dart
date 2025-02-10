import 'package:flutter/material.dart';
import '../add_donation_screen.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: const Text('Donate'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Donate items to help others',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Add Donation Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddDonationScreen(),
                  ),
                );
              },
              child: const Text('Add Donation'),
            ),
          ],
        ),
      ),
    );
  }
}