import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/userdashboard.dart';
import 'classes/language_constants.dart';
import 'widgets/custombutton.dart';
import 'widgets/hiremeinindia.dart';

class NewUserPayment extends StatefulWidget {
  const NewUserPayment();
  @override
  State<NewUserPayment> createState() => _NewUserPayment();
}

class _NewUserPayment extends State<NewUserPayment> {
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
            padding:
                EdgeInsets.only(left: 125, right: 125, top: 20, bottom: 20),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  Text(translation(context).greyColler),
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
                  Text(
                    translation(context).greyColler,
                  ),
                ],
              ),
              SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                      child: CustomButton(
                    text: translation(context).gpay,
                    onPressed: () {},
                  )),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                      child: CustomButton(
                    text: translation(context).neft,
                    onPressed: () {},
                  )),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                      child: CustomButton(
                    text: translation(context).cash,
                    onPressed: () {},
                  )),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                      child: CustomButton(
                    text: translation(context).back,
                    onPressed: () {},
                  )),
                ],
              ),
              SizedBox(
                height: 400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    text: translation(context).next,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserDashboard()),
                      );
                    },
                  ),
                ],
              )
            ])));
  }
}
