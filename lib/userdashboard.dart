import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/widgets/customcard.dart';
import 'package:hiremeinindiaapp/widgets/customtextfield.dart';

import 'widgets/custombutton.dart';
import 'widgets/hiremeinindia.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard();
  @override
  State<UserDashboard> createState() => _UserDashboard();
}

class _UserDashboard extends State<UserDashboard> {
  @override
  bool isChecked = false;
  bool dropdownValue = false;

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
            padding:
                EdgeInsets.only(left: 125, right: 125, top: 20, bottom: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CircleAvatar(
                backgroundColor: Colors.indigo.shade900,
                maxRadius: 68,
                minRadius: 67.5,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  maxRadius: 66,
                  minRadius: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('imguser.jpg'),
                    maxRadius: 59,
                    minRadius: 56,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                icon: const Icon(Icons.arrow_drop_down_sharp),
                iconSize: 40,
                iconEnabledColor: Colors.indigo,
                decoration: InputDecoration(border: InputBorder.none),
                hint: const Text(
                  'Hello Saravanan',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Colors.indigo,
                      fontWeight: FontWeight.w900),
                ),
                dropdownColor: Colors.indigo,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue! as bool;
                  });
                },
                items: <String>['Apple', 'Mango', 'Banana', 'Peach']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  CustomCard(
                    color: Color.fromARGB(255, 153, 51, 49),
                    title1: 'No of offers',
                    title2: '1',
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  CustomCard(
                    color: Color.fromARGB(224, 92, 181, 95),
                    title1: 'No of Profile Visits',
                    title2: '100',
                  )
                ],
              ),
              SizedBox(
                height: 75,
              ),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: CustomButton(
                  text: 'Register for other',
                  onPressed: () {},
                ),
              ))
            ])));
  }
}
