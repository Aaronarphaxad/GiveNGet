import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.formFieldController,
    required this.formFieldIcon,
    required this.labelText,
    required this.validation,
  });

  final TextEditingController formFieldController;
  final Icon formFieldIcon;
  final String labelText;
  final String? Function(String?) validation; // Corrected validation type

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: const Color(0xFF3A6351),
      controller: formFieldController,
      decoration: InputDecoration(
        prefixIcon: formFieldIcon,
        prefixIconColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.focused) ? const Color(0xFF3A6351) : Colors.grey), // Change on focus
        labelText: labelText,
        floatingLabelStyle: const TextStyle(color: Color(0xFF3A6351)), // Label color on focus
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF3A6351), width: 2), // Change focus color
        ),
      ),
      validator: validation, // Uses passed validation function
    );
  }
}