import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/widgets/customtextstyle.dart';
import 'package:hiremeinindiaapp/widgets/textstylebutton.dart';

@immutable
final class CustomTextfield extends StatelessWidget {
  Function(String)? onsaved;
  final String text;
  final String? text1;
  final TextEditingController? controller;
  final List<Color>? colors;
  final double? dynamicHeight;

  CustomTextfield({
    this.controller,
    super.key,
    this.text1,
    required this.text,
    this.colors,
    this.dynamicHeight,
    this.onsaved,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: text,
          errorText: text1,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(1))),
        ),
      ),
    );
  }
}
