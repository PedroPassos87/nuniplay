// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

List<String> profileImageURLs = [
  'https://i.pinimg.com/564x/95/d0/fb/95d0fbaca7f906045b811ae729d682f8.jpg',
  'https://i.pinimg.com/564x/64/ef/98/64ef980138c10eed414880785c501820.jpg',
  'https://i.pinimg.com/564x/9a/1a/ac/9a1aac45106ec0f0ae5ba9f586fcca6b.jpg',
  'https://i.pinimg.com/564x/80/f3/dc/80f3dc1bcb7d55f4a5ede676672f3df0.jpg',
  'https://i.pinimg.com/736x/e7/71/f6/e771f6581c14e35ed4e17fc81bf9312e.jpg',
  'https://i.pinimg.com/564x/9c/97/4f/9c974f1094980bca44b8361d4813a0c5.jpg',
  'https://i.pinimg.com/564x/5d/f4/18/5df418287735c4bc97bc8e4100d0a451.jpg',
  'https://i.pinimg.com/564x/68/37/83/683783d40bdb6e5e837c45f4bb847a2b.jpg',
  'https://i.pinimg.com/564x/8a/64/ff/8a64ffe27232d40c19bd7a094a0d7a38.jpg',
  'https://i.pinimg.com/736x/a3/15/88/a31588bf76f26f48f68acb58729d682a.jpg',
  'https://i.pinimg.com/564x/34/65/19/346519b556f438b83af363ba68a67442.jpg',
  'https://i.pinimg.com/564x/93/c1/17/93c1170d5a11327d5667c0472ad0e38f.jpg',
  'https://i.pinimg.com/564x/f1/09/55/f1095558b2bf44e99eac8d2d6e11a01f.jpg',
  'https://i.pinimg.com/564x/33/6f/4b/336f4b8469fd0d151e075b324cf31e68.jpg',
  'https://i.pinimg.com/564x/77/77/17/777717efd0cf67f39af5fa06a7116a44.jpg',
  'https://i.pinimg.com/564x/7e/90/be/7e90be80f92988657f7f6858d805b8f4.jpg',
  'https://i.pinimg.com/564x/e0/fb/df/e0fbdf6da0b9f8c0eb7419d8bbe0f681.jpg',
  'https://i.pinimg.com/564x/6f/c0/ee/6fc0ee5aa7095d2db50bf24cfef40cd0.jpg',
  'https://i.pinimg.com/564x/60/5e/46/605e461ca634e868085d1a3d9d02b1ea.jpg',
  'https://i.pinimg.com/564x/0a/22/b8/0a22b8bcd967b41a89a370c250ba5750.jpg',
  'https://i.pinimg.com/564x/41/c8/d6/41c8d6f1d2c1beb5f3e753c7b52f485b.jpg',
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
    selectRandomProfileImage();
    final image = selectedProfileImageURL;
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
            padding: EdgeInsets.only(top: 12, bottom: 12, right: 12, left: 0),
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(0, 194, 12, 12),
              backgroundImage: NetworkImage(image),
              radius: 30, // Define um raio inicial (pode ser ajustado)
            ),
          ),
          SizedBox(
            width: 20,
          ),
          // post and who posted
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
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
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                  body,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
