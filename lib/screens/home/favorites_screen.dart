import 'package:flutter/material.dart';
import 'package:givenget/models/donation_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  List<DonationItem> _getFavourites() {
    return [
        DonationItem(title: 'Sweater', description: 'This is a sweater', category: 'clothing', imageUrl: 'assets/images/sweaters.png', donor: 'Reiben', datePosted: '2/1/2021', availability: true , condition: 'Used-like new'),
         DonationItem(title: 'Sweater', description: 'This is a sweater', category: 'clothing', imageUrl: 'assets/images/sweaters.png', donor: 'Reiben', datePosted: '2/1/2021', availability: true , condition: 'Used-like new'),
          DonationItem(title: 'Sweater', description: 'This is a sweater', category: 'clothing', imageUrl: 'assets/images/sweaters.png', donor: 'Reiben', datePosted: '2/1/2021', availability: true , condition: 'Used-like new'),
           DonationItem(title: 'Sweater', description: 'This is a sweater', category: 'clothing', imageUrl: 'assets/images/sweaters.png', donor: 'Reiben', datePosted: '2/1/2021', availability: true , condition: 'Used-like new'),
            DonationItem(title: 'Sweater', description: 'This is a sweater', category: 'clothing', imageUrl: 'assets/images/sweaters.png', donor: 'Reiben', datePosted: '2/1/2021', availability: true , condition: 'Used-like new'),
             DonationItem(title: 'Sweater', description: 'This is a sweater', category: 'clothing', imageUrl: 'assets/images/sweaters.png', donor: 'Reiben', datePosted: '2/1/2021', availability: true , condition: 'Used-like new'),
              DonationItem(title: 'Sweater', description: 'This is a sweater', category: 'clothing', imageUrl: 'assets/images/sweaters.png', donor: 'Reiben', datePosted: '2/1/2021', availability: true , condition: 'Used-like new'),
               DonationItem(title: 'Sweater', description: 'This is a sweater', category: 'clothing', imageUrl: 'assets/images/sweaters.png', donor: 'Reiben', datePosted: '2/1/2021', availability: true , condition: 'Used-like new'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false, 
        title: const Text('Favorites'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 5),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                SizedBox(
                width: 360,
                child: TextField(
                  cursorColor: Color.fromARGB(255, 73, 181, 220), 
                  decoration: InputDecoration(
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(color: const Color.fromARGB(255, 73, 181, 220), width: 2),
                    ),
                    border: OutlineInputBorder(),
                    label: Text('Search items...'),
                    floatingLabelStyle: TextStyle(
                      color: Color.fromARGB(255, 73, 181, 220), 
                    ),
                  ),
                ),
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.search, color: Colors.grey,)),
              ],
            ),
           Expanded(
             child: Padding(
               padding: const EdgeInsets.all(12.0),
               child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, 
                    crossAxisSpacing: 10, 
                    mainAxisSpacing: 10,  
                    childAspectRatio: 0.8,  
                  ),
                  itemCount: _getFavourites().length,  
                  itemBuilder: (context, index) {
                    return FavouriteDonationGridListItem(favouriteItems: _getFavourites(), index: index);
                  },
                ),
             ),
           ),
          ],
        ),
      ),
    );
  }
}


class FavouriteDonationGridListItem extends StatelessWidget {
  List<DonationItem> favouriteItems;
  int index;

  FavouriteDonationGridListItem({super.key, required this.favouriteItems, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},  // we navigate to detail screen here
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black, width: 0.5),
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
                        favouriteItems[index].imageUrl,
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
                          favouriteItems[index].title,
                          textAlign: TextAlign.left,  
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Donated by ' + favouriteItems[index].donor,
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Posted ' + favouriteItems[index].datePosted,
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
    );;
  }
}