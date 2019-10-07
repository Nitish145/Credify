import 'package:credify/Screens/bank_1_screen.dart';
import 'package:credify/Screens/bank_2_screen.dart';
import 'package:credify/Screens/confirmed_screen.dart';
import 'package:credify/Screens/credify_screen.dart';
import 'package:credify/Screens/dashboard_screen.dart';
import 'package:credify/Screens/mobile_number_screen.dart';
import 'package:credify/Screens/upload_aadhar_screen.dart';
import 'package:credify/Screens/upload_pan_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/confirmed": (context) => ConfirmedScreen(),
          "/aadharScreen": (context) => UploadAadhar(),
          "/panScreen": (context) => UploadPan(),
          "/bankScreen1": (context) => BankScreen(),
          "/bankScreen2": (context) => BankScreen2(),
          "/dashboard": (context) => DashboardScreen(),
          "/mobileNumber": (context) => MobileNumberScreen()
        },
        title: 'CREDIFY',
        theme: ThemeData(
            fontFamily: 'Raleway',
            primaryColor: Colors.white,
            cursorColor: Colors.white,
            accentColor: Colors.grey,
            primaryTextTheme: TextTheme(
              display1: TextStyle(color: Colors.white, fontSize: 32),
              display2: TextStyle(color: Colors.white, fontSize: 26),
              display3: TextStyle(color: Colors.white, fontSize: 20),
              display4: TextStyle(color: Colors.white, fontSize: 16),
              body1: TextStyle(color: Colors.white),
              body2: TextStyle(color: Colors.white),
            ),
            accentTextTheme: TextTheme(
              display1: TextStyle(color: Colors.black, fontSize: 32),
              display2: TextStyle(color: Colors.black, fontSize: 26),
              display3: TextStyle(color: Colors.black, fontSize: 20),
              display4: TextStyle(color: Colors.black, fontSize: 16),
              body1: TextStyle(color: Colors.white),
              body2: TextStyle(color: Colors.white),
            ),
            hintColor: Colors.white),
        home: Credify());
  }
}
