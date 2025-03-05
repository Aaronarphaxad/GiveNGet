import 'package:flutter/material.dart';

class CustomGreenButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomGreenButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Ensures full width
      height: 50, // Ensures consistent button height
      child: ElevatedButton(
        onPressed: onPressed, // Uses passed function
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3A6351), // Green button
          foregroundColor: Colors.white, // White text
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
