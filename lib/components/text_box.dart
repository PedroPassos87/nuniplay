import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  const MyTextBox({
    super.key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.only(left: 15.0, bottom: 15.0),
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                sectionName,
                style: TextStyle(color: Colors.grey[500]),
              ),

              // edit button
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.settings),
                color: Colors.grey[400],
              ),
            ],
          ),
          Text(text),
        ],
      ),
    );
  }
}
