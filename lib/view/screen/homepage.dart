import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/controller/auth_controller.dart';
import 'package:firebase_login/controller/image_controler.dart';
import 'package:firebase_login/model/user_model.dart';
import 'package:firebase_login/view/screen/deletetepage.dart';
import 'package:firebase_login/view/screen/editscreen.dart';
import 'package:firebase_login/view/screen/loginpage.dart';
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
  // usermodel usermode = usermodel();
  @override
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:Colors.grey[100] ,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        title: const Text(
          'PROFILE',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('signout'),
                      content: const Text('do you want to signout'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('cancel')),
                        TextButton(
                            onPressed: () {
                              authentication.signout(context);
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                            },
                            child: Text("signout"))
                      ],
                    );
                  });
            },
            icon: const Icon(
              Icons.login_outlined,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Center(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(user!.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  final userData =
                      snapshot.data?.data() as Map<String, dynamic>?;
                  // final imageUrl = userData!['image'];

                  var imageUrl = (userData as Map<String, dynamic>?)?["image"];
                  if (userData != null) {
                    return Column(
                      children: [
                        Stack(children: [
                          imageUrl != null
                              ? CircleAvatar(
                                  radius: 70,
                                  backgroundImage: NetworkImage(imageUrl!),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.blue[100],
                                  radius: 50,
                                  child: const Icon(
                                    Icons.image,
                                    color: Colors.black,
                                    size: 70,
                                  ),
                                ),
                          Positioned(
                            bottom: -7,
                            right: -7,
                            child: IconButton(
                                onPressed: () {
                                  selectImage(userData['email']);
                                },
                                icon: const Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 20,
                                  color: Colors.black,
                                )),
                          )
                        ]),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(
                                      0.0,
                                      2.0,
                                    ),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(.0, -2.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                ],
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[300]),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 40,
                                  child: Text(
                                    '${userData['username']}'.toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ),
                              ),
                              Profiletile(
                                label: 'EMAIL',
                                content: userData['email'],
                              ),
                              (userData['phone'] != null)
                                  ? Profiletile(
                                      label: 'PHONE',
                                      content: userData['phone'],
                                    )
                                  : Container(),
                              (userData['age'] != null)
                                  ? Profiletile(
                                      label: 'AGE',
                                      content: userData['age'],
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 24,
                              ),
                              SizedBox(
                                width: 200,
                                child: Column(
                                  children: [
                                    custombutton(
                                        btncolor: Colors.red[300],
                                        text: "DELETE",
                                        onpressed: () {
                                          delete(userData['email'], context);
                                        }),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    custombutton(
                                        btncolor: Colors.blue[200],
                                        text: "EDIT",
                                        onpressed: () async {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => Editpage()),
                                              (Route<dynamic> route) => false);
                                        })
                                  ],
                                ),
                              )
                            ])),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text("null"),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Center(
                      child:
                          Text("Error fetching user data: ${snapshot.error}"));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
