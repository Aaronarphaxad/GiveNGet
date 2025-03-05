import 'package:flutter/material.dart';

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