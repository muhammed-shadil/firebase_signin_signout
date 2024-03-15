

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/model/user_model.dart';
import 'package:firebase_login/view/screen/homepage.dart';
import 'package:flutter/material.dart';

class Authontification {
  static signin(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("you are Logged in"),
        ),
      );
      Navigator.push(context, MaterialPageRoute(builder: (_) => Homepage()));
    }
     on FirebaseAuthException catch (e) {
      
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No user Found with this email")),
        );
      } else if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("password did not match"),
          ),
        );
      }
    }
     catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      print(e.toString());
      // print();
    }
  }

  static signup(String age, String phone, String username, String email,
      String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(email);

      
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = FirebaseAuth.instance.currentUser;

      usermodel usermode = usermodel();

      usermode.uid = user!.uid;
      usermode.email = user!.email;
      usermode.age = age;
      usermode.phone = phone;
      usermode.username = username;
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(usermode.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registeratered Successfully"),
        ),
      );
    } 
    on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password Provided Is Too Weak"),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email Provided Already Exists"),
          ),
        );
      }
    } 
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );print(e.toString());
    }
  }
}
