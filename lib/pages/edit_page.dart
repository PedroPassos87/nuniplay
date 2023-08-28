import 'package:flutter/material.dart';

import '../components/my_bottomBar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
      ),
      body: Container(
        child: ListView(),
      ),
      bottomNavigationBar: MyNavigationBar(),
    );
  }
}
