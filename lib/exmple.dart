import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_simple_multiselect/flutter_simple_multiselect.dart';
import 'package:hiremeinindiaapp/exmple.dart';
import 'package:hiremeinindiaapp/newuserupload.dart';
import 'package:super_tag_editor/tag_editor.dart';
import 'package:super_tag_editor/widgets/rich_text_widget.dart';

import 'widgets/custombutton.dart';
import 'widgets/customtextfield.dart';
import 'widgets/hiremeinindia.dart';
import 'widgets/textstylebutton.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyRegistration extends StatefulWidget {
  const MyRegistration();
  @override
  State<MyRegistration> createState() => _RegistrationState();
}

class _RegistrationState extends State<MyRegistration> {
  final _formKey = GlobalKey<FormState>();
  FirebaseDatabase database = FirebaseDatabase.instance;
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
  bool get isValidName {
    final nameRegExp =
        new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this as String);
  }

  bool _validate = false;

  @override
  void dispose() {
    _aadharno.dispose();
    _address.dispose();
    _email.dispose();
    _gender.dispose();
    _mobile.dispose();
    _skills.dispose();
    _state.dispose();
    _workexp.dispose();
    _workin.dispose();
    _worktitle.dispose();

    super.dispose();
  }

  void _next() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }

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

  List<String> _values = [];
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  bool focusTagEnabled = false;
  late Color lineColor = const Color.fromRGBO(36, 37, 51, 0.04);
  List selectedItems = [];
  List selectedItemsAsync = [];
  Map? singleItem;
  bool isLoading = false;

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

  _onDelete(index) {
    setState(() {
      _values.removeAt(index);
    });
  }

  /// This is just an example for using `TextEditingController` to manipulate
  /// the the `TextField` just like a normal `TextField`.
  _onPressedModifyTextField() {
    final text = 'Test';
    _textEditingController.text = text;
    _textEditingController.value = _textEditingController.value.copyWith(
      text: text,
      selection: TextSelection(
        baseOffset: text.length,
        extentOffset: text.length,
      ),
    );
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Name cannot be empty';
    }
    if (value.length < 3) {
      return 'Name must be more than 2 charater';
    } else {
      return null;
    }
  }

  TextEditingController nameController = TextEditingController();

  Widget _staticData() {
    return FlutterMultiselect(
        autofocus: false,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        enableBorderColor: lineColor,
        focusedBorderColor: lineColor,
        borderRadius: 5,
        borderSize: 2,
        resetTextOnSubmitted: true,
        minTextFieldWidth: 300,
        suggestionsBoxMaxHeight: 300,
        length: selectedItems.length,
        tagBuilder: (context, index) => SelectTag(
              index: index,
              label: selectedItems[index]["name"],
              onDeleted: (value) {
                selectedItems.removeAt(index);
                setState(() {});
              },
            ),
        suggestionBuilder: (context, state, data) {
          var existingIndex = selectedItems
              .indexWhere((element) => element["uuid"] == data["uuid"]);
          var selectedData = data;
          return Material(
            child: ListTile(
                dense: true,
                selected: existingIndex >= 0,
                trailing: existingIndex >= 0 ? const Icon(Icons.check) : null,
                selectedColor: Colors.white,
                selectedTileColor: Colors.green,
                title: Text(selectedData["name"].toString()),
                onTap: () {
                  if (existingIndex >= 0) {
                    selectedItems.removeAt(existingIndex);
                  } else {
                    selectedItems.add(data);
                  }

                  state.selectAndClose(data);
                  setState(() {});
                }),
          );
        },
        suggestionsBoxElevation: 10,
        findSuggestions: (String query) async {
          setState(() {
            isLoading = true;
          });
          var data = await searchFunction(query);
          setState(() {
            isLoading = false;
          });
          return data;
        });
  }

  Widget _validatename() {
    return FlutterMultiselect(
        autofocus: false,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        enableBorderColor: lineColor,
        focusedBorderColor: lineColor,
        borderRadius: 5,
        borderSize: 2,
        resetTextOnSubmitted: true,
        minTextFieldWidth: 300,
        validator: (value) {
          if (selectedItemsAsync.length < 2) {
            return "Min 2 items required";
          }
          return null;
        },
        suggestionsBoxMaxHeight: 300,
        length: selectedItemsAsync.length,
        isLoading: isLoading,
        tagBuilder: (context, index) => SelectTag(
              index: index,
              label: selectedItemsAsync[index]["name"],
              onDeleted: (value) {
                selectedItemsAsync.removeAt(index);
                setState(() {});
              },
            ),
        suggestionBuilder: (context, state, data) {
          var existingIndex = selectedItemsAsync
              .indexWhere((element) => element["uuid"] == data["uuid"]);
          var selectedData = data;
          return Material(
              child: ListTile(
                  selected: existingIndex >= 0,
                  trailing: existingIndex >= 0 ? const Icon(Icons.check) : null,
                  selectedColor: Colors.white,
                  selectedTileColor: Colors.green,
                  title: Text(selectedData["name"].toString()),
                  onTap: () {
                    var existingIndex = selectedItemsAsync.indexWhere(
                        (element) => element["uuid"] == data["uuid"]);
                    if (existingIndex >= 0) {
                      selectedItemsAsync.removeAt(existingIndex);
                    } else {
                      selectedItemsAsync.add(data);
                    }

                    state.selectAndClose(data);
                    setState(() {});
                  }));
        },
        suggestionsBoxElevation: 10,
        findSuggestions: (String query) async {
          setState(() {
            isLoading = true;
          });
          var data = await searchFunctionAsync(query);
          setState(() {
            isLoading = false;
          });
          return data;
        });
  }

  Widget _asyncData() {
    return FlutterMultiselect(
        autofocus: false,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        enableBorderColor: lineColor,
        focusedBorderColor: lineColor,
        borderRadius: 5,
        borderSize: 2,
        resetTextOnSubmitted: true,
        minTextFieldWidth: 300,
        validator: (value) {
          if (selectedItemsAsync.length < 2) {
            return "Min 2 items required";
          }
          return null;
        },
        suggestionsBoxMaxHeight: 300,
        length: selectedItemsAsync.length,
        isLoading: isLoading,
        tagBuilder: (context, index) => SelectTag(
              index: index,
              label: selectedItemsAsync[index]["name"],
              onDeleted: (value) {
                selectedItemsAsync.removeAt(index);
                setState(() {});
              },
            ),
        suggestionBuilder: (context, state, data) {
          var existingIndex = selectedItemsAsync
              .indexWhere((element) => element["uuid"] == data["uuid"]);
          var selectedData = data;
          return Material(
              child: ListTile(
                  selected: existingIndex >= 0,
                  trailing: existingIndex >= 0 ? const Icon(Icons.check) : null,
                  selectedColor: Colors.white,
                  selectedTileColor: Colors.green,
                  title: Text(selectedData["name"].toString()),
                  onTap: () {
                    var existingIndex = selectedItemsAsync.indexWhere(
                        (element) => element["uuid"] == data["uuid"]);
                    if (existingIndex >= 0) {
                      selectedItemsAsync.removeAt(existingIndex);
                    } else {
                      selectedItemsAsync.add(data);
                    }

                    state.selectAndClose(data);
                    setState(() {});
                  }));
        },
        suggestionsBoxElevation: 10,
        findSuggestions: (String query) async {
          setState(() {
            isLoading = true;
          });
          var data = await searchFunctionAsync(query);
          setState(() {
            isLoading = false;
          });
          return data;
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
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
                                      //   validator: validateName,
                                      text: 'Enter Name',
                                      text1:
                                          _validate ? "Invalid name" : null)),
                              SizedBox(
                                height: 40,
                              ),
                              SizedBox(
                                  width: 400,
                                  child: CustomTextfield(
                                      controller: _worktitle,
                                      text: 'Enter Work Title',
                                      text1: _validate
                                          ? 'Invalid Work Title'
                                          : null)),
                              SizedBox(
                                height: 40,
                              ),
                              SizedBox(
                                  width: 400,
                                  child: CustomTextfield(
                                      controller: _aadharno,
                                      text: 'Enter Aadharno',
                                      text1: _validate
                                          ? 'Invalid Aadharno'
                                          : null)),
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
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                    width: 400,
                                    child: CustomTextfield(
                                      controller: _gender,
                                      text: 'Enter gender',
                                      text1: _validate ? '' : null,
                                    )),
                                SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                    width: 400,
                                    child: CustomTextfield(
                                      controller: _workexp,
                                      text: 'Enter Work experience',
                                      text1: _validate ? '' : null,
                                    )),
                                SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                    width: 400,
                                    child: CustomTextfield(
                                      controller: _state,
                                      text: 'Enter State',
                                      text1: _validate ? '' : null,
                                    )),
                              ],
                            ),
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
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 60),
                        Expanded(
                          child: SizedBox(
                            height: 30,
                            width: 900,
                            child: CustomTextfield(
                              text: 'Enter address',
                              text1: _validate ? '' : null,
                              controller: _address,
                            ),
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
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 65),
                          Expanded(
                              child: CustomTextfield(
                                  text: 'Enter Mobile Number',
                                  text1:
                                      _validate ? 'Invalid Mobile No.' : null)),
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
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 55),
                          //   Expanded(
                          //       child: CustomTextfield(
                          //      validator: (val) {
                          //     if (!val.isValidName)
                          //          return 'Enter valid email';
                          //         },
                          //      text: 'Enter Email.',
                          //       text1: _validate ? 'Invalid mail id' : null)),
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
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 97),
                          Expanded(child: _asyncData()),
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
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Expanded(child: _staticData()),
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
                            onPressed: () => _next(),
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
        ),
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

class SelectTag extends StatelessWidget {
  final int index;
  final String label;
  final Function onDeleted;

  const SelectTag({
    required this.index,
    required this.label,
    required this.onDeleted,
  });

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
