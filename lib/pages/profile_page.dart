// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniplay/components/text_box.dart';

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
    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text("Profile Page"),
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 151, 75, 202),
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
                  const SizedBox(height: 50),
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 58,
                              backgroundImage: MemoryImage(_image!),
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 254, 254),
                            )
                          : CircleAvatar(
                              radius: 58,
                              backgroundImage:
                                  ExactAssetImage('assets/images/iconhs.png'),
                              backgroundColor: Color.fromARGB(255, 3, 3, 3),
                            ),
                      Positioned(
                        child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(Icons.add_a_photo),
                          color: Color.fromARGB(255, 255, 255, 255),
                          highlightColor: Colors.amber,
                        ),
                        bottom: -10,
                        left: 80,
                      )
                    ],
                  ),
                  // profile pic

                  const SizedBox(height: 50),

                  // username
                  MyTextBox(
                    text: "User124567",
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
            ),
          ),
        ),
      ],
    );
  }
}
