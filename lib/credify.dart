import 'package:credify/dashboard_screen.dart';
import 'package:credify/mobile_number_screen.dart';
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
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => DashboardScreen()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => MobileNumberScreen()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
