// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucky_wheel/provider/user_data.dart';
import 'package:lucky_wheel/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String token = '';
  String userId = '';
  String phoneNumber = '';
  String _verificationCode = '';
  User? user;
  var currentUser;
  var homePagedata;

  void userInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = json.encode({
      'user': currentUser,
    });
    prefs.setString('userData', userData);
  }

  Future sent_otp() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        print(12344444444444);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }

        // Handle other errors
      },
      codeSent: (String verificationId, int? resendToken) async {
        _verificationCode = verificationId;
        // print('${_verificationCode} me yaha hu');
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        _verificationCode = verificationID;
      },
    );
    notifyListeners();
  }

  ///verify wala code
  ///
  ///
  ///
  Future<void> verify(var value, BuildContext ctx) async {
    // print('${_verificationCode}looooooo match krlo');
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode, smsCode: value))
          .then((value) async {
        if (value.user != null) {
          currentUser = value.user;
          print("donoeooeoeooeoeoeoee");
          // homePagedata = Provider.of<UserData>(ctx).fetchAndSetAmount('Sufyan');
          Navigator.of(ctx).pushReplacementNamed(HomePage.routeName);
          print(value.user);
        }
      });
    } catch (e) {
      print(e);
      print('invalid OTP');
      ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(
            'Invalid OTP ',
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 2),
        ),
      );
      // notifyListeners();
    }
  }
}
