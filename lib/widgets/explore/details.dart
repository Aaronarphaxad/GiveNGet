import 'package:flutter/material.dart';
import 'package:givenget/screens/main_screens/explore/donation_detail_screen.dart';

class Details extends StatelessWidget {
  const Details({
    super.key,
    required this.widget,
  });

  final DonationDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [        
        // Donor Name
        const Text("Donor",
            style: TextStyle(fontSize: 14, color: Colors.grey)),
        Text(widget.item.donor,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                color:widget.item.availability ? Colors.green : Colors.red)),
        const SizedBox(height: 10),
                
        const Text("Category",
            style: TextStyle(fontSize: 14, color: Colors.grey)),
            SizedBox(height: 4,),

        // Category & Condition (Side by Side)
        Row(
          children: [
            // Category Badge
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF3A6351) ,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                widget.item.category,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
          ],    
        ),
        const SizedBox(height: 14),
        const Text("Condition",
            style: TextStyle(fontSize: 14, color: Colors.grey)),
            
            // Condition Badge
            SizedBox(height: 4,),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF3A6351),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                widget.item.condition,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
        const SizedBox(height: 10),
                
        // Pickup Location, Email, Phone
        const Divider(),
        const SizedBox(height: 10),
        Row(
          children: const [
            Icon(Icons.location_on, color: Color(0xFF3A6351)),
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
        SizedBox(height: 30,),
    ],
    );
  }
}