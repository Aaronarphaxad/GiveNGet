import 'package:flutter/material.dart';

import 'notification_screen.dart';

class AccountDetails extends StatelessWidget {
  AccountDetails({super.key});
  String _userStatus = 'guest';
  String _firstName = 'Guest';
  String _lastName = '';
  String _email = '';
  String _phone = '';


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
        // automaticallyImplyLeading: false,
        title: const Center(child: Text('Account Details'),),
        actions: [
        IconButton(onPressed: (){//move to notification page
        Navigator.push(context,
        MaterialPageRoute(builder: (context)=>NotificationScreen()));
        }, icon: const Icon(Icons.notifications))
        ],
        ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,  // Controls the width of the background
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.cyan[100],
                  ),
                  child: Icon(Icons.person, size: 250),
                ),
                Text(""),

                Container(
                  width: double.infinity,  // Controls the width of the background
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.lightGreen[900],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text("Name:                       " + _firstName + " " + _lastName),
                        Text(""),
                        Text("Phone Number:               " + _phone),
                        Text(""),
                        Text("Email:                      " + _email),
                        Text(""),
                        Text("Location:                   " + "Somewhere in Mars" ),
                        Text(""),
                        Container(
                          child: Row(

                            children: [
                              Text("Rating:                     " ),
                              Icon(Icons.star, color: Colors.yellow, size: 20,),
                              Icon(Icons.star, color: Colors.yellow, size: 20,),
                              Icon(Icons.star, color: Colors.yellow, size: 20,),
                              Icon(Icons.star, color: Colors.yellow, size: 20,),
                              Icon(Icons.star, color: Colors.yellow, size: 20,),
                            ],
                          ),
                        ),
                        Text(""),
                        Text("Donations:                  " + " 24 Donations" ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
