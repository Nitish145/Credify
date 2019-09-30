import 'package:credify/Screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

class ConfirmedScreen extends StatefulWidget {
  @override
  _ConfirmedScreenState createState() => _ConfirmedScreenState();
}

class _ConfirmedScreenState extends State<ConfirmedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 4, 5, 1),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 30),
                child: Text(
                  "Credify",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).primaryTextTheme.display2,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2.2,
              width: MediaQuery.of(context).size.width,
              child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Image.asset("assets/images/topBackground.png"))),
            ),
            Center(
              child: Text(
                "Confirmed!",
                style: Theme.of(context).primaryTextTheme.display1,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
                child: Text(
                  "Welcome to your financial window",
                  style: Theme.of(context).primaryTextTheme.display3,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 100.0, 30.0, 30.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  elevation: 5.0,
                  color: Color.fromRGBO(45, 156, 219, 1),
                  shape: new RoundedRectangleBorder(
                      side: BorderSide(
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                      borderRadius: new BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
                    child: new Text('Go to Dashboard',
                        style:
                            new TextStyle(fontSize: 18.0, color: Colors.white)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardScreen()));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
