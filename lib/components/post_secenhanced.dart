// CURRENTLY USED POST !!!!!

// ignore_for_file: prefer_const_constructors

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
        color: Color.fromARGB(255, 245, 242, 242),
        borderRadius: BorderRadius.circular(50),
      ),
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      padding: EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Alinhar o topo dos elementos
        children: [
          // profile pic / icon
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 224, 223, 223),
            ),
            padding: EdgeInsets.all(15),
            child: Icon(
              Icons.person,
              color: Color.fromARGB(255, 242, 2, 174),
              size: 40,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          // post and who posted
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    gameCategory,
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
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
