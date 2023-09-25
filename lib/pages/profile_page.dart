// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniplay/components/image_picker.dart';
import 'package:uniplay/components/my_bottomBar.dart';
import 'package:uniplay/resources/add_data.dart';

import '../database/get_user_nick.dart';
import 'home_page.dart';
import 'edit_page.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          appBar: AppBar(
            foregroundColor: Color.fromARGB(255, 0, 102, 153),
            backgroundColor: Color.fromARGB(255, 0, 102, 153),
            elevation: 0,
          ),
          body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 0, 102, 153),
                    Color.fromARGB(255, 3, 173, 240),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'MY PROFILE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'arcadeclassic',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.35,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            double innerHeight = constraints.maxHeight;
                            double innerWidth = constraints.maxWidth;

                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: Container(
                                      height: innerHeight * 0.57,
                                      width: innerWidth,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 70,
                                          ),
                                          Expanded(
                                            child: FutureBuilder(
                                              future: getDocId(),
                                              builder: (context, snapshot) {
                                                return ListView.builder(
                                                  itemCount: docIDs.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ListTile(
                                                      title: GetUserNick(
                                                          documentId:
                                                              docIDs[index]),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/vava.png",
                                                    scale: 4,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/clash.png",
                                                    scale: 4,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/lol.png",
                                                    scale: 4,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: innerHeight * 0.5 -
                                      90, // Adjust this value to center the CircleAvatar
                                  left: innerWidth * 0.5 - 70,
                                  child: Center(
                                    child: Container(
                                      child: _image != null
                                          ? CircleAvatar(
                                              radius: 70,
                                              backgroundImage:
                                                  MemoryImage(_image!),
                                            )
                                          : CircleAvatar(
                                              radius: 70,
                                              backgroundImage: AssetImage(
                                                  "assets/images/esports.jpg"),
                                              backgroundColor:
                                                  Color.fromARGB(255, 3, 3, 3),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sobre Mim:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          maxLines: 4, // Ajuste o número de linhas desejado
                          decoration: InputDecoration(
                            hintText: 'Digite algo sobre você...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 100,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 40, right: 40, top: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditProfile(),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: const Center(
                            child: Text(
                              'Editar perfil ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 30, 9, 124),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: MyNavigationBar(),
        ),
      ],
    );
  }

  Uint8List? _image;
  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);

    if (img != null) {
      setState(() {
        _image = img;
      });
    } else {
      // Usuário cancelou a seleção da imagem
      print('User canceled image selection');
    }
  }
}
