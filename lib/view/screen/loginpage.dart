import 'package:firebase_login/controller/auth_controller.dart';
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
        child: Column(
          children: [
            const SizedBox(
              height: 300,
              child: Center(
                child: Text(
                  "LOG IN",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
              ),
            ),
            CustomTextfield(
                controller: emailontroller,
                icon: Icons.email_outlined,
                text: "Enter Email"),
            const Sizedbox20(),
            CustomTextfield(
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
                  Authontification.signin(
                      emailontroller.text, passcontroller.text, context);
                },
              ),
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
            const Row(
              children: [
                SizedBox(
                  width: 165,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                Text(
                  " OR ",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 165,
                  child: Divider(
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const Sizedbox20(),
            Center(
              child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  child: const Image(
                      image: AssetImage(
                    "assets/google.png",
                    // fit: BoxFit.fill,
                  ))),
            )
          ],
        ),
      ),
    );
  }
}
