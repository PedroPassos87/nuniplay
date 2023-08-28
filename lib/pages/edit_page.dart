// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class editPage extends StatefulWidget {
  const editPage({super.key});

  @override
  State<editPage> createState() => _editPageState();
}

class _editPageState extends State<editPage> {
//document ids
  List<String> docIDs = [];

  User? currentUser = FirebaseAuth.instance.currentUser!;

  //get doc Ids
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: currentUser?.email)
        .get()
        .then(
      (snapshot) {
        snapshot.docs.forEach((document) {
          print(document.reference);
          docIDs.add(document.reference.id);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(),
    );
  }
}
