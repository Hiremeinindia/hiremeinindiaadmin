import 'package:firebase_auth/firebase_auth.dart';
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
  String enteredOTP = '';
  String smscode = "";
  String phoneNumber = "", data = "", phone = "";

  List<String> _values = [];
  List<String> _value = [];

  bool isVerified = false;
  bool blueChecked = false;
  bool greyChecked = false;
  bool focusTagEnabled = false;

  var isLoading = false;

  EmailOTP myauth = EmailOTP();

  final FocusNode _focusNode = FocusNode();
  final controller = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();
  final DatabaseReference _userRef =
      FirebaseDatabase.instance.reference().child('users');

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

  _onDelete(index) {
    setState(() {
      _values.removeAt(index);
    });
  }

  _onDeletee(indexx) {
    _value.removeAt(indexx);
  }

  _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }

  dispose() {
    controller.name.dispose();
    super.dispose();
  }

  bool isValidName(String name) {
    final RegExp nameRegExp = RegExp(r"^[A-Za-z']+([- ][A-Za-z']+)*$");
    return nameRegExp.hasMatch(name);
  }

  bool isValidWorkexp(String workexp) {
    final RegExp pattern = RegExp(r"^[A-Za-z0-9]+$");
    return pattern.hasMatch(workexp);
  }

  String? workexpValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '*Required';
    } else if (!isValidWorkexp(value)) {
      return 'Invalid format';
    }
    return null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '*Required';
    } else if (!isValidName(value)) {
      return 'Invalid format';
    }
    return null;
  }

  _showAlert(BuildContext context) {
    showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: Text("Current Location Not Available"),
        content:
            Text("Your current location cannot be determined at this time."),
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

  _showVerificationSuccessDialog(BuildContext context) {
    print("verified1");
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        print("verified2");
        return AlertDialog(
          title: Text('Verification Successful'),
          content:
              Text('Congratulations! Your mobile number has been verified.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                print("verified3");
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  _signInWithMobileNumber() async {
    print("register1");
    String mobileNumber = controller.mobile.text;
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      print("register2");
      // Check if the mobile number is already registered in Firebase Realtime Database
      bool isNumberRegistered = await checkIfNumberRegistered(mobileNumber);
      print('Is Number Registered: $isNumberRegistered');

      if (isNumberRegistered) {
        print("register3");
        print("number registered ");
        // Display a popup message if the number is already registered
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Mobile Number Already Registered"),
            content: Text("Try another number for registration"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      } else {
        // If the number is not registered, proceed with phone number verification
        await _auth.verifyPhoneNumber(
          phoneNumber: "+91${controller.mobile.text}",
          verificationCompleted: (PhoneAuthCredential authCredential) async {
            await _auth.signInWithCredential(authCredential).then((value) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Registration()),
              );
            });
          },
          verificationFailed: (FirebaseAuthException error) {
            print("Verification Failed: ${error.message}");
          },
          codeSent: (String verificationId, [int? forceResendingToken]) {
            // Store the verification ID for later use (e.g., resend OTP)
            // You can use the verificationId in your app to implement features like OTP resend.
            // For simplicity, this example does not include resend functionality.
            String storedVerificationId = verificationId;

            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: Text("Enter OTP"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: controller.code,
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      String smsCode = controller.code.text;
                      PhoneAuthCredential _credential =
                          PhoneAuthProvider.credential(
                        verificationId: storedVerificationId,
                        smsCode: smsCode,
                      );

                      auth.signInWithCredential(_credential).then((result) {
                        if (result != null) {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registration()),
                          );
                        }
                      }).catchError((e) {
                        print("Error signing in with credential: $e");
                      });
                    },
                    child: Text("Done"),
                  ),
                ],
              ),
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            verificationId = verificationId;
          },
          timeout: Duration(seconds: 45),
        );
      }
    } catch (e) {
      print("Error during phone number verification: $e");
    }
  }

  Future<bool> checkUserInBlocklist(String mobileNumber) async {
    // Implement the logic to check if the user is in the blocklist
    // For example, you can use the DatabaseService class mentioned earlier
    return await DatabaseService().isUserInBlocklist(mobileNumber);
  }

  Future<bool> _verifyOtp(String otp) async {
    // Implement your OTP verification logic here
    // Return true if OTP is valid, false otherwise
    // For example, you might make an API call to your server for verification
    // Replace the following line with your actual verification logic
    bool isOtpValid = (otp == '1234'); // Replace '1234' with the correct OTP
    return isOtpValid;
  }

  Future<bool> checkIfNumberRegistered(String mobileNumber) async {
    print("check1");
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    String path = 'users';

    try {
      print("check2");
      DatabaseEvent databaseEvent = await databaseReference.child(path).once();
      DataSnapshot dataSnapshot = databaseEvent.snapshot;

      if (dataSnapshot.value != null) {
        print("check3");
        Map<dynamic, dynamic>? usersData =
            dataSnapshot.value as Map<dynamic, dynamic>?;

        if (usersData != null) {
          print("check4");
          bool isNumberRegistered = usersData.values.any((userData) {
            // Ensure 'mobileNumber' is not null and not an empty string
            return userData['mobileNumber'] != null &&
                userData['mobileNumber'].toString().isNotEmpty &&
                userData['mobileNumber'].toString() == mobileNumber;
          });
          print('Is Number Registered: $isNumberRegistered');

          return isNumberRegistered;
        }
      }

      return false;
    } catch (error) {
      print("check5");
      print('Error checking if number is registered: $error');
      return false;
    }
  }

  Future<void> _showOtpDialog(BuildContext context, String mobileNumber) async {
    print("dialog1");
    String otp = ''; // Use a variable to store the entered OTP

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter OTP for $mobileNumber'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  onChanged: (value) {
                    otp = value;
                  },
                  decoration: InputDecoration(labelText: 'OTP'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                print("phone1");
                // Perform verification logic with entered OTP
                // For example, you can call a function like _verifyOtp(otp)
                // and handle the verification process there.
                bool isOtpValid = await _verifyOtp(otp);

                if (isOtpValid) {
                  print("otp1");
                  // Update UI after successful verification
                  Navigator.of(context).pop(); // Close the dialog
                  _showVerificationSuccessDialog(context);
                } else {
                  print("otp2");
                  // Handle case where OTP verification fails
                  // You can show an error message or take other actions
                  print('Incorrect OTP');
                  // Optionally, show an error message to the user
                }
              },
              child: Text('Verify'),
            ),
          ],
        );
      },
    );
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
                        SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.indigo.shade900,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    0.1), // Adjust border radius as needed
                              ),
                            ),
                            onPressed: () async {
                              print("phone1");
                              String mobileNumber = controller.mobile.text;
                              print(mobileNumber);

                              // Check if the user is already registered or in the blocklist
                              bool isUserRegistered =
                                  await _signInWithMobileNumber();
                            },
                            child: isVerified
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.check, color: Colors.green),
                                      SizedBox(width: 8),
                                      Text('Verified'),
                                    ],
                                  )
                                : Text(
                                    'Verify',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
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
                                    // This is set to grey just to illustrate the textStyle prop
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
                                    // This is set to grey just to illustrate the textStyle prop
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

class DatabaseService {
  Future<bool> isUserRegistered(String mobileNumber) async {
    bool userExists = await yourDatabaseQueryToCheckUserExists(mobileNumber);
    return userExists;
  }

  Future<bool> isUserInBlocklist(String mobileNumber) async {
    bool userInBlocklist = await yourBlocklistQueryToCheckUser(mobileNumber);
    return userInBlocklist;
  }

  Future<bool> yourDatabaseQueryToCheckUserExists(String mobileNumber) async {
    return false;
  }

  Future<bool> yourBlocklistQueryToCheckUser(String mobileNumber) async {
    return false;
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
