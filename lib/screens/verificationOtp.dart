// ignore_for_file: unnecessary_const, file_names, prefer_const_constructors

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:lucky_wheel/provider/auth.dart';
import 'package:lucky_wheel/screens/home_page.dart';
import 'dart:async';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Verificatoin extends StatefulWidget {
  static const routeName = '/otp';
  const Verificatoin({Key? key}) : super(key: key);

  @override
  _VerificatoinState createState() => _VerificatoinState();
}

class _VerificatoinState extends State<Verificatoin> {
  bool _onEditing = true;
  bool _isResendAgain = false;
  bool _isVerified = false;
  bool _isLoading = false;
  String _verificationCode = '';
  String phone = '';

  String _code = '';

  @override
  void initState() {
    super.initState();
    phone = Provider.of<Auth>(context, listen: false).phoneNumber;
    // sent_otp();
    // Provider.of<Auth>(context, listen: false).sent_otp();
  }

  // Future sent_otp() async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: Provider.of<Auth>(context, listen: false).phoneNumber,
  //     verificationCompleted: (PhoneAuthCredential credential) {
  //       print(12344444444444);
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       if (e.code == 'invalid-phone-number') {
  //         print('The provided phone number is not valid.');
  //       }

  //       // Handle other errors
  //     },
  //     codeSent: (String verificationId, int? resendToken) async {
  //       setState(() {
  //         _verificationCode = verificationId;
  //       });
  //     },
  //     codeAutoRetrievalTimeout: (String verificationID) {
  //       setState(() {
  //         _verificationCode = verificationID;
  //       });
  //     },
  //   );
  // }

  late Timer _timer;
  int _start = 60;

  void startTimer() {
    setState(() {
      _isResendAgain = true;
    });

    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (_start == 0) {
            _start = 60;
            _isResendAgain = false;
            timer.cancel();
          } else {
            _start--;
          }
        });
      },
    );
  }

  verify() {
    setState(() {
      _isLoading = true;
    });

    const oneSec = const Duration(milliseconds: 1000);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          _isLoading = false;
          _isVerified = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF9408C2),
            Color(0xFF313D8A),
            Color(0xFF15002C),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [
            0.01,
            0.3,
            0.8,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey.shade200),
                  child: Transform.rotate(
                    angle: 38,
                    child: Image.asset('assets/images/email.png'),
                  ),
                ),
                SizedBox(height: 80),
                Text(
                  "Verification",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Please enter the 6 digit code sent to \n ${phone}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16, height: 1.5, color: Colors.grey[350]),
                ),
                SizedBox(
                  height: 30,
                ),
                VerificationCode(
                  textStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                  underlineColor: Colors.blueAccent,
                  // fillColor: Colors.white,
                  keyboardType: TextInputType.number,
                  length: 6,
                  onCompleted: (String value) async {
                    setState(() {
                      _code = value;
                    });

                    print(value);

                    // try {
                    //   await FirebaseAuth.instance
                    //       .signInWithCredential(PhoneAuthProvider.credential(
                    //           verificationId: _verificationCode, smsCode: value))
                    //       .then((value) async {
                    //     if (value.user != null) {
                    //       print("donoeooeoeooeoeoeoee");
                    //       print(value.user);
                    //     }
                    //   });
                    // } catch (e) {
                    //   print(e);
                    //   print('invalid OTP');
                    // }

                    Provider.of<Auth>(context, listen: false)
                        .verify(value, context);
                    //// SharedPreferences prefs =
                    //     await SharedPreferences.getInstance();
                    // var userData = json.encode({
                    //   'user': value.user,
                    // });
                    // prefs.setString('userData', userData);
                  },
                  onEditing: (bool value) {
                    setState(() {
                      _onEditing = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't resive the OTP?",
                      style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.grey.shade500),
                    ),
                    TextButton(
                        onPressed: () {
                          if (_isResendAgain) return;
                          startTimer();
                          Provider.of<Auth>(context, listen: false).sent_otp();
                        },
                        child: Text(
                          _isResendAgain
                              ? 'Try again in ' + _start.toString()
                              : "Resend",
                          style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: Colors.blueAccent),
                        )),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
