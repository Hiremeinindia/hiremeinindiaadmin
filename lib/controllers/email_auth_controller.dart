import 'package:email_auth/email_auth.dart';
import 'package:get/get.dart';

class EmailAuthController extends GetxController {
  EmailAuth emailAuth = EmailAuth(sessionName: "code session");
  var status = "".obs;
  void sendOTP(String mail) async {
    var res = await emailAuth.sendOtp(recipientMail: mail, otpLength: 4);
    if (res) {
      status.value = "OTP Sent";
    } else {
      status.value = "OTP not Sent";
    }
  }

  void validateOTP(String mail, String motp) async {
    var res = await emailAuth.validateOtp(recipientMail: mail, userOtp: motp);
    if (res) {
      status.value = "OTP verified";
    } else {
      status.value = "OTP not verified";
    }
  }
}
