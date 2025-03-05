import 'package:flutter/material.dart';

class DetailsAndInterestedNav extends StatelessWidget {
  final int currentSelected;
  final int tabValue;
  final String text;
  final VoidCallback onPressed;

  const DetailsAndInterestedNav({
    super.key,
    required this.currentSelected,
    required this.tabValue,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = currentSelected == tabValue; 

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 140,
        height: 24,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3A6351) : Colors.white,
          border: Border.all(color: const Color.fromARGB(255, 79, 79, 79)),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}