import 'package:firebase_login/controller/image_controler.dart';
import 'package:firebase_login/view/screen/homepage.dart';
import 'package:firebase_login/view/widgets/CUSTOMbutton2.dart';
import 'package:firebase_login/view/widgets/customtextfield1.dart';
import 'package:firebase_login/view/widgets/sizedbox20.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Editpage extends StatefulWidget {
  const Editpage({super.key, required this.userData1});
  final Map<String, dynamic> userData1;

  @override
  State<Editpage> createState() => _EditpageState();
}

class _EditpageState extends State<Editpage> {
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

  void selectImage(String? email) async {
    String? img = await pickImage(context, ImageSource.gallery, email);
    setState(() {
      imageUrl = img;
    });
  }

  @override
  void initState() {
    emailcontroller.text = widget.userData1['email'] ?? '';
    agecontroller.text = widget.userData1['age'] ?? '';
    usernamecontroller.text = widget.userData1['username'] ?? '';
    phonecontroller.text = widget.userData1['phone'] ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var imgurl = widget.userData1['image'];
    //
    return Scaffold(
      backgroundColor: Colors.grey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "EDIT",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Center(
                    child: Stack(children: [
                  imgurl == null
                      ? const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          child: Icon(
                            Icons.person_4_outlined,
                            color: Colors.black,
                            size: 60,
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(imgurl!),
                          radius: 50,
                        ),
                  // Positioned(
                  //   bottom: -7,
                  //   right: -7,
                  //   child: IconButton(
                  //       onPressed: () {
                  //         selectImage(emailcontroller.text);
                  //       },
                  //       icon: const Icon(
                  //         Icons.add_a_photo_outlined,
                  //         size: 20,
                  //         color: Colors.black,
                  //       )),
                  // )
                ])),
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
                      } else {
                        return null;
                      }
                    },
                    icon: Icons.contact_page_outlined,
                    text: "USER NAME"),
                const Sizedbox20(),
                CustomTextfield(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter a valid email";
                      } else if (!regemail.hasMatch(value)) {
                        return "please enter a valid email";
                      } else {
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
                      } else {
                        return null;
                      }
                    },
                    icon: Icons.calendar_month,
                    text: "AGE"),
                const Sizedbox20(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      custombutton2(
                          text: "CANCEL",
                          onpressed: () async {
                            Navigator.pop(context);
                          }),
                      custombutton2(
                          text: "UPDATE",
                          onpressed: () {
                            if (formKey.currentState!.validate()) {
                              authentication.updateddata(
                                  agecontroller.text,
                                  phonecontroller.text,
                                  usernamecontroller.text,
                                  emailcontroller.text);
                              Navigator.pop(context);
                            }
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
