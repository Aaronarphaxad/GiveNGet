import 'package:flutter/material.dart';

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