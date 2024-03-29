import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/model/user_model.dart';
import 'package:firebase_login/view/screen/homepageog.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authontification {
  static signin(String email, String password, context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("you are Logged in"),
        ),
      );
      Navigator.pushNamed(
        context,
        '/home',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  "No user Found with this email or password did not match")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  static signup(String age, String phone, String username, String email,
      String password, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(email);

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = FirebaseAuth.instance.currentUser;

      usermodel usermode = usermodel();

      usermode.uid = user!.uid;
      usermode.email = user.email;
      usermode.age = age;
      usermode.phone = phone;
      usermode.username = username;

      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(usermode.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registeratered Successfully"),
        ),
      );
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password Provided Is Too Weak"),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email Provided Already Exists"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  static void deleteAccount(String email, String pass, context) async {
    User? user = FirebaseAuth.instance.currentUser;

    bool isGoogleSignIn = user!.providerData
        .any((userInfo) => userInfo.providerId == 'google.com');
    // print('Is Google Sign-in: $isGoogleSignIn');

    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: pass);

    AuthCredential credential2 = GoogleAuthProvider.credential(
      idToken: await user.getIdToken(),
      accessToken: await user.getIdToken(),
    );

    await GoogleSignIn().signOut();

    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .delete()
          .then((value) => (isGoogleSignIn)
              ? user.reauthenticateWithCredential(credential2).then(
                  (value) {
                    value.user!.delete();
                    

                    // print("ggggooogggglllleeeeeellllll dddeeellettetect");
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(
                    //     content: Text("Account deleted"),
                    //   ),
                    // );
                  },
                )
              : user.reauthenticateWithCredential(credential).then(
                  (value) {
                    value.user!.delete();
                    // print("onoooooorrrrmmmmaaalllllll dddeeellettetect");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Account deleted"),
                      ),
                    );
                  },
                ));
    } catch (e) {
      // Fluttertoast.showToast(msg: 'Error deleting account${e.toString()}');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text("Error deleting account!${e.toString()}"),
      //   ),
      // );
    }
  }

  Future<void> signout(context) async {
    try {
      await FirebaseAuth.instance
          .signOut()
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("signout"),
                ),
              ));

      await GoogleSignIn().signOut();

      // print("sighnouteeeedddddddddddddd");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error ,while signout!${e.toString()}"),
        ),
      );
    }
  }

  static signInWithGoogle(context) async {
    try {
      GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: ['email']).signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        await saveUserFirestore(userCredential.user!, context);

        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const Homepages()));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("login with google account"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error sign in with google ${e.toString()}"),
        ),
      );
    }
  }

  static Future<void> saveUserFirestore(User user, context) async {
    try {
      CollectionReference userCollection =
          FirebaseFirestore.instance.collection('users');

      DocumentSnapshot docSnapshot = await userCollection.doc(user.uid).get();

      if (!docSnapshot.exists) {
        await userCollection.doc(user.uid).set({
          'username': user.displayName,
          'email': user.email,
          'uid': user.uid,
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Error ,saving user data to Firestore: ${e.toString()}'),
        ),
      );
    }
  }

  updateddata(String age, String phone, String username, String email) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    usermodel usermode = usermodel();

    usermode.uid = user!.uid;
    usermode.email = email;
    usermode.age = age;
    usermode.phone = phone;
    usermode.username = username;
    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .update(usermode.toMap());

    try {
      await user.verifyBeforeUpdateEmail(user.email!);
      // user.sendEmailVerification();
    } catch (e) {
      // print("Error updating email: $e");
    }
  }
}
