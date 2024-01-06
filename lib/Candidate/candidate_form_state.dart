import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Models/candidated.dart';

class CandidateFormController {
  CandidateFormController();
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  final worktitle = TextEditingController();
  final aadharno = TextEditingController();
  final gender = TextEditingController();
  final workexp = TextEditingController();
  final state = TextEditingController();
  final address = TextEditingController();
  final skills = TextEditingController();
  final workin = TextEditingController();
  final password = TextEditingController();
  final otpm = TextEditingController();
  final code = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  bool isAdmin = false;
  double commissionAmount = 0;

  // String get newDocId => FirebaseFirestore.instance.collection('Candidates').doc().id;

  DocumentReference? _reference;

  DocumentReference get reference {
    _reference ??= FirebaseFirestore.instance.collection('users').doc();
    return _reference!;
  }

  int leadCount = 0;
  int successfullLeadCount = 0;

  Candidate get candidate => Candidate(
        reference: reference,
        name: name.text,
        email: email.text,
        mobile: mobile.text,
        worktitle: worktitle.text,
        aadharno: aadharno.text,
        gender: gender.text,
        workexp: workexp.text,
        state: state.text,
        address: address.text,
        skills: skills.text,
        workin: workin.text,
        password: password.text,
        otpm: otpm.text,
        code: code.text,
        confirmPassword: confirmPassword.text,
      );

  factory CandidateFormController.fromCandidate(Candidate candidate) {
    var controller = CandidateFormController();
    controller.name.text = candidate.name!;
    controller.mobile.text = candidate.mobile!;
    controller.email.text = candidate.email!;
    controller.worktitle.text = candidate.worktitle!;
    controller._reference = candidate.reference;
    controller.aadharno.text = candidate.aadharno!;
    controller.gender.text = candidate.gender!;
    controller.workexp.text = candidate.workexp!;
    controller.state.text = candidate.state!;
    controller.address.text = candidate.address!;
    controller.skills.text = candidate.skills!;
    controller.workin.text = candidate.workin!;
    controller.password.text = candidate.password!;
    controller.otpm.text = candidate.otpm!;
    controller.code.text = candidate.code!;
    controller.confirmPassword.text = candidate.confirmPassword!;
    return controller;
  }
}
