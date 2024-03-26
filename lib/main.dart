import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login/view/screen/homepageog.dart';
import 'package:firebase_login/view/screen/loginpage.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (ConnectionState.waiting == snapshot.connectionState) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  return const Homepages();
                } else {
                  return loginpage();
                }
              })),
      routes: {
        '/login': (context) => loginpage(),
        '/home': (context) => const Homepages(),
      },
    );
  }
}
