import 'package:credify/Screens/dashboard_screen.dart';
import 'package:credify/Screens/user_groups_screen.dart';
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
            return UserGroupsScreen();
          }
          break;
        case 2:
          {
            return Container();
          }
          break;
        case 3:
          {
            return Container();
          }
          break;
        case 4:
          {
            return Container();
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
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            activeIcon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                "assets/images/HomeBNB.png",
                height: 20,
                width: 20,
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                "assets/images/HomeBNB.png",
                height: 20,
                width: 20,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Home",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            activeIcon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                "assets/images/GroupBNB.png",
                height: 20,
                width: 20,
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                "assets/images/GroupBNB.png",
                height: 20,
                width: 20,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                "Groups",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            activeIcon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                "assets/images/PaymentCardBNB.png",
                height: 20,
                width: 20,
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                "assets/images/PaymentCardBNB.png",
                height: 20,
                width: 20,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Credify",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            activeIcon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                "assets/images/ShareBNB.png",
                height: 20,
                width: 20,
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                "assets/images/ShareBNB.png",
                height: 20,
                width: 20,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                "Refer",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            activeIcon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                "assets/images/ContactBNB.png",
                height: 20,
                width: 20,
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                "assets/images/ContactBNB.png",
                height: 20,
                width: 20,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                "Profile",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
