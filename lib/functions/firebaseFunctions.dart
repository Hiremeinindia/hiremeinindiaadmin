import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static saveUser(String email, uid) async {
    await FirebaseFirestore.instance
        .collection('greycollaruser')
        .doc(uid)
        .set({'email': email});
  }
}
