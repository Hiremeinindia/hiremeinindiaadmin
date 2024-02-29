import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  String name;
  String? email;
  String? password;
  DocumentReference? reference;

  Admin({
    required this.name,
    this.email,
    this.password,
    this.reference,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "reference": reference,
        "email": email,
        "password": password,
      };

  static Admin fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Admin(
      name: data["name"],
      email: data["email"],
      reference: snapshot.reference,
      password: data["password"],
    );
  }

  factory Admin.fromJson(data) {
    return Admin(
      name: data["name"],
      email: data["email"],
      reference: data["reference"],
      password: data["password"],
    );
  }

  static Future<List<Admin>> getAdmins() {
    return FirebaseFirestore.instance
        .collection('admin')
        .get()
        .then((value) => value.docs.map((e) => Admin.fromSnapshot(e)).toList());
  }
}
