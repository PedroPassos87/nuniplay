// trying to make the sec post class, which works, better

import 'package:flutter/material.dart';

class EnhancedPost extends StatelessWidget {
  final String title;
  final String body;
  final String user;
  final String gameCategory;

  const EnhancedPost({
    super.key,
    required this.title,
    required this.body,
    required this.user,
    required this.gameCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(gameCategory),
            Text(user),
            Text(title),
            Text(body),
          ],
        ),
      ],
    );
  }
}
