import 'package:flutter/material.dart';

class Sample extends StatefulWidget {
  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  bool isCheckboxEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            // Enable the checkbox when the button is pressed
            setState(() {
              isCheckboxEnabled = true;
            });
          },
          child: Text('Enable Checkbox'),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Checkbox(
                value: isCheckboxEnabled,
                onChanged: (value) {
                  // You can add your logic here when the checkbox is changed
                  setState(() {
                    isCheckboxEnabled = value ?? false;
                  });
                },
              ),
            ),
            Text('My Checkbox'),
          ],
        ),
      ],
    );
  }
}
