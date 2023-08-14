import 'package:flutter/material.dart';

class MyTextFieldB extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextFieldB({
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
              borderSide: BorderSide(color: Color.fromARGB(0, 3, 173, 240))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(0, 96, 125, 139))),
          fillColor: Color.fromARGB(255, 3, 173, 240).withOpacity(0.2),
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Color.fromARGB(255, 3, 173, 240),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
