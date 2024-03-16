import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/controller/image_controler.dart';
import 'package:firebase_login/model/user_model.dart';
import 'package:firebase_login/view/widgets/custombutton1.dart';
import 'package:firebase_login/view/widgets/customcontainertile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void selectImage() async {
    String? img = await pickImage(context, ImageSource.gallery);
    setState(() {
      imageUrl = img;
      print(imageUrl);
    });
  }
  

  User? user = FirebaseAuth.instance.currentUser;
  usermodel usermode = usermodel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.usermode = usermodel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: const Text('HOME',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.login_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(children: [
                imageUrl != null
                
                    ? CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(imageUrl!),
                      )
                    : const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60,
                        child: Icon(
                          Icons.image,
                          size: 100,
                        ),
                      ),
                Positioned(
                    bottom: 4,
                    right: 4,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      child: IconButton(
                          onPressed: () {
                            selectImage();
                          },
                          icon: const Icon(
                            Icons.edit,
                            size: 17,
                          )),
                    ))
              ]),
              SizedBox(
                height: 90,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '${usermode.username}'.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
              Profiletile(
                label: 'EMAIL',
                content: usermode.email,
              ),
              Profiletile(
                label: 'PHONE',
                content: usermode.phone,
              ),
              Profiletile(
                label: 'AGE',
                content: usermode.age,
              ),
              const SizedBox(
                height: 30,
              ),
              custombutton(text: "DELETE", onpressed: () {}),
              const SizedBox(
                height: 20,
              ),
              custombutton(
                  text: "SIGNOUT",
                  onpressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
