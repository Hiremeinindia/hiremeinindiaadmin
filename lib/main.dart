import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiremeinindiaapp/homepage.dart';
import 'package:hiremeinindiaapp/loginpage.dart';
import 'package:hiremeinindiaapp/registration.dart';
import 'package:hiremeinindiaapp/repository/authentication_repository.dart';
import 'package:hiremeinindiaapp/signuppage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Initializing Firebase...");
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyBKUuhUeiA2DpvZD4od15RdHEBZyjsuVlA',
    appId: '1:316659430730:web:1afaddd5a3f41be5cffdb3',
    messagingSenderId: '316659430730',
    projectId: 'hiremeinindia-14695',
    authDomain: 'hiremeinindia-14695.firebaseapp.com',
    databaseURL:
        'https://hiremeinindia-14695-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'hiremeinindia-14695.appspot.com',
    measurementId: 'G-KVMWVJ99JL',
  )).then((value) => Get.put(AuthenticationRepository()));
  print("Firebase initialized successfully!");
  runApp(HireApp());
}

class HireApp extends StatelessWidget {
  const HireApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return Registration();
            }
          }),
    );
  }
}
