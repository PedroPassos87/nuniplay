// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_single_cascade_in_expression_statements

import 'package:animated_background/animated_background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uniplay/components/my_buttonP.dart';
import 'package:uniplay/components/my_textfieldP.dart';
import 'package:uniplay/components/square_tile.dart';
import 'package:uniplay/services/auth_service.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  final Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final ageController = TextEditingController();
  final collegeController = TextEditingController();
  final nickController = TextEditingController();

  //instancia do banco cloud firestore
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    ageController.dispose();
    collegeController.dispose();
    nickController.dispose();
  }

  @override
  void initState() {
    //att inicial
    refresh();

    //att em tempo real

    super.initState();
  }

  //sign user up method
  void signUserUp() async {
    //show loading circle ---> in the future change for an animation
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //check if password is right
    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      showErrorMessage("Passwords do not match");
      return;
    }
    //try creating the user
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  //wrong email or password popup
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.amber,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 102, 153),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
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
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "WELCOME",
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 51, 102),
                              fontWeight: FontWeight.w500,
                              fontSize: 38,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Register below with your details",
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 51, 102),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),

                        //first name textfield
                        MyTextFieldP(
                          controller: nickController,
                          hintText: 'Username',
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        //last name
                        MyTextFieldP(
                          controller: collegeController,
                          hintText: 'College',
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        //age
                        MyTextFieldP(
                          controller: ageController,
                          hintText: 'Age',
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        //email textfield
                        MyTextFieldP(
                          controller: emailController,
                          hintText: 'E-mail',
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        //password textfield
                        MyTextFieldP(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        //confirm password textfield
                        MyTextFieldP(
                          controller: confirmPasswordController,
                          hintText: 'Confirm password',
                          obscureText: true,
                        ),

                        const SizedBox(
                          height: 25,
                        ),

                        //sign in
                        MyButtonP(
                          onTap: signUserUp,
                          text: 'Sign up',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        //continue with
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 0.7,
                                  color: Color.fromARGB(255, 179, 9, 247),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Or continue with',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 0.7,
                                  color: Color.fromARGB(255, 131, 10, 211),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 25),

                        //google sign
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //google button
                            SquareTile(
                              onTap: () => AuthService().signInWithGoogle(),
                              imagePath: 'assets/images/google.png',
                            ),

                            SizedBox(width: 10),

                            //future buttons
                          ],
                        ),

                        const SizedBox(
                          height: 25,
                        ),
                        //not a member? register now
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const Text(
                                'Login now',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 196, 77, 217),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  //  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void refresh() async {
    //att manual
  }

  void sendData() {
    //gerar id
    String id = Uuid().v1();
    db.collection("users").doc(id).set(
      {
        //"name": userController.text,
      },
    );
  }
}
