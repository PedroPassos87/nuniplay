import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uniplay/components/drawer.dart';
import 'package:uniplay/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;

  // navigate to profile
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

  // ERROR ???
  // text controllers for each part of the post
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final gameCategoryController = TextEditingController();

  //sign out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // ERROR ???

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        foregroundColor: Colors.lightBlueAccent,
        title: const Text('Main Page'),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          // ERROR ???

          // post something
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: gameCategoryController,
                  decoration: InputDecoration(
                    hintText: 'Game Category',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: bodyController,
                  decoration: InputDecoration(
                    hintText: 'Estou procurando um grupo!',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: null,
                        child: Text('Post'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // logged in as...
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: "LOGADO COMO: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: currentUser.displayName!,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
      ),
    );
  }
}
