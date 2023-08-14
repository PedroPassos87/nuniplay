import 'package:flutter/material.dart';

class MyTextFieldP extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextFieldP({
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
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(0, 118, 2, 250))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(0, 96, 125, 139))),
          fillColor: Color.fromARGB(255, 159, 96, 218).withOpacity(0.2),
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Color.fromARGB(200, 166, 79, 224),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
