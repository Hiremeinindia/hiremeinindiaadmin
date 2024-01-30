import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/adminconsole.dart';
import 'package:flutter_application_1/admintest.dart';

Future<void> main() async {
  print("Initializing Firebase...");
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBKUuhUeiA2DpvZD4od15RdHEBZyjsuVlA",
          authDomain: "hiremeinindia-14695.firebaseapp.com",
          databaseURL:
              "https://hiremeinindia-14695-default-rtdb.asia-southeast1.firebasedatabase.app",
          projectId: "hiremeinindia-14695",
          storageBucket: "hiremeinindia-14695.appspot.com",
          messagingSenderId: "316659430730",
          appId: "1:316659430730:web:b340e5bd5b9ca6e0cffdb3",
          measurementId: "G-RQLDRBK5CL"));
  print("Firebase initialized successfully!");
  runApp(const MyApp());
  final server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);

  print('Server listening on port 8080');

  await for (var request in server) {
    if (request.method == 'POST') {
      try {
        final body = await utf8.decoder.bind(request).join();
        final data = json.decode(body);

        if (data['paymentType'] == 'cash') {
          print('Cash payment received and verified.');
        }
      } catch (e) {
        print('Error processing request: $e');
      }

      request.response
        ..statusCode = HttpStatus.ok
        ..write('Notification received');
      await request.response.close();
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: AdminConsole1(),
    );
  }
}
