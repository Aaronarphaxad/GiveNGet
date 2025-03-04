import 'package:flutter/material.dart';
import '../add_donation_screen.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
   String? _selectedItem; // Stores selected item
  List<String> _items = ["Option 1", "Option 2", "Option 3", "Option 4"];

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
        child: Column(
          children: [
            Container( //where uploaded images will go
              color: const Color(0xFFD6F4FF),
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
            CustomTextInput(customInputLabel: 'Item Name:',),
            SizedBox(height: 14,),
            CustomTextInput(customInputLabel: 'Description:',maxLines: 4,),
            SizedBox(height: 14,),
            Row(    //item name input 
              children: [  
              SizedBox(width: 20,),
              Expanded(child: Text('Category: ')),
              Expanded(
                flex: 3,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                  Container(     
                    height: 55,
                    decoration: BoxDecoration(  
                    color: Colors.white, 
                    border: Border.all(
                      color: Colors.grey, 
                      width: 1.5
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),),
                  Icon(Icons.arrow_drop_down, size: 50,color: Colors.grey,),
                  ],                 
                ),
              ),
              SizedBox(width: 20,),
            ],
            ),
            SizedBox(height: 14,),
            Row(    //item name input 
              children: [  
              SizedBox(width: 20,),
              Expanded(child: Text('Condition: ')),
              Expanded(
                flex: 3,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                  Container(     
                    height: 55,
                    decoration: BoxDecoration(  
                    color: Colors.white, 
                    border: Border.all(
                      color: Colors.grey, 
                      width: 1.5
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),),
                  Icon(Icons.arrow_drop_down, size: 50, color: Colors.grey,),
                  ],                 
                ),
              ),
              SizedBox(width: 20,),
            ],
            ),
            SizedBox(height: 14,),
            CustomTextInput(customInputLabel: 'Location:',),
            SizedBox(height: 40,),
            ElevatedButton(
            onPressed: () {}, 
            style: ElevatedButton.styleFrom(
              minimumSize: Size(350, 40),
              side: BorderSide(color: Colors.black),
              backgroundColor: const Color(0xFFD6F4FF),
              foregroundColor: Colors.black),
            child: Text('Post', style: TextStyle(fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextInput extends StatefulWidget {
  final String customInputLabel;
  int? maxLines = 1;
  
  
  CustomTextInput({
    super.key, required this.customInputLabel, this.maxLines,
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
        child: TextField(
          decoration: InputDecoration(
            focusedBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: const Color.fromARGB(255, 73, 181, 220), width: 2)
            ),
            border: OutlineInputBorder(),
          ),
          maxLines: widget.maxLines,
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