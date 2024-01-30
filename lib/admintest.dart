import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/customcard.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AdminConsole1 extends StatefulWidget {
  const AdminConsole1();
  @override
  State<AdminConsole1> createState() => _AdminDashboard();
}

class _AdminDashboard extends State<AdminConsole1> {
  bool isChecked = false;
  String? imageUrl;
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

  Future<void> fetchImageUrl() async {
    print("fetch1");
    try {
      // Reference to the Firestore collection where image URLs are stored
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('greyusercollar');

      // Fetch the documents from the collection
      QuerySnapshot querySnapshot = await collectionReference.get();

      // Check if there are any documents in the collection
      if (querySnapshot.docs.isNotEmpty) {
        print("fetch2");
        // Get the first document (you may need to adjust this based on your data model)
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

        // Get the data from the document
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Get the imageUrl field from the document data
        String? fetchedImageUrl = data['imageUrl'];

        // Update the state with the fetched image URL
        setState(() {
          imageUrl = fetchedImageUrl;
        });
      } else {
        print("fetch3");
        print('No documents found in the collection');
      }
    } catch (error) {
      print("fetch4");
      print('Error fetching image URL from Firestore: $error');
    }
  }

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'Your channel name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Cash Received and Verified',
      'The cash payment has been received and verified!!!',
      platformChannelSpecifics,
    );
  }

  Future<void> sendCashNotification(String imageUrl) async {
    print("cash1");
    final String serverUrl = 'http://localhost:3018';
    final String endpoint = '/cashNotification';

    try {
      // Check if the provided imageUrl is not null
      if (imageUrl != null) {
        print("cash2");
        final response = await http.post(
          Uri.parse('$serverUrl$endpoint'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'imageUrl': imageUrl, // Pass the imageUrl parameter
          }),
        );

        if (response.statusCode == 200) {
          print("cash3");
          // Extract cash receipt information from the response
          Map<String, dynamic> receiptInfo = json.decode(response.body);

          // Fetch the image from Firebase Storage
          final fetchedImageUrl =
              receiptInfo['imageUrl']; // Correct key to fetch imageUrl

          if (fetchedImageUrl != null) {
            print("cash4");
            // Show the dialog after fetching the image
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Cash Received and Verified'),
                  content: FutureBuilder(
                    future: fetchAndDisplayImageFromFirestore(fetchedImageUrl),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return snapshot.data as Widget;
                      }
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        // Show the notification only after verifying the image
                        showNotification();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else {
            print("cash4");
            print('Error: imageUrl is null');
          }
        } else {
          print("cash5");
          print(
            'Failed to send notification. Status code: ${response.statusCode}',
          );
        }
      } else {
        print("cash6");
        print('Error: imageUrl is null');
      }
    } catch (error) {
      print('Error sending notification: $error');
      // Handle network-related errors gracefully
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
              'Failed to send notification. Please check your internet connection and try again.',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<Widget> fetchAndDisplayImageFromFirestore(String? imageUrl) async {
    if (imageUrl == null) {
      return Text('Error: Image URL is null');
    }

    try {
      // Fetch the image URL from Firestore
      final ref =
          FirebaseFirestore.instance.collection('greyusercollar').doc(imageUrl);
      final doc = await ref.get();

      if (doc.exists) {
        // Get the URL from the document data
        final url = doc.data()?['imageUrl'];

        if (url != null) {
          // Fetch the image from the URL
          final response = await http.get(Uri.parse(url));

          if (response.statusCode == 200) {
            // Display the received image
            return Image.memory(
              response.bodyBytes,
              width: 200, // Adjust width as needed
              height: 200, // Adjust height as needed
            );
          } else {
            return Text(
                'Failed to load image. Status code: ${response.statusCode}');
          }
        } else {
          return Text('Error: Image URL is null in Firestore');
        }
      } else {
        return Text('Error: Document does not exist in Firestore');
      }
    } catch (error) {
      print('Error fetching and displaying image: $error');
      return Text('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    initializeLocalNotifications();
    selectedValue = items.first; // Set the initial value
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Hire',
                  style: TextStyle(
                      color: Colors.indigo.shade900,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      fontSize: 25),
                ),
                TextSpan(
                  text: 'mein',
                  style: TextStyle(
                      color: Color.fromARGB(255, 27, 105, 178),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      fontSize: 25),
                ),
                TextSpan(
                  text: 'India',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      fontSize: 25),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 50.0, top: 10),
            child: Row(
              children: [
                Text(
                  'Admin Console',
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
                        'Suresh',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        'Admin',
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
                    // DropdownButtonHideUnderline(
                    //   child: DropdownButton2<String>(
                    //     isExpanded: true,
                    //     hint: const Row(
                    //       children: [
                    //         Align(
                    //           alignment: Alignment.centerLeft,
                    //           child: Text(
                    //             'Hello Suresh',
                    //             style: CustomTextStyle.nameOfUser,
                    //             overflow: TextOverflow.ellipsis,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     items: items
                    //         .map((String item) => DropdownMenuItem<String>(
                    //               value: item,
                    //               child: Text(
                    //                 item,
                    //                 style: CustomTextStyle.nameOflist,
                    //                 overflow: TextOverflow.ellipsis,
                    //               ),
                    //             ))
                    //         .toList(),
                    //     value: selectedValue,
                    //     onChanged: (String? value) {
                    //       setState(() {
                    //         selectedValue = value;
                    //       });
                    //     },
                    //     buttonStyleData: ButtonStyleData(
                    //       height: 50,
                    //       width: 270,
                    //       elevation: 1,
                    //     ),
                    //     iconStyleData: const IconStyleData(
                    //       icon: Icon(
                    //         Icons.arrow_drop_down_sharp,
                    //       ),
                    //       iconSize: 45,
                    //       iconEnabledColor: Colors.indigo,
                    //       iconDisabledColor: null,
                    //     ),
                    //     dropdownStyleData: DropdownStyleData(
                    //       maxHeight: 210,
                    //       width: 270,
                    //       elevation: 0,
                    //       padding: EdgeInsets.only(
                    //           left: 10, right: 10, top: 5, bottom: 15),
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(5),
                    //         border: Border.all(color: Colors.black),
                    //         color: Colors.white,
                    //       ),
                    //       scrollPadding: EdgeInsets.all(5),
                    //       scrollbarTheme: ScrollbarThemeData(
                    //         thickness: MaterialStateProperty.all<double>(6),
                    //         thumbVisibility: MaterialStateProperty.all<bool>(
                    //           true,
                    //         ),
                    //       ),
                    //     ),
                    //     menuItemStyleData: const MenuItemStyleData(
                    //       height: 50,
                    //       padding: EdgeInsets.only(left: 14, right: 14),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    CustomCard(
                      color: Color.fromARGB(255, 153, 51, 49),
                      title1: "NoOfCandidates",
                      title2: '1',
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    CustomCard(
                      color: Color.fromARGB(255, 105, 182, 46),
                      title1: "NoOfCompanies",
                      title2: '100',
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    CustomCard(
                      color: Color.fromARGB(255, 138, 40, 156),
                      title1: "Candidates",
                      title2: '100',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminConsole1()),
                        );
                      },
                    ),
                    SizedBox(
                      width: 60,
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
                    GestureDetector(
                      onTap: () async {
                        try {
                          print("hello1");
                          // Call fetchImageUrl to retrieve the image URL
                          await fetchImageUrl();
                          // Call the sendCashNotification method with the retrieved imageUrl
                          if (imageUrl != null) {
                            print("hello2");
                            sendCashNotification(imageUrl!);
                          } else {
                            print('Error: imageUrl is null');
                          }
                        } catch (error) {
                          print('Error: $error');
                        }
                      },
                      child: CustomCard(
                        color: const Color.fromARGB(255, 125, 83, 196),
                        title1: "Cash",
                        title2: '1',
                      ),
                    ),
// Add the ElevatedButton and SizedBox here
                    if (imageUrl ==
                        null) // Only show the button if imageUrl is null
                      ElevatedButton(
                        onPressed: fetchImageUrl,
                        child: Text('Fetch Image URL'),
                      ),
                    if (imageUrl !=
                        null) // Only show the image if imageUrl is not null
                      Column(
                        children: [
                          SizedBox(height: 20),
                          Image.network(
                            imageUrl!,
                            width: 200,
                            height: 200,
                          ),
                        ],
                      ),

                    SizedBox(
                      width: 60,
                    ),
                    CustomCard(
                      color: const Color.fromARGB(255, 125, 83, 196),
                      title1: "Online",
                      title2: '100',
                    ),
                    Spacer(),
                    Text(
                      "Total",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.indigo.shade900,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
