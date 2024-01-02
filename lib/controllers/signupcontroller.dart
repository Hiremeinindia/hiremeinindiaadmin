import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hiremeinindiaapp/repository/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final name = TextEditingController();
  final worktitle = TextEditingController();
  final aadharno = TextEditingController();
  final gender = TextEditingController();
  final workexp = TextEditingController();
  final state = TextEditingController();
  final address = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();
  final skills = TextEditingController();
  final workin = TextEditingController();
  final password = TextEditingController();
  final otpm = TextEditingController();
  final code = TextEditingController();

  final otp = TextEditingController();
  void registerUser(String email, String password) {
    String? error = AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString()));
    }
  }
}
