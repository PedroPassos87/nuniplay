// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:uniplay/pages/auth_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 151, 6, 247),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.2, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Center(
          child: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 150),
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: Image(
                          image: AssetImage("assets/gifs/animacaologo01.gif")),
                    ),
                    const Text(
                      'UNIPLAY',
                      style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                        fontFamily: 'arcadeclassic',
                      ),
                    )
                  ],
                ),
              ),
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
                          builder: (_) => AuthPage(),
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
                          'Get Started',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
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
    );
  }
}
