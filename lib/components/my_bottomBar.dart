import 'package:flutter/material.dart';
import '../pages/edit_page.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';

class MyNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    void goToHomePage() {
      // pop menu drawer
      Navigator.pop(context);

      // go to home page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }

    void goToProfilePage() {
      // pop menu drawer
      Navigator.pop(context);

      // go to profile page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ),
      );
    }

    void goToEditPage() {
      // pop menu drawer
      Navigator.pop(context);

      // go to home page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => editPage(),
        ),
      );
    }

    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: goToProfilePage,
          ),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: goToHomePage,
          ),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: goToEditPage,
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
