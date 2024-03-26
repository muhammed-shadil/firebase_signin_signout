import 'package:firebase_login/controller/auth_controller.dart';
import 'package:firebase_login/view/widgets/custombutton1.dart';
import 'package:firebase_login/view/widgets/customtextfield1.dart';
import 'package:firebase_login/view/widgets/sizedbox20.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passcontroller = TextEditingController();

  TextEditingController agecontroller = TextEditingController();

  TextEditingController usernamecontroller = TextEditingController();

  TextEditingController phonecontroller = TextEditingController();

  final regemail = RegExp(r"^[a-zA-Z0-9_\-\.\S]{4,}[@][a-z]+[\.][a-z]{2,3}$");

  final phonreg = RegExp(r"^[6789]\d{9}$");

  final paswd =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  final name = RegExp(r'^[A-Za-z]+$');

  final age = RegExp(r"^[0-9]{1,2}$");

  final formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            transform: GradientRotation(8),
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
        child: Stack(children: [
          SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  const Center(
                    child: Text(
                      "Sign Up",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextfield(
                      controller: usernamecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter name";
                        } else if (!name.hasMatch(value)) {
                          return "enter a valid name";
                        }else{
                          return null;
                        }
                      },
                      icon: Icons.contact_page_outlined,
                      text: "USER NAME"),
                  const Sizedbox20(),
                  CustomTextfield(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter a password";
                        } else if (!paswd.hasMatch(value)) {
                          return 'Password should contain at least one upper case, one lower case, one digit, one special character and  must be 8 characters in length';
                        }else{
                          return null;
                        }
                      },
                      controller: passcontroller,
                      icon: Icons.lock_open,
                      text: "PASSWORD"),
                  const Sizedbox20(),
                  CustomTextfield(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter a valid email";
                        } else if (!regemail.hasMatch(value)) {
                          return "please enter a valid email";
                        }else{
                          return null;
                        }
                      },
                      controller: emailcontroller,
                      icon: Icons.email_outlined,
                      text: "EMAIL"),
                  const Sizedbox20(),
                  CustomTextfield(
                      controller: phonecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter phone number";
                        } else if (value.length > 10) {
                          return "number must be 10";
                        } else if (!phonreg.hasMatch(value)) {
                          return "please enter a valid number";
                        }
                        return null;
                      },
                      icon: Icons.phone_android_sharp,
                      text: "PHONE NUMBER"),
                  const Sizedbox20(),
                  CustomTextfield(
                      controller: agecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter the age ";
                        } else if (int.parse(value) < 18) {
                          return "age is must be above 18";
                        } else if (!age.hasMatch(value)) {
                          return "please enter a valid age";
                        }else{
                          return null;
                        }
                      },
                      icon: Icons.calendar_month,
                      text: "AGE"),
                  const Sizedbox20(),
                  custombutton(
                      text: "Sign up",
                      onpressed: () async {
                        if (formKey.currentState!.validate()) {
                          _signup();
                        }
                      }),
                ],
              ),
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
        ]),
      ),
    );
  }

  Future<void> _signup() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Authontification.signup(
          agecontroller.text,
          phonecontroller.text,
          usernamecontroller.text,
          emailcontroller.text,
          passcontroller.text,
          context);

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print('signup failed: $error');

      setState(() {
        _isLoading = false;
      });
    }
  }
}
