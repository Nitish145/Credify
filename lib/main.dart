import 'package:credify/completeKYC1.dart';
import 'package:credify/completeKYC2.dart';
import 'package:credify/confirmed_screen.dart';
import 'package:flutter/material.dart';
import 'package:credify/mobile_number_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CREDIFY',
      theme: ThemeData(
        fontFamily: 'Raleway',
        primaryColor: Colors.white,
        cursorColor: Colors.white,
        primaryTextTheme: TextTheme(
          display1: TextStyle(color: Colors.white , fontSize: 30),
          display2: TextStyle(color: Colors.white , fontSize: 24),
          display3: TextStyle(color: Colors.white , fontSize: 18),
          body1: TextStyle(color: Colors.white),
          body2: TextStyle(color: Colors.white),
        ),
        accentTextTheme: TextTheme(
          display1: TextStyle(color: Colors.white , fontSize: 30),
          display2: TextStyle(color: Colors.white , fontSize: 24),
          display3: TextStyle(color: Colors.white , fontSize: 18),
          body1: TextStyle(color: Colors.white),
          body2: TextStyle(color: Colors.white),
        ),
      ),
      home: CompleteKYC1(),
    );
  }
}