import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import '../Widgets/customTextstyle.dart';
import '../widgets/customcard.dart';
import '../widgets/hiremeinindia.dart';

class AdminConsole extends StatefulWidget {
  const AdminConsole();

  @override
  State<AdminConsole> createState() => _AdminConsoleState();
}

class _AdminConsoleState extends State<AdminConsole> {
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

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
            'app_icon'); // Replace 'app_icon' with your app's launcher icon
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id', // Replace 'your_channel_id' with your desired channel ID
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

  Future<void> sendCashNotification(http.MultipartFile cashReceipt) async {
    final String serverUrl = 'http://localhost:3013';
    final String endpoint = '/cashNotification';

    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$serverUrl$endpoint'))
            ..files.add(cashReceipt);

      final response = await request.send();

      if (response.statusCode == 200) {
        // Read the response body as a string
        String responseBody = await response.stream.bytesToString();

        // Display a popup message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Cash Received and Verified'),
              content: Column(
                children: [
                  Text('The cash payment has been received and verified!!!.'),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Show the received cash receipt
                      showCashReceiptDialog(responseBody);
                    },
                    child: Text('View Cash Receipt'),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    showNotification(); // Show the notification
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );

        // Increment badge count and show notification in the top left corner
        FlutterAppBadger.updateBadgeCount(1); // Set badge count to 1
        showNotification();
      } else {
        print(
          'Failed to send notification. Status code: ${response.statusCode}',
        );
      }
    } catch (error) {
      print('Error sending notification: $error');
    }
  }

  void showCashReceiptDialog(String cashReceiptData) {
    // Display a dialog to show the received cash receipt
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Received Cash Receipt'),
          content: Text('Cash Receipt Data: $cashReceiptData'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initializeLocalNotifications();
    selectedValue = items.first; // Set the initial value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: HireMeInIndia(),
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
    );
  }
}
