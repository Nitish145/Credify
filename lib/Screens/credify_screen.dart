import 'package:credify/Screens/mobile_number_screen.dart';
import 'package:credify/bottom_navigation_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Credify extends StatefulWidget {
  @override
  _CredifyState createState() => _CredifyState();
}

class _CredifyState extends State<Credify> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      SharedPreferences.getInstance().then((sharedPrefs) {
        bool isLoggedIn = sharedPrefs.getBool("isLoggedIn") ?? false;
        if (isLoggedIn) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavigationBarScreen()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => MobileNumberScreen()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
    ));
  }
}
