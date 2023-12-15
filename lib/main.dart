import 'package:flutter/material.dart';

import 'registration.dart';

void main() {
  runApp(HireApp());
}

class HireApp extends StatelessWidget {
  const HireApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Registration(),
    );
  }
}
