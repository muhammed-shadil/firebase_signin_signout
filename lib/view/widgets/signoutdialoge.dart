
import 'package:firebase_login/view/screen/homepage.dart';
import 'package:firebase_login/view/screen/loginpage.dart';
import 'package:flutter/material.dart';

Future signoutdialoge(context) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Signout'),
          content: const Text('do you want to signout?'),
          actions: [
            OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('cancel')),
            OutlinedButton(
                onPressed: () {
                  authentication.signout(context);
                  // Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>loginpage()), (route) => false);
                },
                child: const Text("signout"))
          ],
        );
      });
}
