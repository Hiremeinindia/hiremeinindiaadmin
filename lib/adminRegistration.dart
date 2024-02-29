import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sizer/sizer.dart';

import '../classes/language_constants.dart';
import '../widgets/custombutton.dart';
import '../widgets/customtextfield.dart';
import '../widgets/hiremeinindia.dart';
import 'admin.dart';
import 'adminFormState.dart';
import 'classes/language.dart';
import 'gen_l10n/app_localizations.dart';
import 'loginPage.dart';
import 'main.dart';
import 'widgets/customtextstyle.dart';

class AdminRegistration extends StatefulWidget {
  const AdminRegistration({Key? key, this.corporate}) : super(key: key);

  final Admin? corporate;

  @override
  State<AdminRegistration> createState() => _AdminRegistrationState();
}

class _AdminRegistrationState extends State<AdminRegistration> {
  var isLoading = false;

  AdminFormController controller = AdminFormController();
  var label = 'Admin';
  bool isValidName(String name) {
    final RegExp nameRegExp = RegExp(r"^[A-Za-z']+([- ][A-Za-z']+)*$");
    return nameRegExp.hasMatch(name);
  }

  dispose() {
    controller.name.dispose();
    super.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? validatePassword(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
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

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Sizer(builder: (context, orientation, deviceType) {
      return LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
        if (constraints.maxWidth >= 700) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(75),
              child: Material(
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5.w, 0, 2.5.w, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HireMeInIndia(),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade900,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<Language>(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        translation(context).english,
                                        style: CustomTextStyle.dropdowntext,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                onChanged: (Language? language) async {
                                  if (language != null) {
                                    Locale _locale =
                                        await setLocale(language.languageCode);
                                    HireApp.setLocale(context, _locale);
                                  } else {
                                    language;
                                  }
                                },
                                items: Language.languageList()
                                    .map<DropdownMenuItem<Language>>(
                                      (e) => DropdownMenuItem<Language>(
                                        value: e,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(
                                              e.flag,
                                              style:
                                                  CustomTextStyle.dropdowntext,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              e.langname,
                                              style:
                                                  CustomTextStyle.dropdowntext,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                                buttonStyleData: ButtonStyleData(
                                  height: 30,
                                  width: 150,
                                  elevation: 1,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_drop_down_sharp,
                                  ),
                                  iconSize: 25,
                                  iconEnabledColor: Colors.white,
                                  iconDisabledColor: null,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 210,
                                  elevation: 0,
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black),
                                    color: Colors.indigo.shade900,
                                  ),
                                  scrollPadding: EdgeInsets.all(5),
                                  scrollbarTheme: ScrollbarThemeData(
                                    thickness:
                                        MaterialStateProperty.all<double>(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 25,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade900,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
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
                                  AppLocalizations.of(context)!.findaJob,
                                  style: TextStyle(color: Colors.white),
                                ),
                                buttonStyleData: ButtonStyleData(
                                  height: 30,
                                  width: 150,
                                  elevation: 1,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_drop_down_sharp,
                                  ),
                                  iconSize: 25,
                                  iconEnabledColor: Colors.white,
                                  iconDisabledColor: null,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 210,
                                  elevation: 0,
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black),
                                    color: Colors.indigo.shade900,
                                  ),
                                  scrollPadding: EdgeInsets.all(5),
                                  scrollbarTheme: ScrollbarThemeData(
                                    thickness:
                                        MaterialStateProperty.all<double>(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 25,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person_outline_outlined,
                                size: 35,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 0.5.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translation(context).guest,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.indigo.shade900,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                translation(context).user,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.indigo.shade900,
                                    height: 0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Center(
                child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                width: 60.h,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          translation(context).register,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        translation(context).name,
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 750,
                        child: CustomTextfield(
                          text: translation(context).name,
                          controller: controller.name,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        translation(context).email,
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 750,
                        child: CustomTextfield(
                          text: translation(context).email,
                          controller: controller.email,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        translation(context).password,
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 750,
                        child: CustomTextfield(
                          text: translation(context).password,
                          validator: validatePassword,
                          controller: controller.password,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                          text: translation(context).register,
                          onPressed: () async {
                            // Sign in with email and password
                            UserCredential userCredential =
                                await _auth.createUserWithEmailAndPassword(
                              email: controller.email.text,
                              password: controller.password.text,
                            );
                            await FirebaseFirestore.instance
                                .collection('adminuser')
                                .doc(userCredential.user!.uid)
                                .set({
                              'name': controller.name.text,
                              'email': controller.email.text,
                            });

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 15),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.indigo.shade900,
                                  fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
            )),
          );
        } else {
          return Scaffold(
            endDrawer: Drawer(
              child: ListView(
                  padding: EdgeInsets.only(
                    top: 3.h,
                  ),
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: 41,
                      minRadius: 41,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        maxRadius: 40,
                        minRadius: 40,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person_outline_outlined,
                          size: 60,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Center(
                      child: Text(
                        translation(context).guest,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.indigo.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                        translation(context).user,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.indigo.shade900,
                            height: 0),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    ExpansionTile(
                      collapsedBackgroundColor: Colors.indigo.shade900,
                      collapsedIconColor: Colors.white,
                      collapsedTextColor: Colors.white,
                      textColor: Colors.black,
                      iconColor: Colors.black,
                      title: Text(
                        AppLocalizations.of(context)!.english,
                      ),
                      children: Language.languageList().map((language) {
                        return ListTile(
                          hoverColor: Colors.indigo.shade100,
                          title: Text(
                            language.langname,
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () async {
                            // Handle language selection
                            Locale _locale =
                                await setLocale(language.languageCode);
                            HireApp.setLocale(context, _locale);
                          },
                        );
                      }).toList(),
                    ),
                    ExpansionTile(
                        collapsedBackgroundColor: Colors.indigo.shade900,
                        collapsedIconColor: Colors.white,
                        collapsedTextColor: Colors.white,
                        iconColor: Colors.black,
                        textColor: Colors.black,
                        title: Text(
                          AppLocalizations.of(context)!.findaJob,
                        ),
                        children: [
                          ListTile(
                            hoverColor: Colors.indigo.shade100,
                            title: Text(
                              'option1',
                              style: TextStyle(color: Colors.black),
                            ),
                            onTap: () {},
                          ),
                          ListTile(
                            hoverColor: Colors.indigo.shade100,
                            title: Text(
                              'option2',
                              style: TextStyle(color: Colors.black),
                            ),
                            onTap: () {},
                          )
                        ]),
                  ]),
            ),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Container(
                height: 80,
                width: 55.h,
                child: Material(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5.w, 0, 2.5.w, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HireMeInIndia(),
                        Builder(
                            builder: (context) => IconButton(
                                  onPressed: () {
                                    Scaffold.of(context).openEndDrawer();
                                  },
                                  icon: Icon(
                                    Icons.menu_rounded,
                                    color: Colors.indigo.shade900,
                                  ),
                                ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  width: 55.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            translation(context).register,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          translation(context).name,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 750,
                          child: CustomTextfield(
                            text: translation(context).name,
                            controller: controller.name,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          translation(context).email,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 750,
                          child: CustomTextfield(
                            text: translation(context).email,
                            controller: controller.email,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          translation(context).password,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 750,
                          child: CustomTextfield(
                            text: translation(context).password,
                            validator: validatePassword,
                            controller: controller.password,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CustomButton(
                            text: translation(context).register,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // Sign up with email and password
                                UserCredential userCredential =
                                    await _auth.createUserWithEmailAndPassword(
                                  email: controller.email.text,
                                  password: controller.password.text,
                                );

                                // Assign the admin role to the user
                                await FirebaseFirestore.instance
                                    .collection('adminuser')
                                    .doc(userCredential.user!.uid)
                                    .set({
                                  'name': controller.name.text,
                                  'email': controller.email.text,
                                });

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      });
    });
  }

  Future<void> assignUserRole(String uid) async {
    try {
      String adminCollection = 'adminuser';

      // Assign the admin role to the user
      await FirebaseFirestore.instance
          .collection(adminCollection)
          .doc(uid)
          .set({
        'name': controller.name.text,
        'email': controller.email.text,
        // Add additional admin-related fields as needed
      });
    } catch (e) {
      print('Error assigning admin role: $e');
    }
  }
}
