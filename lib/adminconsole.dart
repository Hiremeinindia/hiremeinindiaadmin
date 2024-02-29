import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/customcard.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sizer/sizer.dart';

import 'classes/language_constants.dart';
import 'widgets/customtextstyle.dart';
import 'widgets/hiremeinindia.dart';

class AdminConsole extends StatefulWidget {
  final User? user;
  final String? imageUrl;
  AdminConsole({this.user, this.imageUrl});
  @override
  State<AdminConsole> createState() => _AdminDashboard();
}

class _AdminDashboard extends State<AdminConsole> {
  int cashReceiptCount = 0;
  bool isChecked = false;
  bool isRequestRecived = false;
  String _userName = '';
  late String imageUrl;
  String? _cashReceiptUrl;
  bool isArrowClick = false;
  late Stream<Map<String, dynamic>?> userStream;
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
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Future<void> showNotification() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'your_channel_id',
  //     'Your channel name',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     'Cash Received and Verified',
  //     'The cash payment has been received and verified!!!',
  //     platformChannelSpecifics,
  //   );
  // }

  // Future<void> sendCashNotification(String imageUrl) async {
  //   cashReceiptCount++;
  //   print("cash1");``
  //   final String serverUrl = 'http://localhost:3019';
  //   final String endpoint = '/cashNotification';

  //   try {
  //     // Check if the provided imageUrl is not null
  //     if (imageUrl != null) {
  //       print("cash2");
  //       final response = await http.post(
  //         Uri.parse('$serverUrl$endpoint'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //         },
  //         body: jsonEncode(<String, dynamic>{
  //           'cashrecipt': imageUrl, // Pass the imageUrl parameter
  //           'cashReceiptCount': cashReceiptCount,
  //         }),
  //       );

  //       if (response.statusCode == 200) {
  //         print("cash3");
  //         // Extract cash receipt information from the response
  //         Map<String, dynamic> receiptInfo = json.decode(response.body);

  //         // Fetch the image from Firebase Storage
  //         final fetchedImageUrl =
  //             receiptInfo['cashrecipt']; // Correct key to fetch imageUrl

  //         if (fetchedImageUrl != null) {
  //           print("cash4");
  //           // Show the dialog after fetching the image
  //           showDialog(
  //             context: context,
  //             builder: (BuildContext context) {
  //               return AlertDialog(
  //                 title: Text('Cash Received and Verified'),
  //                 content: FutureBuilder(
  //                   future: fetchAndDisplayImageFromFirestore(fetchedImageUrl),
  //                   builder: (context, snapshot) {
  //                     if (snapshot.connectionState == ConnectionState.waiting) {
  //                       return CircularProgressIndicator();
  //                     } else if (snapshot.hasError) {
  //                       return Text('Error: ${snapshot.error}');
  //                     } else {
  //                       return snapshot.data as Widget;
  //                     }
  //                   },
  //                 ),
  //                 actions: <Widget>[
  //                   TextButton(
  //                     onPressed: () {
  //                       Navigator.of(context).pop(); // Close the dialog
  //                       // Show the notification only after verifying the image
  //                       showNotification();
  //                     },
  //                     child: Text('OK'),
  //                   ),
  //                 ],
  //               );
  //             },
  //           );
  //         } else {
  //           print("cash4");
  //           print('Error: imageUrl is null');
  //         }
  //       } else {
  //         print("cash5");
  //         print(
  //           'Failed to send notification. Status code: ${response.statusCode}',
  //         );
  //       }
  //     } else {
  //       print("cash6");
  //       print('Error: imageUrl is null');
  //     }
  //   } catch (error) {
  //     print('Error sending notification: $error');
  //     // Handle network-related errors gracefully
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Error'),
  //           content: Text(
  //             'Failed to send notification. Please check your internet connection and try again.',
  //           ),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop(); // Close the dialog
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  // Future<Widget> fetchAndDisplayImageFromFirestore(String? imageUrl) async {
  //   if (imageUrl == null) {
  //     return Text('Error: Image URL is null');
  //   }

  //   try {
  //     // Fetch the image URL from Firestore
  //     final ref =
  //         FirebaseFirestore.instance.collection('greycollaruser').doc(imageUrl);
  //     final doc = await ref.get();

  //     if (doc.exists) {
  //       // Get the URL from the document data
  //       final url = doc.data()?['cashrecipt'];

  //       if (url != null) {
  //         // Fetch the image from the URL
  //         final response = await http.get(Uri.parse(url));

