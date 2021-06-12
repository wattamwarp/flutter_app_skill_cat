
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_skill_cat/Pages/LandinPage.dart';

class SignupService{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void createUser(String email, String password, BuildContext context) {
    firebaseAuth
        .createUserWithEmailAndPassword(
        email: email, password: password)
        .then((result) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );

    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }
}