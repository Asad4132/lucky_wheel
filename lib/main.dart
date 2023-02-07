// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:lucky_wheel/provider/auth.dart';
import 'package:lucky_wheel/provider/user_data.dart';
import 'package:lucky_wheel/screens/home_page.dart';

import './screens/verificationOtp.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/screens.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (ctx) => Auth(),
              ),
              ChangeNotifierProvider(
                create: (ctx) => UserData(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'GameLook',
              theme: ThemeData(
                textTheme: GoogleFonts.josefinSansTextTheme(
                    Theme.of(context).textTheme),
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              //home: Verificatoin(),
              initialRoute: '/',
              routes: {
                '/': (context) => HomePage(),
                Verificatoin.routeName: (context) => Verificatoin(),
                HomePage.routeName: (context) => HomePage(),
              },
            ),
          );
        });
  }
}
