import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/userpayment.dart';
import 'package:hiremeinindiaapp/widgets/customtextfield.dart';

import 'widgets/custombutton.dart';
import 'widgets/hiremeinindia.dart';

class NewUserUpload extends StatefulWidget {
  const NewUserUpload();
  @override
  State<NewUserUpload> createState() => _NewUserUpload();
}

class _NewUserUpload extends State<NewUserUpload> {
  @override
  bool isChecked = false;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: HireMeInIndia(text1: 'Hire', text2: 'mein', text3: 'India'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 50.0, top: 10),
            child: Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 170,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade900,
                      ),
                      child: DropdownButton<String>(
                        items: [
                          DropdownMenuItem<String>(
                            value: 'English',
                            child: Text('English'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Hindi',
                            child: Text('Hindi'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Spanish',
                            child: Text('Spanish'),
                          ),
                          // Add more languages as needed
                        ],
                        onChanged: (value) {
                          // Handle language selection
                        },
                        hint: Text(
                          '  English        ',
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        underline: Container(),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  height: 30,
                  width: 170,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade900,
                      ),
                      child: DropdownButton<String>(
                        items: [
                          DropdownMenuItem<String>(
                            value: 'Option 1',
                            child: Text('Option 1'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Option 2',
                            child: Text('Option 1'),
                          ),
                          // Add more options as needed
                        ],
                        onChanged: (value) {
                          // Handle option selection
                        },
                        hint: Text(
                          '  Find a job     ',
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        underline: Container(),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 40),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        color: Colors.indigo.shade900,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                SizedBox(
                  width: 50,
                  child: Text(
                    'New User',
                    maxLines: 2,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 125, right: 125, top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.indigo.shade900;
                      }
                      return Colors.transparent;
                    },
                  ),
                  checkColor: Colors.black,
                  side: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                Text("Blue Collar"),
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.grey;
                      }
                      return Colors.transparent;
                    },
                  ),
                  checkColor: Colors.black,
                  side: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                Text("Grey Collar"),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Upload Essential Documents",
                style: TextStyle(
                    color: Colors.indigo.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: CustomButton(
                  text: 'Picture',
                  onPressed: () {},
                )),
                SizedBox(width: 40),
                SizedBox(width: 40),
                Expanded(
                    child: CustomButton(
                  text: 'Aadhar',
                  onPressed: () {},
                )),
                SizedBox(width: 40),
                Expanded(
                    child: CustomButton(
                  text: 'Voter ID',
                  onPressed: () {},
                )),
                SizedBox(width: 40),
                Expanded(
                    child: CustomButton(
                  text: 'Experience Proof',
                  onPressed: () {},
                )),
                SizedBox(width: 40),
                Expanded(
                  child: CustomButton(
                    text: 'CV',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Wage",
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 60),
                    Text(
                      "Current City",
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    const SizedBox(
                      width: 400,
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    const SizedBox(
                      width: 400,
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Experienced Wage",
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 60),
                    Text(
                      "Current State",
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: 40,
                ),
                Column(
                  children: [
                    const SizedBox(
                      width: 400,
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    const SizedBox(
                      width: 400,
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 250,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  text: 'Back',
                  onPressed: () {},
                ),
                SizedBox(width: 50),
                CustomButton(
                  text: 'Next',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewUserPayment()),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
