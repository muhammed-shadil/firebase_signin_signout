import 'package:firebase_login/controller/auth_controller.dart';
import 'package:firebase_login/view/widgets/custombutton1.dart';
import 'package:firebase_login/view/widgets/customtextfield1.dart';
import 'package:firebase_login/view/widgets/sizedbox20.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
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
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const CustomTextfield(
                    icon: Icons.contact_page_outlined, text: "USER NAME"),
                const Sizedbox20(),
                CustomTextfield(
                    controller: passcontroller,
                    icon: Icons.lock_open,
                    text: "PASSWORD"),
                const Sizedbox20(),
                CustomTextfield(
                    controller: emailcontroller,
                    icon: Icons.email_outlined,
                    text: "EMAIL"),
                const Sizedbox20(),
                const CustomTextfield(
                    icon: Icons.phone_android_sharp, text: "PHONE NUMBER"),
                const Sizedbox20(),
                const CustomTextfield(icon: Icons.calendar_month, text: "AGE"),
                const Sizedbox20(),
                custombutton(
                    text: "Sign up",
                    onpressed: () async {
                      await Authontification.signup(
                          emailcontroller.text, passcontroller.text, context);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
