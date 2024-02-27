import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../admin.dart';

class FirebaseService with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Admin>> getFilteredAdmins(
      String job, String qualification) async {
    Query<Map<String, dynamic>> baseQuery =
        _firestore.collection("greycollaruser");

    if (job != 'All') {
      baseQuery = baseQuery.where('jobClassification', isEqualTo: job);
    }

    if (qualification != 'All') {
      baseQuery = baseQuery.where('qualification', isEqualTo: qualification);
    }

    QuerySnapshot querySnapshot = await baseQuery.get();

    List<Admin> candidates = querySnapshot.docs.map((doc) {
      return Admin(
        reference: doc.reference,
        name: doc['name'].toString(),
        // Add other fields as needed
      );
    }).toList();

    notifyListeners(); // Notify listeners after data changes
    return candidates;
  }
}
