import 'package:credify/completeKYC2.dart';
import 'package:flutter/material.dart';

class CompleteKYC1 extends StatefulWidget {
  @override
  _CompleteKYC1State createState() => _CompleteKYC1State();
}

class _CompleteKYC1State extends State<CompleteKYC1> {
  var formKey = new GlobalKey<FormState>();

  String fullName;
  String dob;
  String panNumber;
  String aadhar;

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
                  style: Theme.of(context).primaryTextTheme.display2,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 30),
                child: Text(
                  " Complete KYC",
                  style: Theme.of(context).primaryTextTheme.display1,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 0, left: 30),
                child: Text(
                  "  1/3",
                  style: Theme.of(context).primaryTextTheme.display3,
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 30, right: 30, bottom: 30),
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        style: Theme.of(context).primaryTextTheme.display3,
                        decoration: InputDecoration(
                            labelText: "Your Full Name",
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder())),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 30, right: 30, bottom: 30),
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
                        style: Theme.of(context).primaryTextTheme.display3,
                        decoration: InputDecoration(
                            labelText: "Date of Birth",
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder())),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 30, right: 30, bottom: 30),
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
                        style: Theme.of(context).primaryTextTheme.display3,
                        decoration: InputDecoration(
                            labelText: "Your PAN Card",
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder())),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 30, right: 30, bottom: 30),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).primaryTextTheme.display3,
                        decoration: InputDecoration(
                            labelText: "Your Aadhar Number",
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder())),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 30.0),
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
                          padding:
                              const EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
                          child: new Text('Continue',
                              style: new TextStyle(
                                  fontSize: 18.0, color: Colors.white)),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CompleteKYC2()));
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
