import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomUploadImageWidget extends StatefulWidget {
  final Widget child;
  final Function(File)? onImageSelected;

  const CustomUploadImageWidget({
    Key? key,
    required this.child,
    this.onImageSelected,
  }) : super(key: key);

  @override
  State<CustomUploadImageWidget> createState() =>
      _CustomUploadImageWidgetState();
}

class _CustomUploadImageWidgetState extends State<CustomUploadImageWidget> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        _imageFile = file;
      });

      // Notify the parent widget
      if (widget.onImageSelected != null) {
        widget.onImageSelected!(file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(211, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: _imageFile != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              )
            : widget.child,
      ),
    );
  }
}
