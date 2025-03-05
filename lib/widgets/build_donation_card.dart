import 'package:flutter/material.dart';
import 'package:givenget/models/donation_item.dart';
import 'package:givenget/screens/donation_detail_screen.dart';

Widget buildDonationCard(BuildContext context, DonationItem item) {
  return GestureDetector(
    onTap: () {
      // Navigate to the detail page with the selected item
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DonationDetailScreen(item: item),
        ),
      );
    },
    child:  Card(
        elevation: 3,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white
            ),       
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    Container(
                      height: 156,  
                      width: double.infinity, 
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          item.imageUrl,
                          fit: BoxFit.fill, 
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,  
                        children: [
                          Text(
                            item.title,
                            textAlign: TextAlign.left,  
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Donated by ' + item.donor,
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Posted ' + item.datePosted,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(  
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: const Color.fromARGB(104, 0, 0, 0),
                      ),           
                      width: 30,
                      height: 30,
                      child: IconButton(onPressed: () {}, icon: Icon(Icons.clear, color: Colors.white, size: 14,),),
                    ),
                  ),
                )
              ],
            )
          ),
      ),
  );
}
