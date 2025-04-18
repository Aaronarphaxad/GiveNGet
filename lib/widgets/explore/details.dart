import 'package:flutter/material.dart';
import 'package:givenget/models/user.dart';
import 'package:givenget/services/user_service.dart';
import 'package:givenget/screens/main_screens/explore/donation_detail_screen.dart';

class Details extends StatefulWidget {
  final DonationDetailScreen widget;

  const Details({super.key, required this.widget});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  User? _donor;

  @override
  void initState() {
    super.initState();
    loadDonor();
  }

  Future<void> loadDonor() async {
    print("id: " + widget.widget.item.donor);
    final user = await UserService().fetchUserById(widget.widget.item.donor);
    setState(() {
      _donor = user;
      print(_donor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Donor", style: TextStyle(fontSize: 14, color: Colors.grey)),
        Text(
          _donor?.name ?? "Name not available",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        const Text("Description", style: TextStyle(fontSize: 14, color: Colors.grey)),
        Text(widget.widget.item.description, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 12),

        const Text("Availability", style: TextStyle(fontSize: 14, color: Colors.grey)),
        Text(
          widget.widget.item.availability ? "Available" : "Unavailable",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: widget.widget.item.availability ? Colors.green : Colors.red,
          ),
        ),
        const SizedBox(height: 10),

        const Text("Category", style: TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF3A6351),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                widget.widget.item.category,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),
        const Text("Condition", style: TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF3A6351),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            widget.widget.item.condition,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),

        Row(
          children: [
            const Icon(Icons.location_on, color: Color(0xFF3A6351)),
            const SizedBox(width: 6),
            Text(widget.widget.item.location, style: const TextStyle(fontSize: 16)),
          ],
        ),

        const SizedBox(height: 6),
        const Text("Email", style: TextStyle(fontSize: 14, color: Colors.grey)),
        Text(_donor?.email ?? "Email not available", style: const TextStyle(fontSize: 16)),

        const SizedBox(height: 6),
        const Text("Phone Number", style: TextStyle(fontSize: 14, color: Colors.grey)),
        Text(_donor?.phoneNum ?? "Phone not available", style: const TextStyle(fontSize: 16)),

        const SizedBox(height: 30),
      ],
    );
  }
}