// trying to make  apost class for the second time
// !!!!!!!!!!! USELESS !!!!!!!!!!!!

import 'package:flutter/material.dart';

class BasicPost extends StatelessWidget {
  final String body;
  final String user;

  const BasicPost({
    super.key,
    required this.body,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(user),
            Text(body),
          ],
        ),
      ],
    );
  }
}
