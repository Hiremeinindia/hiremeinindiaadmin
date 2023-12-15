import 'package:chips_input/chips_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_simple_multiselect/flutter_simple_multiselect.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hiremeinindiaapp/userpayment.dart';
import 'package:select2dot1/select2dot1.dart';
import 'package:super_tag_editor/tag_editor.dart';
import 'package:super_tag_editor/widgets/rich_text_widget.dart';

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _worktitleController = TextEditingController();
  final TextEditingController _aadharnoController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _workexpController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();
  final TextEditingController _workinController = TextEditingController();
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  static const mockResults = [
    'Plumber',
    'Senior Plumber',
    'Junior Plumber',
    'Skill 1',
    'Electrician',
    'Senior Electrician',
    'Junior Electrician',
    'Skill 2',
  ];

  List<String> _values = [];
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  bool focusTagEnabled = false;

  _onDelete(index) {
    setState(() {
      _values.removeAt(index);
    });
  }

  /// This is just an example for using `TextEditingController` to manipulate
  /// the the `TextField` just like a normal `TextField`.

  bool isChecked = false; // Add this line to manage the checkbox state

  var isLoading = false;

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    bool _validate = false;
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
                padding: const EdgeInsets.only(right: 1400),
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
                          Expanded(
                            child: Column(
                              children: [
                                CustomTextfield(
                                  validator: nameValidator,
                                  controller: _nameController,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                CustomTextfield(
                                  validator: nameValidator,
                                  controller: _worktitleController,
                                  text: 'Enter Work Title',
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                CustomTextfield(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '*Required';
                                    } else if (value!.length != 12) {
                                      return 'Aadhar Number must be of 12 digit';
                                    }
                                    return null;
                                  },
                                  controller: _aadharnoController,
                                  text: 'Enter Aadhar No',
                                ),
                              ],
                            ),
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
                            child: Column(
                              children: [
                                CustomTextfield(
                                  validator: nameValidator,
                                  controller: _genderController,
                                  text: 'Enter gender',
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                CustomTextfield(
                                    validator: workexpValidator,
                                    controller: _workexpController,
                                    text: 'Enter Work experience'),
                                SizedBox(
                                  height: 40,
                                ),
                                CustomTextfield(
                                  validator: nameValidator,
                                  controller: _stateController,
                                  text: 'Enter State',
                                ),
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
                            child: CustomTextfield(
                          validator: workexpValidator,
                          text: 'Enter address',
                          controller: _addressController,
                        )),
                      ]),
                      SizedBox(
                        height: 45,
                      ),
                      Row(children: [
                        Text(
                          "Mobile",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 65),
                        Expanded(child: CustomTextfield(
                          validator: (value) {
                            if (value!.length != 10)
                              return 'Mobile Number must be of 10 digit';
                            else
                              return null;
                          },
                        )),
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
                        Expanded(
                            child: CustomTextfield(
                                validator: MultiValidator([
                          RequiredValidator(errorText: "* Required"),
                          EmailValidator(errorText: "Enter valid email id"),
                        ]))),
                        CustomButton(
                          text: 'Verify',
                          onPressed: () {},
                        ),
                      ]),
                      SizedBox(
                        height: 40,
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
                          SizedBox(width: 80),
                          Expanded(
                              child: CustomTextfield(
                            text: 'ggf',
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 40,
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
                          Expanded(
                              child: CustomTextfield(
                            text: 'ggf',
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1),
                            border: Border(
                                bottom: BorderSide(color: Colors.black))),
                        child: ListView(
                          children: <Widget>[
                            TagEditor<String>(
                              length: _values.length,
                              controller: _textEditingController,
                              focusNode: _focusNode,
                              delimiters: [',', ' '],
                              hasAddButton: true,
                              resetTextOnSubmitted: true,
                              // This is set to grey just to illustrate the `textStyle` prop
                              textStyle: const TextStyle(color: Colors.black),
                              onSubmitted: (outstandingValue) {
                                setState(() {
                                  _values.add(outstandingValue);
                                });
                              },
                              inputDecoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              onTagChanged: (newValue) {
                                setState(() {
                                  _values.add(newValue);
                                });
                              },
                              tagBuilder: (context, index) => Container(
                                color: focusTagEnabled &&
                                        index == _values.length - 1
                                    ? Colors.redAccent
                                    : Colors.white,
                                child: _Chip(
                                  index: index,
                                  label: _values[index],
                                  onDeleted: _onDelete,
                                ),
                              ),
                              // InputFormatters example, this disallow \ and /
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'[/\\]'))
                              ],
                              suggestionBuilder: (context, state, data, index,
                                  length, highlight, suggestionValid) {
                                var borderRadius =
                                    const BorderRadius.all(Radius.circular(30));
                                if (index == 0) {
                                  borderRadius = const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  );
                                } else if (index == length - 1) {
                                  borderRadius = const BorderRadius.only(
                                    bottomRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                  );
                                }
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _values.add(data);
                                    });
                                    state.resetTextField();
                                    state.closeSuggestionBox();
                                  },
                                  child: Container(
                                      width: 600,
                                      decoration: highlight
                                          ? BoxDecoration(
                                              color:
                                                  Theme.of(context).focusColor,
                                              borderRadius: borderRadius)
                                          : null,
                                      padding: const EdgeInsets.all(16),
                                      child: RichTextWidget(
                                        wordSearched: suggestionValid ?? '',
                                        textOrigin: data,
                                      )),
                                );
                              },
                              onFocusTagAction: (focused) {
                                setState(() {
                                  focusTagEnabled = focused;
                                });
                              },
                              onDeleteTagAction: () {
                                if (_values.isNotEmpty) {
                                  setState(() {
                                    _values.removeLast();
                                  });
                                }
                              },
                              onSelectOptionAction: (item) {
                                setState(() {
                                  _values.add(item);
                                });
                              },
                              suggestionsBoxElevation: 5,
                              findSuggestions: (String query) {
                                if (query.isNotEmpty) {
                                  var lowercaseQuery = query.toLowerCase();
                                  return mockResults.where((profile) {
                                    return profile
                                            .toLowerCase()
                                            .contains(query.toLowerCase()) ||
                                        profile
                                            .toLowerCase()
                                            .contains(query.toLowerCase());
                                  }).toList(growable: false)
                                    ..sort((a, b) => a
                                        .toLowerCase()
                                        .indexOf(lowercaseQuery)
                                        .compareTo(b
                                            .toLowerCase()
                                            .indexOf(lowercaseQuery)));
                                }
                                return [];
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
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
                                if (_formKey.currentState!.validate()) {
                                  // use the information provided
                                }
                              }),
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

String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return '*Required';
  } else if (!isValidName(value)) {
    return 'Invalid format';
  }
  return null;
}

bool isValidName(String name) {
  final RegExp nameRegExp = RegExp(r"^[A-Za-z']+([- ][A-Za-z']+)*$");
  return nameRegExp.hasMatch(name);
}

String? workexpValidator(String? value) {
  if (value == null || value.isEmpty) {
    return '*Required';
  } else if (!isValidWorkexp(value)) {
    return 'Invalid format';
  }
  return null;
}

bool isValidWorkexp(String workexp) {
  final RegExp pattern = RegExp(r"^[A-Za-z0-9]+$");
  return pattern.hasMatch(workexp);
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
      backgroundColor: Colors.indigo.shade900,
      labelPadding: const EdgeInsets.only(left: 5.0),
      label: Container(
          height: 17,
          child: Text(
            label,
            style: TextStyle(color: Colors.white),
          )),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
        color: Colors.white,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
