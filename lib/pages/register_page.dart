// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_background/animated_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uniplay/components/my_buttonP.dart';
import 'package:uniplay/components/my_textfieldP.dart';
import 'package:uniplay/components/square_tile.dart';
import 'package:uniplay/services/auth_service.dart';

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
      backgroundColor: const Color.fromARGB(255, 196, 77, 217),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
            options: const ParticleOptions(
          spawnMaxRadius: 30,
          spawnMinSpeed: 10.00,
          particleCount: 60,
          spawnMaxSpeed: 50.00,
          minOpacity: 0.1,
          spawnOpacity: 0.3,
          image: Image(image: AssetImage('assets/images/ship.png')),
        )),
        vsync: this,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logounipng.png',
                        height: 175,
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome!",
                            style: TextStyle(
                              color: Color.fromARGB(255, 196, 77, 217),
                              fontWeight: FontWeight.w500,
                              fontSize: 32,
                            ),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
