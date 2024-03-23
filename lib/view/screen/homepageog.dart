import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/view/screen/homepage.dart';
import 'package:flutter/material.dart';

class Homepages extends StatefulWidget {
  const Homepages({super.key});

  @override
  State<Homepages> createState() => _HomepagesState();
}

class _HomepagesState extends State<Homepages> {
  final CollectionReference user =
      FirebaseFirestore.instance.collection('users');
  final userss = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          'All user',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
          width: 250,
          backgroundColor: Colors.grey[200],
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/bck.jpeg"), opacity: 0.6),
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: user.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final userData =
                          snapshot.data!.docs[0].data() as Map<String, dynamic>;
                      final username = userData['username'];
                      return UserAccountsDrawerHeader(
                        decoration: BoxDecoration(color: Colors.transparent),
                        accountName: Text(
                          username.toString().toUpperCase(),
                          style: TextStyle(fontSize: 18),
                        ),
                        accountEmail: Text(
                          userData['email'],
                        ),
                        currentAccountPictureSize: Size.square(50),
                        currentAccountPicture: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(userData['image']),
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.people_outline_outlined),
                title: const Text(' My users '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_4_outlined),
                title: const Text(' my profile '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text(' settings '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: StreamBuilder(
            stream: user.orderBy('email').snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        ),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, Index) {
                      final userdata = snapshot.data!.docs[Index].data();

                      final image = userdata['image'];
                      final ss = userdata['email'];
                      return GestureDetector(
                        onTap: () {
                          // print("user      dfdfdfdfdid    ${userss!.email}");

                          if (userss!.email == userdata['email']) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Homepage()));
                          }

                          // print("userdid   ${ss}");
                        },
                        child: Card(
                          color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 15, bottom: 15),
                            child: Row(
                              children: [
                                (image == null)
                                    ? const Expanded(
                                        flex: 1,
                                        child: CircleAvatar(
                                          child: Icon(Icons.person),
                                        ))
                                    : Expanded(
                                        flex: 1,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(image),
                                        )),
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(userdata['username']
                                          .toString()
                                          .toUpperCase()),
                                      Text(userdata['email']),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
              return Container();
            }),
      ),
    );
  }
}
