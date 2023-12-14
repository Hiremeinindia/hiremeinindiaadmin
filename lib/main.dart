import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hiremeinindiaapp/adminconsole.dart';
import 'package:hiremeinindiaapp/corporatecon.dart';
import 'package:hiremeinindiaapp/corporateconsole.dart';
import 'package:hiremeinindiaapp/exmple.dart';
import 'package:hiremeinindiaapp/gethired.dart';
import 'package:hiremeinindiaapp/homepage.dart';
import 'package:hiremeinindiaapp/userpayment.dart';
import 'package:hiremeinindiaapp/registration.dart';
import 'package:hiremeinindiaapp/userdashboard.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en_US',
      supportedLocales: ['en_US', 'es', 'fa', 'ar', 'ru']);

  runApp(LocalizedApp(delegate, HireApp()));
}

class HireApp extends StatelessWidget {
  const HireApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('hi'),
      ],
      translations: LocalString(),
      locale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      home: Registration(),
    );
  }
}
