// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uniplay/components/drawer.dart';
import 'package:uniplay/components/my_textfieldB.dart';
import 'package:uniplay/components/post_sectry.dart';
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

  // text controllers for each part of the post
  // final titleController = TextEditingController();
  // final bodyController = TextEditingController();
  // final gameCategoryController = TextEditingController();

  // text controller
  final textController = TextEditingController();

  //sign out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // method that does the posting itself
  void postMessage() {
    // posts only if theres something on all fields
    if (textController.text.isNotEmpty) {
      // stores in firebase
      FirebaseFirestore.instance.collection("User Posts").add({
        "Message": textController.text,
        "UserEmail": currentUser.email,
        "TimeStamp": Timestamp.now(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Colors.lightBlueAccent,
        title: const Text('Main Page'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),

      // sending posts to db
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("User Posts")
                  .orderBy(
                    "TimeStamp",
                    descending: false,
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      // get the actual post
                      final post = snapshot.data!.docs[index];
                      return BasicPost(
                        body: post['Message'],
                        user: post['UserEmail'],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro: $snapshot.error.toString()'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),

          // post something
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextFieldB(
                    controller: textController,
                    hintText: "Post something",
                    obscureText: false,
                  ),
                ),
                // button
                IconButton(
                    onPressed: postMessage,
                    icon: const Icon(Icons.arrow_circle_up)),
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
                    text: currentUser.email,
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
