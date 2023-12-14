import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_simple_multiselect/flutter_simple_multiselect.dart';

import 'widgets/custombutton.dart';
import 'widgets/customtextfield.dart';
import 'widgets/hiremeinindia.dart';

class Registration extends StatefulWidget {
  const Registration();
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  final TextEditingController _worktitle = TextEditingController();
  final TextEditingController _aadharno = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _workexp = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _skills = TextEditingController();
  final TextEditingController _workin = TextEditingController();

  bool isChecked = false; // Add this line to manage the checkbox state
  final List<String> items = [
    'Welder',
    'Plumber',
    'Electrician',
    'Senior Plumber',
    'Senior Welder',
    'Senior Plumber',
    'Senior Welder',
    'Senior Electrician',
    'Senior Electrician'
  ];
  String? selectedValue;
  static const mockResults = [
    'Welder',
    'Plumber',
    'Electrician',
    'Senior Plumber',
    'Senior Welder',
    'Senior Plumber',
    'Senior Welder',
    'Senior Electrician',
    'Senior Electrician'
  ];

  List<Map<String, dynamic>> testData = [
    {"uuid": 1, "name": "Alfred Johanson"},
    {"uuid": 2, "name": "Goran Borovic"},
    {"uuid": 3, "name": "Ivan Horvat"},
    {"uuid": 4, "name": "Bjorn Sigurdson"}
  ];

  Future<List<Map<String, dynamic>>> searchFunction(query) async {
    return testData.where((element) {
      return element["name"].toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  Future<List<Map<String, dynamic>>> searchFunctionAsync(query) async {
    return Future.delayed(const Duration(seconds: 1), () {
      return testData.where((element) {
        return element["name"].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: HireMeInIndia(text1: 'Hire', text2: 'mein', text3: 'India'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30.0, top: 10),
            child: Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 150,
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
                SizedBox(width: 30),
                SizedBox(
                  height: 30,
                  width: 150,
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
                SizedBox(width: 16.0),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Colors.indigo.shade900,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Guest',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        'User',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 160),
            child: Row(
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
          ),
          Padding(
            padding: const EdgeInsets.only(right: 800),
            child: Text(
              "Register as a New User",
              style: TextStyle(fontSize: 30, color: Colors.grey),
            ),
          ),
          SizedBox(height: 45),
          Padding(
            padding: const EdgeInsets.only(left: 170, right: 170),
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 60),
                          Text(
                            "Work Title",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 60),
                          Text(
                            "Aadhar No",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Column(
                        children: [
                          SizedBox(
                              width: 400,
                              child: CustomTextfield(
                                onsaved: (String? val) {
                                  _name = val;
                                },
                                text: 'Enter Name',
                              )),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                              width: 400,
                              child: CustomTextfield(
                                controller: _worktitle,
                                text: 'Enter Work Title',
                              )),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                              width: 400,
                              child: CustomTextfield(
                                controller: _aadharno,
                                text: 'Enter Aadharno',
                              )),
                        ],
                      ),
                      SizedBox(
                        width: 43,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gender",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 60),
                          Text(
                            "Work Experience",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 60),
                          Text(
                            "State",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 28,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                              width: 400,
                              child: CustomTextfield(
                                controller: _gender,
                                text: 'Enter gender',
                              )),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                              width: 400,
                              child: CustomTextfield(
                                  controller: _workexp,
                                  text: 'Enter Work experience')),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                              width: 400,
                              child: CustomTextfield(
                                controller: _state,
                                text: 'Enter State',
                              )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(children: [
                    Text(
                      "Address",
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 60),
                    SizedBox(
                      height: 30,
                      width: 900,
                      child: CustomTextfield(
                        text: 'Enter address',
                        controller: _address,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 45,
                  ),
                  Row(
                    children: [
                      Text(
                        "Mobile",
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 65),
                      CustomTextfield(
                        text: 'Enter Mobile Number',
                      ),
                      CustomButton(
                        text: 'Verify',
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 40,
                        width: 70,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 55),
                      CustomTextfield(
                        text: 'Enter Email.',
                      ),
                      CustomButton(
                        text: 'Verify',
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Skills",
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 97),
                      CustomTextfield(
                        text: 'ggf',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Looking for Work in",
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      CustomTextfield(
                        text: 'ggf',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
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
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
