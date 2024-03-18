import 'package:firebase_login/controller/auth_controller.dart';
import 'package:firebase_login/view/screen/homepage.dart';
import 'package:firebase_login/view/screen/signuppage.dart';
import 'package:firebase_login/view/widgets/custombutton1.dart';
import 'package:firebase_login/view/widgets/customtextfield1.dart';
import 'package:firebase_login/view/widgets/sizedbox20.dart';
import 'package:flutter/material.dart';

class loginpage extends StatelessWidget {
  loginpage({
    super.key,
  });
  TextEditingController passcontroller = TextEditingController();

  TextEditingController emailontroller = TextEditingController();
  final regemail = RegExp(r"^[a-zA-Z0-9_\-\.\S]{4,}[@][a-z]+[\.][a-z]{2,3}$");
  final paswd =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          transform: GradientRotation(7),
          colors: [
            Color.fromARGB(255, 198, 9, 231),
            Colors.deepPurple,
            Colors.lightBlue,
            Colors.indigo,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 220,
                child: Center(
                  child: Text(
                    "LOG IN",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              CustomTextfield(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter a email";
                    } else if (!regemail.hasMatch(value)) {
                      return "please enter a valid email";
                    }
                  },
                  controller: emailontroller,
                  icon: Icons.email_outlined,
                  text: "Enter Email"),
              const Sizedbox20(),
              CustomTextfield(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter a password";
                    } else if (!paswd.hasMatch(value)) {
                      return 'Password should contain at least one upper case, \n one lower case, one digit, one special character and \n must be 8 characters in length';
                    }
                  },
                  controller: passcontroller,
                  icon: Icons.lock_open_rounded,
                  text: "Enter Password"),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: custombutton(
                    text: "LOG IN",
                    onpressed: () async {
                      if (formKey.currentState!.validate()) {
                        Authontification.signin(
                            emailontroller.text, passcontroller.text, context);
                            emailontroller.clear();
                            passcontroller.clear();                       }
                    }),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Dont't have account ",
                    style: TextStyle(color: Colors.white54),
                  ),
                  GestureDetector(
                    child: const Text(
                      " Sign Up",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SignupPage(),
                        ),
                      );
                    },
                  )
                ],
              ),
              const Sizedbox20(),
               Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*.43,
                    child: const Divider(
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    " OR ",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*.41,
                    child: const Divider(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const Sizedbox20(),
              Center(
                child: GestureDetector(onTap: (){Authontification.signInWithGoogle(context);},
                  child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: const Image(
                          image: AssetImage(
                        "assets/google.png",
                        // fit: BoxFit.fill,
                      ))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
