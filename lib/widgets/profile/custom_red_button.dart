import 'package:flutter/material.dart';

class CustomRedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomRedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, '/login');
         },
        child: SizedBox(
          width: double.infinity, 
          height: 40, 
          child: ElevatedButton(
            onPressed: onPressed, 
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, 
              foregroundColor: Colors.white, 
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Color(0xFFBA0000), width: 1),
                borderRadius: BorderRadius.circular(20), 
              ),
              
            ),
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Color(0xFFBA0000)),
            ),
          ),
        ),
      ),
    );
  }
}
