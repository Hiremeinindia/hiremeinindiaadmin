import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/widgets/custombutton.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sizer/sizer.dart';

import 'widgets/customcard.dart';

class Sample extends StatefulWidget {
  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  List<String> notificationMessages = [];
  bool isIconEnabled = false;

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _configureFirebaseMessaging();
  }

  void _configureFirebaseMessaging() {
    FirebaseFirestore.instance
        .collection('messages')
        .snapshots()
        .listen((snapshot) {
      for (var docChange in snapshot.docChanges) {
        if (docChange.type == DocumentChangeType.added) {
          _showNotification(docChange.doc['message']);
          setState(() {
            notificationMessages.add(docChange.doc['message']);
            isIconEnabled =
                true; // Set the flag to true when a message is received
          });
        }
      }
    });
  }

  Future<int> CashCount() async {
    var query = await FirebaseFirestore.instance.collection("messages");
    var snapshot = await query.get();
    var count = snapshot.size;
    return count; // Add this line to return the count
  }

  Future<void> _showNotification(String message) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      icon: '@mipmap/ic_launcher', // Set your custom icon here
    );
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'New Message',
      message,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Receiver App')),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: notificationMessages.isEmpty
                    ? Center(child: Text('No notifications'))
                    : ListView.builder(
                        itemCount: notificationMessages.length,
                        itemBuilder: (context, index) {
                          return NotificationWidget(
                              message: notificationMessages[index]);
                        },
                      ),
              ),
              notificationMessages.isEmpty
                  ? Container(
                      height: 115,
                      width: 215,
                      color: Colors.red.shade200,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10,
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(
                                        255, 140, 138, 138),
                                    spreadRadius: 0.5, //spread radius
                                    blurRadius: 4, // blu
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color.fromARGB(255, 125, 83, 196),
                              ),
                              width: 200,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                      future: CashCount(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
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
                    )
                  : Container(
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
                                          child: Text(
                                            notificationMessages.isNotEmpty
                                                ? notificationMessages.last
                                                : 'No notifications',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(
                                          255, 140, 138, 138),
                                      spreadRadius: 0.5, //spread radius
                                      blurRadius: 4, // blu
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10.0),
                                  color:
                                      const Color.fromARGB(255, 125, 83, 196),
                                ),
                                width: 200,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        future: CashCount(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return CircularProgressIndicator();
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
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
                          ),
                          Positioned(
                              left: 180,
                              bottom: 90,
                              child: isIconEnabled
                                  ? Icon(Icons.circle, color: Colors.red
                                      // Set icon color based on flag
                                      )
                                  : SizedBox()),
                        ],
                      ),
                    ),
              SizedBox(
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationWidget extends StatefulWidget {
  final String message;

  const NotificationWidget({Key? key, required this.message}) : super(key: key);

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.message),
      ),
    );
  }
}
