import 'package:flutter/material.dart';
import 'package:givenget/widgets/custom_green_button.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../add_donation_screen.dart';

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

  final List<String> conditions = [
    'New',
    'Like New',
    'Gently Used',
    'Fair'
  ];

  final _formKey = GlobalKey<FormState>();

  TextEditingController _itemNameController = TextEditingController();
  TextEditingController _itemDescriptionController = TextEditingController();
  List<String> selectedCategories = [];  // Stores selected item
  String? _selectedCondition;
  TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Post a Donation",),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container( //where uploaded images will go
                color: const Color.fromARGB(209, 58, 99, 81),
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UploadImageWidget(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_upload,color: Colors.grey,),
                          Text('upload image',style: TextStyle(color: Colors.grey, fontSize: 12),)
                        ],
                      ),
                      ),
                       SizedBox(width: 10,),
                      UploadImageWidget(
                        child: Center(child: Text('2',style: TextStyle(color: Colors.grey),),),
                      ),
                       SizedBox(width: 10,),
                      UploadImageWidget(
                         child: Center(child: Text('3',style: TextStyle(color: Colors.grey),),),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UploadImageWidget(
                        child: Center(child: Text('4',style: TextStyle(color: Colors.grey),),),                    
                      ),
                       SizedBox(width: 10,),
                      UploadImageWidget(
                         child: Center(child: Text('5',style: TextStyle(color: Colors.grey),),),                     
                      ),
                       SizedBox(width: 10,),
                      UploadImageWidget(
                         child: Center(child: Text('6',style: TextStyle(color: Colors.grey),),),
                      ),
                    ],
                  ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CustomTextInput(
                controller: _itemNameController, 
                customInputLabel: 'Item Name:',
                validation: (value){
                  if(value == null || value.isEmpty) {
                      return "Please enter item name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 14,),
              CustomTextInput(
                controller: _itemDescriptionController, 
                customInputLabel: 'Description:',
                maxLines: 4,
                validation: (value){
                  if(value == null || value.isEmpty) {
                      return "Please enter description";
                  }
                  return null;
                },
              ),
              SizedBox(height: 14,),
              // Category Selection
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    const Expanded(child: Row(
                      children: [
                        SizedBox(width: 7),
                        Text('Category:')
                      ],
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
                                  .map((category) => MultiSelectItem(category, category))
                                  .toList(),
                              title: const Text("Select Categories"),
                              selectedColor: Color.fromARGB(209, 58, 99, 81),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color.fromARGB(255, 123, 123, 123)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              buttonIcon: const Icon(
                                Icons.arrow_drop_down,
                                color: Color(0xFF3A6351),
                                size: 30,
                              ),
                              buttonText: const Text(
                                "Select Categories",
                                style: TextStyle(fontSize: 16, color: Color(0xFF3A6351), ),
                              ),
                              // ❌ Hides Default Chips
                              chipDisplay: MultiSelectChipDisplay.none(),
                              onConfirm: (values) {
                                setState(() {
                                  selectedCategories = values.cast<String>();
                                });
                              },
                            
                              backgroundColor: Colors.white, // ✅ Background of the selection dialog
                              
                            ),
                            const SizedBox(height: 10),
                
                            // ✅ Custom Chip Display (Green Squares Below Dropdown)
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
                                      color: const Color.fromARGB(209, 58, 99, 81),
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
                                              selectedCategories.remove(category);
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
              SizedBox(height:6,),
              Row(    //item name input 
                children: [  
                SizedBox(width: 20,),
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
                        borderSide: BorderSide(color: Color(0xFF3A6351), width: 2), // Green focus border
                      ),             
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6),borderSide: BorderSide(color: Colors.grey)), // Border styling
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10), // Adjust height
                    ),
                    hint: Text("Select a condition", style: TextStyle(color: Color(0xFF3A6351)),),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.arrow_drop_down, size: 30, color: Color(0xFF3A6351)),
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
                SizedBox(width: 20,),
              ],
              ),
              SizedBox(height: 14,),
              CustomTextInput(
                controller: _locationController, 
                customInputLabel: 'Location:',
                validation: (value){
                  if(value == null || value.isEmpty) {
                      return "Please enter location";
                  }
                  return null;
                },
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomGreenButton(text: 'Post', onPressed: (){}),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}


class CustomTextInput extends StatefulWidget {
  final String customInputLabel;
  int? maxLines = 1;
  TextEditingController controller;
  final String? Function(String?) validation;
  
  
  CustomTextInput({
    super.key, required this.controller, required this.customInputLabel, this.maxLines, required this.validation,
  });

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  @override
  Widget build(BuildContext context) {
    return Row(    //item name input 
      children: [  
      SizedBox(width: 20,),
      Expanded(child: Text(widget.customInputLabel)),
      Expanded(
        flex: 3,
        child: TextFormField(  
          controller: widget.controller,    
          cursorColor: const Color(0xFF3A6351), 
          style: TextStyle(color: Color(0xFF3A6351), ),
          decoration: InputDecoration(
            focusedBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF3A6351), width: 2)
            ),
            border: OutlineInputBorder(),
          ),
          maxLines: widget.maxLines,
          validator: widget.validation, 
        ),
      ),
      SizedBox(width: 20,),
     ],
    );
  }
}

class UploadImageWidget extends StatefulWidget {
  final Widget child;

  
  UploadImageWidget({
    super.key, required this.child,
  });

  @override
  State<UploadImageWidget> createState() => _UploadImageWidgetState();
}

class _UploadImageWidgetState extends State<UploadImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white, 
        border: Border.all(
          color: Colors.grey, 
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: widget.child
    );
  }
}