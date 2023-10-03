// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uniplay/components/my_bottomBar.dart';
import 'package:uniplay/components/my_textfield.dart';
import 'package:uniplay/components/post_secenhanced.dart';
import 'auth_page.dart';

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
  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthPage()),
    );
  }

  // method that does the posting itself
  void postMessage() {
    // posts only if there's something in all fields
    if (bodyController.text.isNotEmpty &&
        titleController.text.isNotEmpty &&
        gameCategoryController.text.isNotEmpty) {
      // stores in Firebase
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
      backgroundColor: const Color.fromARGB(255, 21, 23, 24),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 173, 240),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),

      // sending posts to db
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 3, 173, 240),
                Color.fromARGB(255, 0, 102, 153),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.4, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'LOBBY',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 45,
                  fontFamily: 'arcadeclassic',
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
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
                      child: Text('Erro: ${snapshot.error.toString()}'),
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
              child: Text('Nova Postagem'),
            ),

            // post something
            if (showPostFields)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    MyTextField(
                      controller: titleController,
                      hintText: "Título",
                      obscureText: false,
                    ),
                    SizedBox(height: 10), // Add some spacing between fields
                    MyTextField(
                      controller: bodyController,
                      hintText: "Poste algo",
                      obscureText: false,
                    ),
                    SizedBox(height: 10), // Add some spacing between fields
                    MyTextField(
                      controller: gameCategoryController,
                      hintText: "Categoria do Jogo",
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
      ),
      bottomNavigationBar: MyNavigationBar(),
    );
  }
}
