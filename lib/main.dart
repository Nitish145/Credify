import 'package:credify/confirmed_screen.dart';
import 'package:credify/dashboard_screen.dart';
import 'package:credify/mobile_number_screen.dart';
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
          "/dashboard": (context) => DashboardScreen(),
          "/confirmed": (context) => ConfirmedScreen()
        },
        title: 'CREDIFY',
        theme: ThemeData(
          fontFamily: 'Raleway',
          primaryColor: Colors.white,
          cursorColor: Colors.white,
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
        ),
        home: MobileNumberScreen());
  }
}
