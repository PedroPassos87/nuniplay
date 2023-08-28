// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uniplay/components/my_bottomBar.dart';
import 'package:uniplay/components/my_textfield.dart';
import 'package:uniplay/components/post_secenhanced.dart';
import 'package:uniplay/pages/profile_page.dart';
import 'edit_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // user
  User? currentUser = FirebaseAuth.instance.currentUser!;

  // tracks if it should show the posting fields or not
  bool showPostFields = false;

  // text controllers for each part of the post
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final gameCategoryController = TextEditingController();

  void togglePostFields() {
    setState(() {
      showPostFields = !showPostFields;
    });
  }

  //sign out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // method that does the posting itself
  void postMessage() {
    // posts only if theres something on all fields
    if (bodyController.text.isNotEmpty &&
        titleController.text.isNotEmpty &&
        gameCategoryController.text.isNotEmpty) {
      // stores in firebase
      FirebaseFirestore.instance.collection("Posts").add({
        "Title": titleController.text,
        "GameCat": gameCategoryController.text,
        "Body": bodyController.text,
        "UserEmail": currentUser!.email,
        "TimeStamp": Timestamp.now(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(136, 218, 218, 218),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Colors.lightBlueAccent,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 153, 204, 255),
              ),
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10), // Espaçamento entre o ícone e o texto
            Text('Main Page'),
          ],
        ),
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
                  .collection("Posts")
                  .orderBy(
                    "TimeStamp",
                    descending: true,
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      // get the actual post
                      final post = snapshot.data!.docs[index];
                      return EnhancedPost(
                        title: post['Title'],
                        gameCategory: post['GameCat'],
                        body: post['Body'],
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

          // Toggle post fields button
          ElevatedButton(
            onPressed: togglePostFields,
            child: Text('Postagem'),
          ),

          // post something
          if (showPostFields)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  MyTextField(
                    controller: titleController,
                    hintText: "Title",
                    obscureText: false,
                  ),
                  SizedBox(height: 10), // Add some spacing between fields
                  MyTextField(
                    controller: bodyController,
                    hintText: "Post something",
                    obscureText: false,
                  ),
                  SizedBox(height: 10), // Add some spacing between fields
                  MyTextField(
                    controller: gameCategoryController,
                    hintText: "Game Category",
                    obscureText: false,
                  ),
                  SizedBox(height: 10), // Add some spacing between fields
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            postMessage();
                            titleController.clear();
                            bodyController.clear();
                            gameCategoryController.clear();
                          },
                          child: Icon(Icons.arrow_circle_up),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: MyNavigationBar(),
    );
  }
}
