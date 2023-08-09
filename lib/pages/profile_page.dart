import 'package:flutter/material.dart';
import 'package:uniplay/components/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // gets the current user
  // final currentuser = FirebaseAuth.instance.currentUser();

  // edit field
  Future<void> editField(String field) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Profile Page"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey.shade900,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          // profile pic
          Icon(
            Icons.person,
            size: 72,
          ),

          // user email
          /*
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          */

          const SizedBox(height: 50),

          // user details
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              'My Details',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),

          // username
          MyTextBox(
            text: 'Johnny',
            sectionName: 'Username',
            onPressed: () => editField('username'),
          ),

          // bio
          MyTextBox(
            text: 'EMPTY',
            sectionName: 'About user',
            onPressed: () => editField('bio'),
          ),

          const SizedBox(height: 50),

          // user posts
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              'User posts: ',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
        ],
      ),
    );
  }
}
