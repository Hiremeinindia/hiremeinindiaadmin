import 'package:flutter/material.dart';

class HireMeInIndia extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;

  const HireMeInIndia({
    required this.text1,
    required this.text2,
    required this.text3,
    this.size,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text1,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.indigo.shade900,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  fontSize: 25),
            ),
            TextSpan(
              text: text2,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Color.fromARGB(255, 27, 105, 178),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  fontSize: 25),
            ),
            TextSpan(
              text: text3,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: const Color.fromARGB(255, 117, 115, 115),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
