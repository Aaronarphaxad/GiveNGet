import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  IconData itemListIcon;
  String itemListName;
   final VoidCallback onPressed;

  ProfileItem({
    super.key,
    required this.itemListIcon,
    required this.itemListName, 
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: Color.fromARGB(231, 58, 99, 81),
             borderRadius: BorderRadius.circular(3), 
          ),
          child: Row(
            children: [
              SizedBox(width: 20,),
              Icon(itemListIcon, color: Colors.white,),
              SizedBox(width: 10,),
              Text('$itemListName', style: TextStyle(color: Colors.white),),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.keyboard_arrow_right, color: Colors.white,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}