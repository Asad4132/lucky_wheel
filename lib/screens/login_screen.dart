// ignore_for_file: unnecessary_string_escapes, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucky_wheel/provider/auth.dart';
import 'package:lucky_wheel/screens/verificationOtp.dart';
import 'package:provider/provider.dart';
import '../pallete.dart';
import '../widgets/widgets.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends StatelessWidget {
  final phoneController = TextEditingController();

  // Future<void> sendOtp(String phone, BuildContext context) async {
  //   Provider.of<Auth>(context, listen: false).phone = phone;

  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _isloading = false;
    String? _phone;
    return Stack(
      children: [
        const BackgroundImage(
          imageUrl: 'https://mcdn.wallpapersafari.com/medium/10/22/f4aH7I.jpg',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              const Flexible(
                child: Center(
                  child: Text(
                    'GameLook',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: size.height * 0.09,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.grey[500]!.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      // child: Center(
                      //   child: TextFormField(
                      //       decoration: InputDecoration(
                      //         border: InputBorder.none,
                      //         prefixIcon: Padding(
                      //           padding: const EdgeInsets.symmetric(
                      //               horizontal: 20.0),
                      //           child: Icon(
                      //             FontAwesomeIcons.phone,
                      //             size: 28,
                      //             color: kWhite,
                      //           ),
                      //         ),
                      //         hintText: "Enter Phone Number ",
                      //         hintStyle: kBodyText,
                      //       ),
                      //       style: kBodyText,
                      //       //validator: RequiredValidator(errorText: 'UserName Required'),
                      //       // onSaved: (value) => _phone = value!,
                      //       controller: phoneController,
                      //       textInputAction: TextInputAction.done,
                      //       keyboardType: TextInputType.phone),
                      // ),
                      child: Center(
                        child: Container(
                          child: IntlPhoneField(
                            initialCountryCode: 'PK',
                            textAlign: TextAlign.justify,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              // prefixIcon: Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 20.0),
                              //   child: Icon(
                              //     FontAwesomeIcons.phone,
                              //     size: 28,
                              //     color: kWhite,
                              //   ),
                              // ),
                              // hintText: "Enter Phone Number ",
                            ),
                            style: kBodyText,
                            controller: phoneController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.phone,
                            onChanged: (phone) {
                              _phone = phone.completeNumber;
                              print(_phone);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: size.height * 0.08,
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: kBlue,
                    ),
                    child: TextButton(
                      onPressed: () async {
                        Provider.of<Auth>(context, listen: false).phoneNumber =
                            _phone!;
                        await Provider.of<Auth>(context, listen: false)
                            .sent_otp()
                            .then((_) {
                          Navigator.of(context)
                              .pushNamed(Verificatoin.routeName);
                        });
                      },
                      child: Text(
                        'Send OTP',
                        style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    );
  }
}
