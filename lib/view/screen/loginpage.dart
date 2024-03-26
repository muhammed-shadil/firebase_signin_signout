import 'package:firebase_login/controller/auth_controller.dart';
import 'package:firebase_login/view/screen/signuppage.dart';
import 'package:firebase_login/view/widgets/custombutton1.dart';
import 'package:firebase_login/view/widgets/customtextfield1.dart';
import 'package:firebase_login/view/widgets/sizedbox20.dart';
import 'package:flutter/material.dart';

class loginpage extends StatefulWidget {
  loginpage({
    super.key,
  });

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController passcontroller = TextEditingController();

  TextEditingController emailontroller = TextEditingController();

  final regemail = RegExp(r"^[a-zA-Z0-9_\-\.\S]{4,}[@][a-z]+[\.][a-z]{2,3}$");

  final paswd =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  bool _isLoading = false;

  final formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        padding: const EdgeInsets.all(25),
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
        child: Stack(children: [
          SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        "LOG IN",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  CustomTextfield(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter a email";
                        } else if (!regemail.hasMatch(value)) {
                          return "please enter a valid email";
                        } else {
                          return null;
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
                        } else {
                          return null;
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
                            // Authontification.signin(emailontroller.text,
                            //     passcontroller.text, context);
                            // emailontroller.clear();
                            // passcontroller.clear();
                            _login();
                          }
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
                        width: MediaQuery.of(context).size.width * .37,
                        child: const Divider(
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        " OR ",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .37,
                        child: const Divider(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  const Sizedbox20(),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Authontification.signInWithGoogle(context);
                      },
                      child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
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
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
        ]),
      ),
    );
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    await Authontification.signin(
      emailontroller.text,
      passcontroller.text,
      scaffoldKey.currentState!.context,
    );

    emailontroller.clear();
    passcontroller.clear();

    setState(() {
      _isLoading = false;
    });
  }
}
