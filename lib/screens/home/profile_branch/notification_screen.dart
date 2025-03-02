import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
   NotificationScreen({super.key});

  final List<Map<String, dynamic>> notifications = [
    {
      "avatar": 0,
      "name": "John1",
      "item": "sweaters"
    },
    {
      "avatar": 1,
      "name": "John2",
      "item": "toys"
    },
    {
      "avatar": 2,
      "name": "John3",
      "item": "books"
    },
    {
      "avatar": 3,
      "name": "John4",
      "item": "clothes"
    },
    {
      "avatar": 4,
      "name": "John5",
      "item": "food"
    },
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Notifications'),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: notifications.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.cyan[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.person, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    "${item["name"]} has shown interest in your ${item["item"]}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
