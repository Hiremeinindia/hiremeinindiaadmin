import 'package:flutter/material.dart';

@immutable
final class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  final List<Color>? colors;
  final double? dynamicHeight;
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.colors,
    this.dynamicHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.indigo.shade900,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(0.1), // Adjust border radius as needed
          ),
        ),
        child: Text(
          text,
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
