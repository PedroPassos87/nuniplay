// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniplay/components/text_box.dart';

import 'edit_page.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No image selected.');
}

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});
  final user = FirebaseAuth.instance.currentUser!;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // gets the current user
  final currentUser = FirebaseAuth.instance.currentUser!;
  // edit field
  Future<void> editField(String field) async {}

  //se configurar o avatar ele ficara salvo
  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);

    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          appBar: AppBar(
            foregroundColor: const Color.fromARGB(255, 151, 6, 247),
            backgroundColor: Color.fromARGB(255, 220, 184, 245),
            elevation: 0,
          ),
          body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 220, 184, 245),
                    Color.fromARGB(255, 193, 113, 247),
                    Color.fromARGB(255, 151, 6, 247),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.2, 0.6, 1.0],
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
                        height: height * 0.4,
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
                                        left: 20, right: 20),
                                    child: Container(
                                      height: innerHeight * 0.6,
                                      width: innerWidth,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 85,
                                          ),
                                          Text(
                                            "User734",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 151, 6, 247),
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    'Posts',
                                                    style: TextStyle(
                                                      color: Colors.grey[900],
                                                      fontSize: 21,
                                                    ),
                                                  ),
                                                  Text(
                                                    '10',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 151, 6, 247),
                                                      fontSize: 21,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 8,
                                                ),
                                                child: Container(
                                                  height: 45,
                                                  width: 2,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    'Nota',
                                                    style: TextStyle(
                                                      color: Colors.grey[900],
                                                      fontSize: 21,
                                                    ),
                                                  ),
                                                  Text(
                                                    '9.6',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 151, 6, 247),
                                                      fontSize: 21,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 70,
                                  right: 0,
                                  left: 0,
                                  child: Center(
                                    child: Container(
                                      child: _image != null
                                          ? CircleAvatar(
                                              radius: 70,
                                              backgroundImage:
                                                  MemoryImage(_image!),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 255, 254, 254),
                                            )
                                          : CircleAvatar(
                                              radius: 70,
                                              backgroundImage: ExactAssetImage(
                                                  'assets/images/iconhs.png'),
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
                  //aqui
                  Positioned(
                    bottom: 100,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => editPage(),
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
                                color: Color.fromARGB(255, 151, 6, 247),
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
        ),
      ],
    );
  }
}
