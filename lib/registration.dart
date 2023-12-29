import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:email_otp/email_otp.dart';

import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:hiremeinindiaapp/Models/register_model.dart';
import 'package:hiremeinindiaapp/userpayment.dart';

import 'package:super_tag_editor/tag_editor.dart';
import 'package:super_tag_editor/widgets/rich_text_widget.dart';

import 'controllers/signupcontroller.dart';
import 'widgets/custombutton.dart';
import 'widgets/customtextfield.dart';
import 'widgets/hiremeinindia.dart';

class Registration extends StatefulWidget {
  const Registration();
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final controller = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();
  final DatabaseReference _userRef =
      FirebaseDatabase.instance.reference().child('users');
  EmailOTP myauth = EmailOTP();
  static const Skill = [
    'Plumber',
    'Senior Plumber',
    'Junior Plumber',
    'Skill 1',
    'Electrician',
    'Senior Electrician',
    'Junior Electrician',
    'Skill 2',
  ];

  static const Workin = [
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
  List<String> _value = [];

  final FocusNode _focusNode = FocusNode();
  bool focusTagEnabled = false;

  _onDelete(index) {
    setState(() {
      _values.removeAt(index);
    });
  }

  _onDeletee(indexx) {
    _value.removeAt(indexx);
  }

  /// This is just an example for using `TextEditingController` to manipulate
  /// the the `TextField` just like a normal `TextField`.

  bool blueChecked = false;
  bool greyChecked = false; // Add this line to manage the checkbox state

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
                      value: blueChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          blueChecked = value ?? false;
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
                      checkColor: Colors.white,
                      side: BorderSide(
                        color: Colors.indigo.shade900,
                        width: 3.5,
                      ),
                    ),
                    Text("Blue Collar"),
                    Checkbox(
                      value: greyChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          greyChecked = value ?? false;
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
                      checkColor: Colors.white,
                      side: BorderSide(
                        color: Colors.indigo.shade900,
                        width: 3.5,
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
                                  controller: controller.name,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                CustomTextfield(
                                  validator: nameValidator,
                                  controller: controller.worktitle,
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
                                  controller: controller.aadharno,
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
                                  controller: controller.gender,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                CustomTextfield(
                                  validator: workexpValidator,
                                  controller: controller.workexp,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                CustomTextfield(
                                  validator: nameValidator,
                                  controller: controller.state,
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
                          controller: controller.address,
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
                        Expanded(
                            child: CustomTextfield(
                          controller: controller.mobile,
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
                                controller: controller.email,
                                validator: MultiValidator([
                                  RequiredValidator(errorText: "* Required"),
                                  EmailValidator(
                                      errorText: "Enter valid email id"),
                                ]))),
                        CustomButton(
                          text: 'Verify',
                          onPressed: () async {
                            myauth.setConfig(
                                appEmail: "mail@gmail.com",
                                appName: "Email otp",
                                userEmail: controller.email.text,
                                otpLength: 4,
                                otpType: OTPType.digitsOnly);
                            if (await myauth.sendOTP() == true) {
                              _showAlert(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("OTP has been sent"),
                              ));
                            }
                          },
                        ),
                      ]),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Text(
                            "Skills",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1),
                                  border: Border(
                                      bottom: BorderSide(color: Colors.black))),
                              child: ListView(
                                children: <Widget>[
                                  TagEditor<String>(
                                    length: _value.length,
                                    controller: controller.skills,
                                    focusNode: _focusNode,
                                    delimiters: [',', ' '],
                                    resetTextOnSubmitted: true,
                                    // This is set to grey just to illustrate the `textStyle` prop
                                    textStyle:
                                        const TextStyle(color: Colors.black),
                                    onSubmitted: (outstandingValue) {
                                      setState(() {
                                        _value.add(outstandingValue);
                                      });
                                    },
                                    inputDecoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    onTagChanged: (newValue) {
                                      setState(() {
                                        _value.add(newValue);
                                      });
                                    },
                                    tagBuilder: (context, index) => Container(
                                      color: focusTagEnabled &&
                                              index == _value.length - 1
                                          ? Colors.redAccent
                                          : Colors.white,
                                      child: _Chip(
                                        index: index,
                                        label: _value[index],
                                        onDeleted: _onDeletee,
                                      ),
                                    ),
                                    // InputFormatters example, this disallow \ and /
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(
                                          RegExp(r'[/\\]'))
                                    ],
                                    suggestionBuilder: (context,
                                        state,
                                        data,
                                        index,
                                        length,
                                        highlight,
                                        suggestionValid) {
                                      var borderRadius = const BorderRadius.all(
                                          Radius.circular(30));
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
                                            _value.add(data);
                                          });
                                          state.resetTextField();
                                          state.closeSuggestionBox();
                                        },
                                        child: Container(
                                            width: 600,
                                            decoration: highlight
                                                ? BoxDecoration(
                                                    color: Theme.of(context)
                                                        .focusColor,
                                                    borderRadius: borderRadius)
                                                : null,
                                            padding: const EdgeInsets.all(16),
                                            child: RichTextWidget(
                                              wordSearched:
                                                  suggestionValid ?? '',
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
                                      if (_value.isNotEmpty) {
                                        setState(() {
                                          _value.removeLast();
                                        });
                                      }
                                    },
                                    onSelectOptionAction: (item) {
                                      setState(() {
                                        _value.add(item);
                                      });
                                    },
                                    suggestionsBoxElevation: 5,
                                    findSuggestions: (String query) {
                                      if (query.isNotEmpty) {
                                        var lowercaseQuery =
                                            query.toLowerCase();
                                        return Skill.where((profile) {
                                          return profile.toLowerCase().contains(
                                                  query.toLowerCase()) ||
                                              profile.toLowerCase().contains(
                                                  query.toLowerCase());
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
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Text(
                            "Looking for Work in",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1),
                                  border: Border(
                                      bottom: BorderSide(color: Colors.black))),
                              child: ListView(
                                children: <Widget>[
                                  TagEditor<String>(
                                    length: _values.length,
                                    controller: controller.workin,
                                    focusNode: _focusNode,
                                    delimiters: [',', ' '],
                                    resetTextOnSubmitted: true,
                                    // This is set to grey just to illustrate the `textStyle` prop
                                    textStyle:
                                        const TextStyle(color: Colors.black),
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
                                    suggestionBuilder: (context,
                                        state,
                                        data,
                                        index,
                                        length,
                                        highlight,
                                        suggestionValid) {
                                      var borderRadius = const BorderRadius.all(
                                          Radius.circular(30));
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
                                                    color: Theme.of(context)
                                                        .focusColor,
                                                    borderRadius: borderRadius)
                                                : null,
                                            padding: const EdgeInsets.all(16),
                                            child: RichTextWidget(
                                              wordSearched:
                                                  suggestionValid ?? '',
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
                                        var lowercaseQuery =
                                            query.toLowerCase();
                                        return Workin.where((profile) {
                                          return profile.toLowerCase().contains(
                                                  query.toLowerCase()) ||
                                              profile.toLowerCase().contains(
                                                  query.toLowerCase());
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
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final user = RegisterModal(
                                    name: controller.name.text.trim(),
                                    gender: controller.gender.text.trim(),
                                    workexp: controller.workexp.text.trim(),
                                    worktitle: controller.worktitle.text.trim(),
                                    aadharno: controller.aadharno.text.trim(),
                                    state: controller.state.text.trim(),
                                    address: controller.address.text.trim(),
                                    mobile: controller.mobile.text.trim(),
                                    email: controller.email.text.trim(),
                                    skills: controller.skills.text.trim(),
                                    workin: controller.workin.text.trim());
                                _userRef.push().set(user.tojson());
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => NewUserPayment(),
                                  ),
                                );
                              }
                            },
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

_showAlert(BuildContext context) {
  showPlatformDialog(
    context: context,
    builder: (_) => BasicDialogAlert(
      title: Text("Current Location Not Available"),
      content: Text("Your current location cannot be determined at this time."),
      actions: <Widget>[
        BasicDialogAction(
          title: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
