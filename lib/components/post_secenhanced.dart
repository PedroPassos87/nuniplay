// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

List<String> profileImageURLs = [
  'https://i.pinimg.com/564x/95/d0/fb/95d0fbaca7f906045b811ae729d682f8.jpg',
  'https://i.pinimg.com/564x/64/ef/98/64ef980138c10eed414880785c501820.jpg',
  'https://i.pinimg.com/564x/9a/1a/ac/9a1aac45106ec0f0ae5ba9f586fcca6b.jpg',
  'https://i.pinimg.com/564x/80/f3/dc/80f3dc1bcb7d55f4a5ede676672f3df0.jpg',
  'https://i.pinimg.com/736x/e7/71/f6/e771f6581c14e35ed4e17fc81bf9312e.jpg',
];

String selectedProfileImageURL =
    'https://i.pinimg.com/564x/60/5e/46/605e461ca634e868085d1a3d9d02b1ea.jpg';

String selectRandomProfileImage() {
  final random = Random();
  final randomIndex = random.nextInt(profileImageURLs.length);
  selectedProfileImageURL = profileImageURLs[randomIndex];

  return selectedProfileImageURL;
}

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
    final _image = selectedProfileImageURL;
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
            padding: EdgeInsets.all(12),
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(0, 194, 12, 12),
              backgroundImage: NetworkImage(_image),
              radius: 20, // Define um raio inicial (pode ser ajustado)
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
