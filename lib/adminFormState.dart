import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'admin.dart';

class AdminFormController {
  AdminFormController();
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();

  // String get newDocId => FirebaseFirestore.instance.collection('Admins').doc().id;

  DocumentReference? _reference;

  DocumentReference get reference {
    _reference ??= FirebaseFirestore.instance.collection('corporateuser').doc();
    return _reference!;
  }

  Admin get corporate => Admin(
        reference: reference,
        name: name.text,
        email: email.text,
        password: password.text,
      );
}
