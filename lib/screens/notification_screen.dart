import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Notifications'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              NotificationCard(),
              NotificationCard(),
              NotificationCard(),
              NotificationCard(),
              NotificationCard(),
              NotificationCard(),
              NotificationCard(),
              NotificationCard(),
              NotificationCard(),
              NotificationCard(),
              NotificationCard(),
              NotificationCard(),
              NotificationCard(),
              
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF3A6351),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/profile-image.png'),
            ),
            SizedBox(width: 10,),
            Expanded(child: Text('Andrew has shown interest in your sweaters',style: TextStyle(color: Colors.white),))
          ],
        ),
      ),
    );
  }
}