// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uniplay/pages/auth_page.dart';

import '../components/my_textfieldB.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Link sent, check your email.'),
          );
        },
      );
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => AuthPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 115, 219),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 173, 240),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Enter your email and we will send you a password reset link', //escolher uma mensagem melhor
                    style: TextStyle(
                      color: Color.fromARGB(255, 3, 173, 240),
                      fontWeight: FontWeight.w500,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  //email textfield
                  MyTextFieldB(
                    controller: _emailController,
                    hintText: 'E-mail',
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 12,
                  ),

                  GestureDetector(
                    onTap: passwordReset,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(horizontal: 85),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 3, 173, 240),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Text(
                          'Reset Password',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
