// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_catch_clause

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uniplay/components/my_textfield.dart';
import 'package:uniplay/components/square_tile.dart';
import 'package:uniplay/services/auth_service.dart';
import '../components/my_buttonP.dart';
import 'forgot_password_page.dart';

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
          backgroundColor: Color.fromARGB(255, 242, 2, 54),
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
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 3, 173, 240),
                Color.fromARGB(255, 0, 102, 153),
                Color.fromARGB(255, 0, 51, 102),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.05, 0.4, 0.9, 1.0],
              tileMode: TileMode.clamp),
        ),
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

                  Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 51, 102),
                              fontWeight: FontWeight.w500,
                              fontSize: 28,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        //email textfield
                        MyTextField(
                          controller: emailController,
                          hintText: 'E-mail',
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        //password textfield
                        MyTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        //forgot password
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ForgotPasswordPage();
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 242, 190, 2),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 25,
                        ),

                        //sign in
                        MyButtonP(
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
                                  thickness: 0.8,
                                  color: Color.fromARGB(255, 242, 190, 2),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Or continue with',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 0.8,
                                  color: Color.fromARGB(255, 242, 190, 2),
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
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const Text(
                                'Register now',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 242, 190, 2),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
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
