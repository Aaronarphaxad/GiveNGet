import 'dart:io';

import 'package:flutter/material.dart';
import 'package:givenget/models/donation_item.dart';
import 'package:givenget/screens/main_screens/explore/explore_screen.dart';
import 'package:givenget/services/items_service.dart';
import 'package:givenget/services/session_manager.dart';
import 'package:givenget/services/upload_to_cloudinary.dart';
import 'package:givenget/utils/CustomUploadImageWidget.dart';
import 'package:givenget/widgets/components/custom_green_button.dart';
import 'package:givenget/widgets/donate/custom_text_input.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:uuid/uuid.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  final List<String> categories = [
    'Clothing',
    'Furniture',
    'Electronics',
    'Music'
        'Books',
    'Other',
  ];

  final List<String> conditions = ['New', 'Like New', 'Gently Used', 'Fair'];

  final _formKey = GlobalKey<FormState>();
  final uuid = Uuid();
  TextEditingController _itemNameController = TextEditingController();
  TextEditingController _itemDescriptionController = TextEditingController();
  List<String> selectedCategories = [];
  String? _selectedCondition;
  File? _selectedImage;
  bool _isLoading = false;
  TextEditingController _locationController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please upload an image.')),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        final String donorId = SessionManager().getCurrentUser()!.id;

        final imageUrl = await uploadToCloudinary(_selectedImage!);
        if (imageUrl == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image upload failed')),
          );
          return;
        }

        final item = DonationItem(
          id: uuid.v4(),
          title: _itemNameController.text.trim(),
          description: _itemDescriptionController.text.trim(),
          category:
              selectedCategories.isNotEmpty ? selectedCategories.first : '',
          imageUrl: imageUrl,
          donor: donorId,
          location: _locationController.text.trim(),
          datePosted:
              DateTime.now().toLocal().toIso8601String().split('T').first,
          availability: true,
          condition: _selectedCondition ?? '',
        );

        final success = await ItemsService().submitDonationItem(item);
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Donation posted successfully!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ExploreScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to post donation.')),
          );
        }
      } catch (e) {
        print("🔥 Error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Post a Donation",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                color: const Color.fromARGB(209, 58, 99, 81),
                height: 250,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: CustomUploadImageWidget(
                        onImageSelected: (File file) {
                          setState(() {
                            _selectedImage = file;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.cloud_upload,
                                color: Colors.grey, size: 40),
                            SizedBox(height: 8),
                            Text(
                              'Upload Image',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              CustomTextInput(
                controller: _itemNameController,
                customInputLabel: 'Item Name:',
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter item name";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 14,
              ),
              CustomTextInput(
                controller: _itemDescriptionController,
                customInputLabel: 'Description:',
                maxLines: 4,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter description";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 14,
              ),
              // Category Selection
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    const Expanded(
                      child: Row(
                        children: [SizedBox(width: 7), Text('Category:')],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            MultiSelectDialogField(
                              items: categories
                                  .map((category) =>
                                      MultiSelectItem(category, category))
                                  .toList(),
                              title: const Text("Select Categories"),
                              selectedColor: Color.fromARGB(209, 58, 99, 81),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 123, 123, 123)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              buttonIcon: const Icon(
                                Icons.arrow_drop_down,
                                color: Color(0xFF3A6351),
                                size: 30,
                              ),
                              buttonText: const Text(
                                "Select Categories",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF3A6351),
                                ),
                              ),
                              chipDisplay: MultiSelectChipDisplay.none(),
                              onConfirm: (values) {
                                setState(() {
                                  selectedCategories = values.cast<String>();
                                });
                              },
                              backgroundColor: Colors.white,
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: selectedCategories.map((category) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(209, 58, 99, 81),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          category,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 6),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedCategories
                                                  .remove(category);
                                            });
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(child: Text('Condition: ')),
                  Expanded(
                    flex: 3,
                    child: DropdownButtonFormField<String>(
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF3A6351),
                      ),
                      value: _selectedCondition,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF3A6351),
                              width: 2), // Green focus border
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color: Colors.grey)),
                        // Border styling
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12, horizontal: 10), // Adjust height
                      ),
                      hint: Text(
                        "Select a condition",
                        style: TextStyle(color: Color(0xFF3A6351)),
                      ),
                      dropdownColor: Colors.white,
                      icon: Icon(Icons.arrow_drop_down,
                          size: 30, color: Color(0xFF3A6351)),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCondition = newValue;
                        });
                      },
                      items: conditions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              CustomTextInput(
                controller: _locationController,
                customInputLabel: 'Location:',
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter location";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: CircularProgressIndicator(
                          color: Color(0xFF3A6351), // green color
                          strokeWidth: 3,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomGreenButton(
                          text: 'Post',
                          onPressed: _submitForm,
                        ),
                      ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
