import 'package:credify/Screens/dashboard_screen.dart';
import 'package:credify/Screens/profile_screen.dart';
import 'package:credify/Screens/referral_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  @override
  _BottomNavigationBarScreenState createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget getDynamicBody() {
      switch (_currentIndex) {
        case 0:
          {
            return DashboardScreen();
          }
          break;
        case 1:
          {
            return ProfileScreen();
          }
          break;
        case 2:
          {
            return ReferralScreen();
          }
          break;
      }
      return Container();
    }

    return Scaffold(
      body: getDynamicBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            activeIcon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                "assets/images/HomeBNB.png",
                height: 25,
                width: 25,
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: Image.asset(
                "assets/images/HomeBNB.png",
                height: 25,
                width: 25,
              ),
            ),
            title: Text(
              "Home",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            activeIcon: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: Image.asset(
                "assets/images/ContactBNB.png",
                height: 25,
                width: 25,
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: Image.asset(
                "assets/images/ContactBNB.png",
                height: 25,
                width: 25,
              ),
            ),
            title: Text(
              "Profile",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            activeIcon: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: Image.asset(
                "assets/images/ShareBNB.png",
                height: 25,
                width: 25,
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: Image.asset(
                "assets/images/ShareBNB.png",
                height: 25,
                width: 25,
              ),
            ),
            title: Text(
              "Refer",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
