import 'package:flutter/material.dart';
import 'package:givenget/widgets/components/custom_green_button.dart';

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Details'),
        centerTitle: true,
          actions: [
          Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Icon(Icons.notifications_active, color: Color.fromARGB(255, 162, 1, 1),size: 30,),
              Container(
                width: 16,
                height: 16, 
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 162, 1, 1),
                  shape: BoxShape.circle, 
                ),
                alignment: Alignment.center, 
                child: const Text(
                  '5',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ]           
            ),
          SizedBox(width: 16,),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 360,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/big-profile-image.png',
                  fit: BoxFit.cover, 
                ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 6,right: 6,top: 12),
              child: Column(
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Color(0xFF3A6351),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildInfoRow("Name: ", "Jonathan Smith"),
                            _buildInfoRow("Phone Number: ", "+1 800 You're Broke"),
                            _buildInfoRow("Email: ", "jonathansmith@gmail.com"),
                            _buildInfoRow("Location: ", "Supercool Address"),
                            _buildRatingRow(),
                            _buildInfoRow("Donations: ", "24 Donations"),
                          ],
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 10),
                 CustomGreenButton(text: 'Edit', onPressed: (){}),
                SizedBox(height: 10),
                ],
              ),
            )
            
          ],
        ),
      ),
    );
  }

  // ✅ Reusable function for text rows
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2, 
            child: Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3, 
            child: Align(
              alignment: Alignment.centerLeft, 
              child: Text(
                value,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "Rating: ", 
              style: TextStyle(
                color: Colors.white, 
                fontSize: 18, 
                fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 30,),
          Expanded(
            flex: 2,
            child: Row(
              children: List.generate(4, (index) => Icon(Icons.star, color: Color(0xFFFDCC0D), size: 20))
                ..add(Icon(Icons.star_half, color: Color(0xFFFDCC0D), size: 20)), // Half Star
            ),
          ),
        ],
      ),
    );
  }
}