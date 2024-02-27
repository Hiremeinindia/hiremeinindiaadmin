import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/adminRegistration.dart';
import 'package:flutter_application_1/adminconsole.dart';
import 'package:flutter_application_1/admintest.dart';
import 'package:provider/provider.dart';

import 'classes/language_constants.dart';
import 'functions/firestoreservice.dart';
import 'gen_l10n/app_localizations.dart';
import 'sample.dart';

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
  runApp(const HireApp());
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

class HireApp extends StatefulWidget {
  const HireApp({Key? key});

  @override
  State<HireApp> createState() => _HireAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _HireAppState? state = context.findAncestorStateOfType<_HireAppState>();
    state?.setLocale(newLocale);
  }
}

class _HireAppState extends State<HireApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseService()),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        debugShowCheckedModeBanner: false,
        home: AdminRegistration(),
      ),
    );
  }
}
