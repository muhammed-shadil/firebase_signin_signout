import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/controller/auth_controller.dart';
import 'package:firebase_login/controller/image_controler.dart';
import 'package:firebase_login/model/user_model.dart';
import 'package:firebase_login/view/screen/deletetepage.dart';
import 'package:firebase_login/view/widgets/custombutton1.dart';
import 'package:firebase_login/view/widgets/customcontainertile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

Authontification authentication = Authontification();

class _HomepageState extends State<Homepage> {
  void selectImage(String? email) async {
    String? img = await pickImage(context, ImageSource.gallery, email);
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
        title: const Text(
          'HOME',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              authentication.signout(context);
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
              Center(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('email', isEqualTo: user!.email)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60,
                        child: Icon(
                          Icons.image,
                          size: 100,
                        ),
                      );
                    }
                    var userr = snapshot.data?.docs.isNotEmpty ?? false
                        ? snapshot.data!.docs[0].data()
                        : null;
                    var imageUrl = (userr as Map<String, dynamic>?)?["image"];

                    return Stack(children: [
                      imageUrl != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(imageUrl!),
                            )
                          : const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
                              child: Icon(
                                Icons.image,
                                size: 90,
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
                                  selectImage(usermode.email);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  size: 17,
                                )),
                          ))
                    ]);
                  },
                ),
              ),
              StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(user!.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final userData =
                          snapshot.data?.data() as Map<String, dynamic>?;
                      if (userData != null) {
                        return Container(
                            child: Column(children: [
                          SizedBox(
                            height: 90,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                '${userData['username']}'.toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                            ),
                          ),
                          Profiletile(
                            label: 'EMAIL',
                            content: userData['email'],
                          ),
                          Profiletile(
                            label: 'PHONE',
                            content: userData['phone'],
                          ),
                          Profiletile(
                            label: 'AGE',
                            content: userData['age'],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          custombutton(
                              text: "DELETE",
                              onpressed: () {
                                delete(usermode.email, context);
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          custombutton(
                              text: "SIGNOUT",
                              onpressed: () async {
                                authentication.signout(context);
                              })
                        ]));
                      } else {
                        return const Center(
                          child: Text("null"),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text(
                              "Error fetching user data: ${snapshot.error}"));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
