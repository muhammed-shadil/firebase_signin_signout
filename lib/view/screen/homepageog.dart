import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/view/screen/homepage.dart';
import 'package:firebase_login/view/widgets/signoutdialoge.dart';
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
        iconTheme: const IconThemeData(color: Colors.white),
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
                child: StreamBuilder<DocumentSnapshot>(
                  stream: user.doc(userss!.uid).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final userData =
                          snapshot.data!.data() as Map<String, dynamic>?;
                      final username = userData!['username'];
                      return UserAccountsDrawerHeader(
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          accountName: Text(
                            username.toString().toUpperCase(),
                            style: const TextStyle(fontSize: 18),
                          ),
                          accountEmail: Text(
                            userData['email'],
                          ),
                          currentAccountPictureSize: const Size.square(50),
                          currentAccountPicture: userData['image'] != null
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(userData['image']),
                                )
                              : const CircleAvatar(
                                  child: Icon(Icons.person_3_outlined),
                                ));
                    }
                    return const CircularProgressIndicator();
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Profilepage()));
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text(' settings '),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 180,
                      child: OutlinedButton(
                        onPressed: () async {
                          await signoutdialoge(context);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("SIGN OUT "),
                            Icon(Icons.login_outlined)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
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
                    itemBuilder: (context, index) {
                      final userdata = snapshot.data!.docs[index].data();

                      final image = userdata['image'];

                      return GestureDetector(
                        onTap: () {
                          // print("user      dfdfdfdfdid    ${userss!.email}");

                          if (userss!.uid == userdata['uid']) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const Profilepage()));
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
