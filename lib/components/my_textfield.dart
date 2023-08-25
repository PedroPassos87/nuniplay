// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(0, 118, 2, 250),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(0, 96, 125, 139),
            ),
          ),
          fillColor: Color.fromARGB(255, 252, 252, 252).withOpacity(0.6),
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Color.fromARGB(255, 0, 51, 102),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
