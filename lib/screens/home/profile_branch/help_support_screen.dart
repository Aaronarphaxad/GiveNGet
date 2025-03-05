import 'package:flutter/material.dart';

class HelpSupport extends StatelessWidget {
  HelpSupport({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Help & Support'),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("GiveNGet is a community-driven mobile app that makes giving and receiving free items simple and hassle-free. Unlike traditional marketplaces focused on buying and selling, GiveNGet is designed exclusively for donations, helping users declutter their homes while directly supporting others in need. Inspired by platforms like Facebook Marketplace, the app allows users to list items they no longer need, browse available donations, and connect with recipients in their local area—all without the complications of money or transactions."),
          Text(""),
          Text(""),
          Text("With GiveNGet, users can post items with photos and descriptions, search and filter listings by category, save favorites for later, and communicate securely through in-app messaging. The app’s intuitive interface makes it easy to turn unwanted items into opportunities for others, reducing waste and fostering a sense of community along the way. Whether you’re looking to donate or find something you need, GiveNGet makes it simple to give what you don’t need and get what you do—completely free of charge."),
        ],
      ),
    );
  }
}
