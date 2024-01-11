import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  String verificationId = '';
  bool isVerified = false;

  void _sendOTP() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+91${_phoneNumberController.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          setState(() {
            isVerified = true;
          });
          print('Verification Completed');
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Verification Failed: $e');
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            this.verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval timeout
          print('Auto-Retrieval Timeout');
        },
        timeout: Duration(seconds: 60),
      );
    } catch (e) {
      print('Error Sending OTP: $e');
    }
  }

  void _verifyOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: _otpController.text,
      );

      await _auth.signInWithCredential(credential);
      setState(() {
        isVerified = true;
      });
      print('OTP Verified');
    } catch (e) {
      print('Error Verifying OTP: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OTP Verification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isVerified ? null : _sendOTP,
              child: Text(isVerified ? 'Verified' : 'Verify'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter OTP'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isVerified ? null : _verifyOTP,
              child: Text(isVerified ? 'Verified' : 'Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
