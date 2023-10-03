import 'package:flutter/material.dart';
import '../pages/edit_page.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({super.key});

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
          builder: (context) => const ProfilePage(),
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
          builder: (context) => const EditProfile(),
        ),
      );
    }

    return BottomAppBar(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: goToProfilePage,
          ),
          const SizedBox(width: 20),
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: goToHomePage,
          ),
          const SizedBox(width: 20),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: goToEditPage,
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
