// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_background/animated_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uniplay/components/my_buttonB.dart';
import 'package:uniplay/components/my_textfieldB.dart';
import 'package:uniplay/components/square_tile.dart';
import 'package:uniplay/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  final Function()? onTap;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async {
    //show loading circle ---> in the future change for an animation
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: SpinKitPouringHourGlassRefined(
            color: Colors.white,
            size: 50,
          ),
        );
      },
    );

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      showErrorMessage('Email ou senha invalidos.');
    }
  }

  //wrong email or password popup
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 254, 0, 0),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
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
      backgroundColor: Color.fromARGB(255, 3, 173, 240),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
            options: const ParticleOptions(
          spawnMaxRadius: 30,
          spawnMinSpeed: 10.00,
          particleCount: 60,
          spawnMaxSpeed: 50.00,
          minOpacity: 0.1,
          spawnOpacity: 0.3,
          image: Image(image: AssetImage('assets/images/spaceinvader.png')),
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
                      padding: EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ready?', //escolher uma mensagem melhor
                            style: TextStyle(
                              color: Color.fromARGB(255, 3, 173, 240),
                              fontWeight: FontWeight.w500,
                              fontSize: 32,
                            ),
                          ),

                          const SizedBox(height: 10),

                          //email textfield
                          MyTextFieldB(
                            controller: emailController,
                            hintText: 'E-mail',
                            obscureText: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          //password textfield
                          MyTextFieldB(
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: true,
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          //forgot password
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 3, 78, 240),
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          //sign in
                          MyButtonB(
                            onTap: signUserIn,
                            text: 'Sign in',
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
                                    color: Colors.lightBlue[900],
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
                                    color: Colors.lightBlue[900],
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

                              const SizedBox(width: 10),

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
                                'Not a member?',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              GestureDetector(
                                onTap: widget.onTap,
                                child: const Text(
                                  'Register now',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 3, 78, 240),
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
