import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/registration.dart';

import 'widgets/custombutton.dart';
import 'widgets/customtextfield.dart';
import 'widgets/hiremeinindia.dart';

class Hired extends StatefulWidget {
  const Hired();
  @override
  State<Hired> createState() => _HiredState();
}

class _HiredState extends State<Hired> {
  @override
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
                    'Guest User',
                    maxLines: 2,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Get Hired from the best",
              style: TextStyle(
                  color: Colors.indigo.shade900,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 60),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                        height: 200,
                        width: 200,
                        child: Image(image: AssetImage('imgman.jpg'))),
                    SizedBox(
                      height: 2,
                    ),
                    SizedBox(
                        width: 200,
                        height: 40,
                        child: CustomButton(
                          text: 'Blue Collar Jobs',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Registration()),
                            );
                          },
                        ))
                  ],
                ),
                SizedBox(width: 50),
                Column(
                  children: [
                    SizedBox(
                        height: 200,
                        width: 200,
                        child: Image(image: AssetImage('imggirl.jpg'))),
                    SizedBox(
                      height: 2,
                    ),
                    SizedBox(
                        width: 200,
                        height: 40,
                        child: CustomButton(
                          text: 'Grey Collar Jobs',
                          onPressed: () {
                            Registration();
                          },
                        ))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
