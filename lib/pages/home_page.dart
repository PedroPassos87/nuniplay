// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uniplay/components/drawer.dart';
import 'package:uniplay/components/post.dart';
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
  void postMessage() {
    // posts only if theres something on all fields
    if (titleController.text.isNotEmpty ||
        bodyController.text.isNotEmpty ||
        gameCategoryController.text.isNotEmpty) {
      // stores in firebase
      FirebaseFirestore.instance.collection("User Posts").add({
        "User Email": currentUser.email,
        "Post title": titleController.text,
        "Post body": bodyController.text,
        "Game Category": gameCategoryController.text,
        "Timestamp": Timestamp.now(),
      });
    }
  }

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
                      final post = snapshot.data!.docs[index];
                      return Post(
                        title: post['Title'],
                        body: post['Body'],
                        user: post['User'],
                        gameCategory: post['Category'],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Erro ao carregar os dados."),
                  );
                } else {
                  return CircularProgressIndicator(); // Adicione um indicador de carregamento
                }
              },
            ),
          ),

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
                        onPressed: postMessage,
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
