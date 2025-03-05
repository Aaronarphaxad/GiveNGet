import 'package:flutter/material.dart';
import 'package:givenget/models/donation_item.dart';
import 'package:givenget/screens/interest_form_modal.dart';

class DonationDetailScreen extends StatefulWidget {
  final DonationItem item;

  const DonationDetailScreen({super.key, required this.item});

  @override
  State<DonationDetailScreen> createState() => _DonationDetailScreenState();
}

class _DonationDetailScreenState extends State<DonationDetailScreen> {
  bool isLiked = false; // Track if the donation item is liked
  int selected = 1; // 1 for details, 2 for intersted

  void toggleLike() {
    setState(() {
      isLiked = !isLiked; // Toggle like state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.item.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: toggleLike,
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Cover Fit
            widget.item.imageUrl.isNotEmpty
                ? Image.asset(
                    widget.item.imageUrl,
                    width: double.infinity,  // ✅ Fills full width
                    height: 300,  
                    fit: BoxFit.fill,  // ✅ Covers the entire area
                  )
                : Container(
                    height: 300,
                    width: double.infinity,  
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.image, size: 60, color: Colors.grey),
                    ),
                  ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0xFF3A6351)
                  ),
                  width: 20,
                  height: 4,               
                ),
                SizedBox(width: 2),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey
                  ),
                  width: 20,
                  height: 4,               
                ),
                SizedBox(width: 2),
               Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey
                  ),
                  width: 20,
                  height: 4,               
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DetailsAndInterestedNav(
                  currentSelected: selected, 
                  tabValue: 1, 
                  text: 'Details',
                  onPressed: () {
                    setState(() {
                      selected = 1;
                    });
                  },
                ),
                SizedBox(width: 4),
                DetailsAndInterestedNav(
                  currentSelected: selected, 
                  tabValue: 2,
                  text: 'Interested',
                  onPressed: () {
                    setState(() {
                      selected = 2;
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 10,right: 10,top: 16),
              child: selected == 1 ? Details(widget: widget) : Interested(),
            )            
          ],
        ),
      ),

      // Floating Action Button to Open Interest Form Modal
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) => InterestFormModal(item: widget.item),
        ),
        backgroundColor:
            const Color(0xFF3A6351), // Updated to match green color scheme
        foregroundColor: Colors.white, // Ensures the icon contrasts well
        elevation: 4, // Adds a subtle shadow for a modern look
        child: const Icon(Icons.add),
      ),
    );
  }
}


class DetailsAndInterestedNav extends StatelessWidget {
  final int currentSelected;
  final int tabValue;
  final String text;
  final VoidCallback onPressed;

  const DetailsAndInterestedNav({
    super.key,
    required this.currentSelected,
    required this.tabValue,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = currentSelected == tabValue; 

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 140,
        height: 24,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3A6351) : Colors.white,
          border: Border.all(color: const Color.fromARGB(255, 79, 79, 79)),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}





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
        style:
            const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
            color:
                widget.item.availability ? Colors.green : Colors.red)),
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


class Interested extends StatelessWidget {
  const Interested({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text('23 People Interested', style: TextStyle(color: const Color.fromARGB(255, 85, 85, 85),),),
        ),
        SizedBox(height: 2),
        InterestedPeople(),
        InterestedPeople(),
        InterestedPeople(),
        InterestedPeople(),
        InterestedPeople(),
        SizedBox(height: 80,)   
      ],
    );
  }
}


class InterestedPeople extends StatelessWidget {
  const InterestedPeople({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Aligns avatar with text
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/profile-image.png'),
                ),
                const SizedBox(width: 14),
                Expanded( // ✅ Allows Column to expand fully
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: TextStyle(color: Color(0xFF3A6351), fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Interested 10/02/2025 11:55AM',
                        style: TextStyle(color: Color(0xFF3A6351), fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'I would love to take these off your hands.',
                        style: TextStyle(color: Color.fromARGB(255, 85, 85, 85)),
                      ),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // Prevents stretching
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Decline',
                                style: TextStyle(color: Color(0xFFD60000)),
                              ),
                            ),
                            Container(
                              width: 1.5,
                              height: 20,
                              color: Colors.grey,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Accept',
                                style: TextStyle(color: Color(0xFF02AB0D)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}