// trying to make a post class for the first time. 3 distinct fields etc
// !!!!!!!!!!! USELESS !!!!!!!!!!!!

import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final String title;
  final String body;
  final String user;
  final String gameCategory;

  const Post(
      {Key? key,
      required this.title,
      required this.body,
      required this.user,
      required this.gameCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // the card will be the main format for the post
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  user,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                // guarantees the next elements are pushed to the right
                Spacer(),
                Text(
                  gameCategory,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              body,
              style: TextStyle(fontSize: 14),
            ),
            // guarantes next elemnts pushed to the bottom
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'time goes here',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
