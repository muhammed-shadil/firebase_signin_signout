import 'package:firebase_login/controller/auth_controller.dart';
import 'package:firebase_login/view/widgets/custombutton1.dart';
import 'package:firebase_login/view/widgets/customtextfield1.dart';
import 'package:firebase_login/view/widgets/sizedbox20.dart';
import 'package:flutter/material.dart';

// class DeleteButton extends StatelessWidget {
//   DeleteButton({
//     super.key,
//   });

final TextEditingController emailontroller = TextEditingController();
final TextEditingController passcontroller = TextEditingController();

final regemail = RegExp(r"^[a-zA-Z0-9_\-\.\S]{4,}[@][a-z]+[\.][a-z]{2,3}$");
final paswd =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

// @override
// Widget build(BuildContext context) {
//   return FloatingActionButton(
//     child: const Icon(Icons.add),

//     onPressed: () async {

final formKey = GlobalKey<FormState>();
Future<void> delete(email, context) async {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        contentPadding: const EdgeInsets.all(20),
        title: const Text(
          "Delete account",
          style: TextStyle(color: Colors.redAccent),
        ),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextfield(
                    validator: (value) {
                      if (value == null || value.isEmpty  ) {
                        return "please enter correct email";
                      } else if (!regemail.hasMatch(value)) {
                        return "please enter a valid email";
                      } else if (value!=email) {
                        return "you entered wrong email";
                      }
                    },
                    controller: emailontroller,
                    icon: Icons.email_outlined,
                    text: "Enter Email"),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter valid password";
                      } else if (!paswd.hasMatch(value)) {
                        return 'Password should contain at least one upper case, \n one lower case, one digit, one special character and \n must be 8 characters in length';
                      }
                    },
                    controller: passcontroller,
                    icon: Icons.lock_open_rounded,
                    text: "Enter Password"),
              ],
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  emailontroller.clear();
                  passcontroller.clear();
                },
                child: const Text('cancel'),
              ),
              const SizedBox(
                height: 10,
                width: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (
                        formKey.currentState!.validate()) {
                      Authontification.deleteAccount(
                          emailontroller.text, passcontroller.text, context);

                      emailontroller.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('delete')),
            ],
          )
        ],
      );
    },
  );
}
//     );
//   }
// }
