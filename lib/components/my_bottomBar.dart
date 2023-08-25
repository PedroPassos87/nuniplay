import 'package:flutter/material.dart';
import '';
import '';

class MyNavigationBar extends StatelessWidget {
  final Function() onProfilePressed;
  final Function() onHomePressed;
  final Function() onEditPressed;

  MyNavigationBar({
    required this.onProfilePressed,
    required this.onHomePressed,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: onProfilePressed,
          ),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: onHomePressed,
          ),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: onEditPressed,
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