  //         if (response.statusCode == 200) {
  //           // Display the received image
  //           return Image.memory(
  //             response.bodyBytes,
  //             width: 200, // Adjust width as needed
  //             height: 200, // Adjust height as needed
  //           );
  //         } else {
  //           return Text(
  //               'Failed to load image. Status code: ${response.statusCode}');
  //         }
  //       } else {
  //         return Text('Error: Image URL is null in Firestore');
  //       }
  //     } else {
  //       return Text('Error: Document does not exist in Firestore');
  //     }
  //   } catch (error) {
  //     print('Error fetching and displaying image: $error');
  //     return Text('Error: $error');
  //   }
  // }

  void initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> _getCashReceipt() async {
    final response =
        await http.get(Uri.parse('http://localhost:3019/getCashReceipt'));
    if (response.statusCode == 200) {
      final cashReceiptData = json.decode(response.body);
      setState(() {
        _cashReceiptUrl = cashReceiptData['cashreceiptUrl'];
      });
    } else {
      print('Failed to fetch cash receipt');
    }
  }

  Stream<Map<String, dynamic>?> fetchUserName() {
    try {
      return FirebaseFirestore.instance
          .collection('adminuser')
          .doc(widget.user!.uid)
          .snapshots()
          .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> data = documentSnapshot.data()!;
          String name = data['name'];
          _userName = name;
          return data;
        } else {
          print('Document does not exist');
          return null;
        }
      });
    } catch (e) {
      print('Error fetching data: $e');
      return Stream.value(null);
    }
  }

  Future<int> CompanyCount() async {
    var query = await FirebaseFirestore.instance.collection("corporateuser");
    var snapshot = await query.get();
    var count = snapshot.size;
    return count; // Add this line to return the count
  }

  Future<int> CashCount() async {
    var query = await FirebaseFirestore.instance.collection("messages");
    var snapshot = await query.get();
    var count = snapshot.size;
    return count; // Add this line to return the count
  }

  Future<int> UserCount() async {
    var query = await FirebaseFirestore.instance.collection("greycollaruser");
    var snapshot = await query.get();
    var count = snapshot.size;
    return count; // Add this line to return the count
  }

  Future<void> fetchImageUrl() async {
    print("fetch1");
    try {
      // Reference to the Firestore collection where image URLs are stored
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('greycollaruser');

      // Fetch the documents from the collection
      QuerySnapshot querySnapshot = await collectionReference.get();

      // Check if there are any documents in the collection
      if (querySnapshot.docs.isNotEmpty) {
        print("fetch2");
        // Get the first document (you may need to adjust this based on your data model)
        DocumentSnapshot documentSnapshot = querySnapshot.docs.last;

        // Get the data from the document
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Get the imageUrl field from the document data
        String? fetchedImageUrl = data['cashreceipt'];

        // Update the state with the fetched image URL
        setState(() {
          imageUrl = fetchedImageUrl!;
        });
      } else {
        print('No documents found in the collection');
      }
    } catch (error) {
      print("fetch3");
      print('Error fetching image URL from Firestore: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    initializeLocalNotifications();
    fetchImageUrl();
    userStream = fetchUserName().map((data) => data);
    selectedValue = items.first; // Set the initial value
  }

  Widget build(BuildContext context) {
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
                    Text(
                      'Admin Console',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.indigo.shade900,
                          fontFamily: 'Poppins'),
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
                    StreamBuilder<Map<String, dynamic>?>(
                      stream: userStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          // Display the user's name
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$_userName',
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
                                'Admin',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.indigo.shade900,
                                    height: 0),
                              ),
                            ],
                          );
                        } else {
                          // Loading or error state
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(left: 7.w, right: 7.w, top: 7.h, bottom: 7.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: StreamBuilder<Map<String, dynamic>?>(
                  stream: userStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      // Display the user's name
                      return Center(
                        child: Row(
                          children: [
                            Text(
                              "${translation(context).hello} $_userName",
                              style: CustomTextStyle.nameOfUser,
                              overflow: TextOverflow.ellipsis,
                            ),
                            IconButton(
                              hoverColor: Colors.transparent,
                              icon: Icon(Icons.arrow_drop_down_sharp),
                              iconSize: 30,
                              color: Colors.indigo.shade900,
                              onPressed: () {
                                setState(() {
                                  isArrowClick = !isArrowClick;
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      // Loading or error state
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              StreamBuilder<Map<String, dynamic>?>(
                stream: userStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    // Display the user's name
                    return Visibility(
                      visible: isArrowClick,
                      child: Row(
                        children: [
                          Text(
                            'Admin',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.indigo.shade900,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                          ),
                          // Text('|'),
                          // Text(
                          //   '$_companyName',
                          //   style: TextStyle(
                          //       fontSize: 15,
                          //       color: Colors.indigo.shade900,
                          //       fontWeight: FontWeight.bold,
                          //       fontFamily: 'Poppins'),
                          // ),
                        ],
                      ),
                    );
                  } else {
                    // Loading or error state
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    // onTap: () {
                    //   setState(() {
                    //     _currentStream = AllCandidates();
                    //   });
                    // },
                    child: Container(
                      height: 12.h,
                      width: 11.w,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 140, 138, 138),
                            spreadRadius: 0.5, //spread radius
                            blurRadius: 4, // blu
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color.fromARGB(255, 160, 67, 66),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              translation(context).noOfCandidates,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            FutureBuilder<int>(
                              future: CompanyCount(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  int totalDocCount = snapshot.data ?? 0;
                                  return Text(
                                    ' $totalDocCount',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  InkWell(
                    // onTap: () {
                    //   setState(() {
                    //     _currentStream = BlueCandidates();
                    //   });
                    // },
                    child: Container(
                      height: 12.h,
                      width: 11.w,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 140, 138, 138),
                            spreadRadius: 0.5, //spread radius
                            blurRadius: 4, // blu
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(255, 118, 170, 73),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              translation(context).noOfCompanies,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            FutureBuilder<int>(
                              future: UserCount(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  int docCount = snapshot.data ?? 0;
                                  return Text(
                                    '$docCount',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  InkWell(
                    // onTap: () {
                    //   setState(() {
                    //     _currentStream = GreyCandidates();
                    //   });
                    // },
                    child: Container(
                      height: 12.h,
                      width: 11.w,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 140, 138, 138),
                              spreadRadius: 0.5, //spread radius
                              blurRadius: 4, // blu
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color.fromARGB(192, 190, 56, 116)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              translation(context).greyColler,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            FutureBuilder<int>(
                              future: UserCount(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  int docCount = snapshot.data ?? 0;
                                  return Text(
                                    ' $docCount',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 150,
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Payments",
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.indigo.shade900,
                        fontWeight: FontWeight.w100,
                        fontFamily: 'Poppins'),
                  ),
                  SizedBox(
                    width: 100,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Row(
                          children: [
                            Text(
                              "Today",
                              // style: CustomTextStyle.nameOfHeading,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        items: items
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    // style: CustomTextStyle.nameOflist,
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
                          height: 30,
                          width: 200,
                          elevation: 1,
                          padding: const EdgeInsets.only(left: 14, right: 14),
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
                          iconSize: 14,
                          iconEnabledColor: Colors.grey,
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
                          height: 25,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 75,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 115,
                        width: 215,
                        color: Colors.red.shade200,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 10,
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierColor: Color(0x00ffffff),
                                    builder: (context) {
                                      return Dialog(
                                        child: Container(
                                          color: Colors.amber.shade200,
                                          height: 200,
                                          width: 200,
                                          child: _cashReceiptUrl != null
                                              ? Image.network(_cashReceiptUrl!)
                                              : Text(
                                                  'Cash receipt not available',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                            255, 140, 138, 138),
                                        spreadRadius: 0.5,
                                        blurRadius: 4,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10.0),
                                    color:
                                        const Color.fromARGB(255, 125, 83, 196),
                                  ),
                                  width: 200,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Cash',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        FutureBuilder<int>(
                                          future: UserCount(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            } else {
                                              int totalDocCount =
                                                  snapshot.data ?? 0;
                                              return Text(
                                                ' $totalDocCount',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                left: 180,
                                bottom: 90,
                                child: _cashReceiptUrl != null
                                    ? Icon(
                                        Icons.circle,
                                        color: Colors.red,
                                        // Set icon color based on flag
                                      )
                                    : SizedBox())
                          ],
                        ),
                      ),
                      // Only show the button if imageUrl is null
                      ElevatedButton(
                        onPressed: _getCashReceipt,
                        child: Text('Fetch Image URL'),
                      ),
                      if (imageUrl !=
                          null) // Only show the button if imageUrl is null
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(' Image URL'),
                        ),
                      if (_cashReceiptUrl !=
                          null) // Only show the image if imageUrl is not null
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            _cashReceiptUrl!,
                            width: 200,
                            height: 200,
                            errorBuilder: (context, error, stackTrace) {
                              // Handle the error here
                              return Center(
                                child: Text('Error loading image'),
                              );
                            },
                          ),
                        ),
                      InkWell(
                        // onTap: () {
                        //   setState(() {
                        //     _currentStream = BlueCandidates();
                        //   });
                        // },
                        child: Container(
                          height: 12.h,
                          width: 11.w,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 140, 138, 138),
                                spreadRadius: 0.5, //spread radius
                                blurRadius: 4, // blu
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color.fromARGB(255, 125, 83, 196),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  translation(context).online,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                FutureBuilder<int>(
                                  future: UserCount(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      int docCount = snapshot.data ?? 0;
                                      return Text(
                                        '$docCount',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Total",
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.indigo.shade900,
                        fontWeight: FontWeight.w100,
                        fontFamily: 'Poppins'),
                  ),
                  // Check if request is received
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
