// trying to make the sec post class, which works, better

import 'package:flutter/material.dart';

class EnhancedPost extends StatelessWidget {
  final String title;
  final String body;
  final String user;
  final String gameCategory;

  const EnhancedPost({
    Key? key,
    required this.title,
    required this.body,
    required this.user,
    required this.gameCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 206, 200, 200),
        borderRadius: BorderRadius.circular(7),
      ),
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alinhar o topo dos elementos
        children: [
          // profile pic / icon
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[400],
            ),
            padding: EdgeInsets.all(15),
            child: Icon(
              Icons.person,
              color: Color.fromARGB(255, 242, 2, 174),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          // post and who posted
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                gameCategory,
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                user,
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                body,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
