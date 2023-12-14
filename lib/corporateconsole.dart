import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/userdashboard.dart';
import 'package:hiremeinindiaapp/widgets/customtextfield.dart';
import 'package:hiremeinindiaapp/widgets/hiremeinindia.dart';
import 'package:hiremeinindiaapp/widgets/textstylebutton.dart';

import 'widgets/custombutton.dart';
import 'widgets/customcard.dart';

class CorporateConsole extends StatefulWidget {
  const CorporateConsole();
  @override
  State<CorporateConsole> createState() => _AdminDashboard();
}

class _AdminDashboard extends State<CorporateConsole> {
  @override
  bool isChecked = false;
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;

  bool dropdownValue = false;

  bool val1 = false;

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
                  Text(
                    'Corporate Console',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.indigo.shade900,
                        fontFamily: 'Poppins'),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Krithik',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          'Hr Manager',
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
            Container(
              padding:
                  EdgeInsets.only(left: 170, right: 170, top: 20, bottom: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: const Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Hello Krithik',
                                    style: CustomTextStyle.nameOfUser,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: items
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: CustomTextStyle.nameOflist,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              width: 270,
                              elevation: 1,
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down_sharp,
                              ),
                              iconSize: 45,
                              iconEnabledColor: Colors.indigo,
                              iconDisabledColor: null,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 210,
                              width: 270,
                              elevation: 0,
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black),
                                color: Colors.white,
                              ),
                              scrollPadding: EdgeInsets.all(5),
                              scrollbarTheme: ScrollbarThemeData(
                                thickness: MaterialStateProperty.all<double>(6),
                                thumbVisibility:
                                    MaterialStateProperty.all<bool>(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 50,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'HR Manager',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.indigo.shade900,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                        ),
                        Text('|'),
                        Text(
                          'Tata Salt',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.indigo.shade900,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ]),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 2,
                  ),
                ],
                borderRadius: BorderRadius.circular(1),
                border: Border.all(color: Colors.black12),
                color: Colors.white,
              ),
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Color.fromARGB(255, 104, 104, 208)),
                columns: [
                  DataColumn(
                      label: Text(
                    'Candidate',
                    style: CustomTextStyle.nameOfHeading,
                  )),
                  DataColumn(
                      label: Text('Verified',
                          style: CustomTextStyle.nameOfHeading)),
                  DataColumn(
                      label: Text('Qualificatiom',
                          style: CustomTextStyle.nameOfHeading)),
                  DataColumn(
                      label: Text('Job Classification 1',
                          style: CustomTextStyle.nameOfHeading)),
                  DataColumn(
                      label: Text('Job Classification 2',
                          style: CustomTextStyle.nameOfHeading)),
                  DataColumn(
                      label:
                          Text('Label', style: CustomTextStyle.nameOfHeading)),
                  DataColumn(
                      label: Text('No of Days open',
                          style: CustomTextStyle.nameOfHeading)),
                  DataColumn(
                      label:
                          Text('CV Doc', style: CustomTextStyle.nameOfHeading)),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text(
                      'xxxxxxxxxxxxxxx',
                      style: CustomTextStyle.nameOflist,
                    )),
                    DataCell(Text(
                      '',
                      style: CustomTextStyle.nameOflist,
                    )),
                    DataCell(Text(
                      'xxxxxxxxxxxxxxx',
                      style: CustomTextStyle.nameOflist,
                    )),
                    DataCell(Text(
                      'Senior plumber',
                      style: CustomTextStyle.nameOflist,
                    )),
                    DataCell(Text(
                      'Senior plumber',
                      style: CustomTextStyle.nameOflist,
                    )),
                    DataCell(Text(
                      'blue',
                      style: CustomTextStyle.nameOflist,
                    )),
                    DataCell(Text(
                      '60',
                      style: CustomTextStyle.nameOflist,
                    )),
                    DataCell(Text(
                      'xxxxxxxxxxxxxxx',
                      style: CustomTextStyle.nameOflist,
                    )),
                  ]),
                ],
              ),
            ),
            SizedBox(
              height: 75,
            ),
          ],
        ));
  }
}
