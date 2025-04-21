import 'package:flutter/material.dart';
import 'package:givenget/widgets/components/custom_green_button.dart';

import '../../../services/auth_service.dart';
import '../../../services/user_service.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  String name = '';
  String phone = '';
  String email = '';
  String location = '';
  int rating = 0;
  int donations = 0;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final profile = await AuthService().getUserProfile();
    if (profile != null) {
      setState(() {
        name = profile['name'];
        phone = profile['phoneNum'];
        email = profile['email'];
        location = profile['location'];
        rating = profile['rating'];
        donations = (profile['donatedIDItems'] as List?)?.length ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Details'),
        centerTitle: true,
        actions: [
          Stack(alignment: Alignment.bottomLeft, children: [
            Icon(
              Icons.notifications_active,
              color: Color.fromARGB(255, 162, 1, 1),
              size: 30,
            ),
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
          ]),
          SizedBox(
            width: 16,
          ),
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
              padding: EdgeInsets.only(left: 6, right: 6, top: 12),
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
                            _buildInfoRow("Name: ", name),
                            _buildInfoRow("Phone Number: ", phone),
                            _buildInfoRow("Email: ", email),
                            _buildInfoRow("Location: ", location),
                            _buildRatingRow(),
                            _buildInfoRow("Donations: ", donations.toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomGreenButton(
                      text: 'Edit',
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          builder: (context) => EditProfileSheet(
                            name: name,
                            phone: phone,
                            email: email,
                            location: location,
                            onSave: (updated) {
                              setState(() {
                                name = updated['name']!;
                                phone = updated['phone']!;
                                email = updated['email']!;
                                location = updated['location']!;
                              });
                            },
                          ),
                        );
                      }),
                  SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //function for text rows
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
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
          SizedBox(
            width: 30,
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: List.generate(
                  4,
                  (index) =>
                      Icon(Icons.star, color: Color(0xFFFDCC0D), size: 20))
                ..add(Icon(Icons.star_half,
                    color: Color(0xFFFDCC0D), size: 20)), // Half Star
            ),
          ),
        ],
      ),
    );
  }
}

class EditProfileSheet extends StatefulWidget {
  final String name, phone, email, location;
  final Function(Map<String, String>) onSave;

  const EditProfileSheet({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.location,
    required this.onSave,
  });

  @override
  State<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<EditProfileSheet> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    phoneController = TextEditingController(text: widget.phone);
    emailController = TextEditingController(text: widget.email);
    locationController = TextEditingController(text: widget.location);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Edit Profile",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            _buildField("Name", nameController),
            _buildField("Phone", phoneController),
            _buildField("Email", emailController),
            _buildField("Location", locationController),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final updated = {
                  'name': nameController.text,
                  'phone': phoneController.text,
                  'email': emailController.text,
                  'location': locationController.text,
                };

                // update user prof
                final success = await UserService().updateUserProfile({
                  'name': nameController.text,
                  'email': emailController.text,
                  'phoneNum': phoneController.text,
                  'location': locationController.text,
                });

                if (success) {
                  widget.onSave({
                    'name': nameController.text,
                    'email': emailController.text,
                    'phone': phoneController.text,
                    'location': locationController.text,
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to update profile'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text("Save"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
