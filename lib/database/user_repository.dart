// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/username_page.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db
        .collection("users")
        .add(user.toJson())
        .whenComplete(() => GetSnackBar(
              title: "Success",
              message: "Your account has been created",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Color.fromARGB(255, 242, 190, 2),
            ))
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong.Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color.fromARGB(255, 242, 2, 54));
      print(error.toString());
    });
  }
}
