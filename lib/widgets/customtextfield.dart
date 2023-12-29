import 'package:flutter/material.dart';

@immutable
final class CustomTextfield extends StatelessWidget {
  Function(String)? onsaved;
  final String? text;
  final String? text1;
  final TextEditingController? controller;
  final List<Color>? colors;
  final double? dynamicHeight;
  String? Function(String?)? validator;

  CustomTextfield({
    this.controller,
    super.key,
    this.text1,
    this.text,
    this.colors,
    this.dynamicHeight,
    this.onsaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          errorText: text1,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(1))),
        ),
      ),
    );
  }
}
