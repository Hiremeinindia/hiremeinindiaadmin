import 'package:flutter/material.dart';

import '../classes/language_constants.dart';
import 'customcard.dart';
import 'textstylebutton.dart';

@immutable
final class CustomButton extends StatelessWidget {
  final String? text;
  Widget? child;
  final Function()? onPressed;

  final List<Color>? colors;
  final double? dynamicHeight;
  CustomButton({
    super.key,
    this.text,
    this.onPressed,
    this.colors,
    this.dynamicHeight,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromWidth(double.infinity),
          primary: Colors.indigo.shade900,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(0.1), // Adjust border radius as needed
          ),
        ),
        child: Text(
          text!,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

@immutable
final class CustomButtonLogin extends StatelessWidget {
  late final String? text;
  Widget? child;
  late final Function()? onPressed;

  late final List<Color>? colors;
  late final double? dynamicHeight;
  CustomButtonLogin({
    super.key,
    this.text,
    this.onPressed,
    this.colors,
    this.dynamicHeight,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo.shade900,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(0.1), // Adjust border radius as needed
            ),
          ),
          child: child),
    );
  }
}

@immutable
final class ViewButton extends StatelessWidget {
  Widget? child;
  final Function()? onPressed;
  IconData? icon;

  ViewButton({
    super.key,
    this.onPressed,
    this.icon,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromWidth(double.infinity),
          primary: Colors.indigo.shade900,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(0.1), // Adjust border radius as needed
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
