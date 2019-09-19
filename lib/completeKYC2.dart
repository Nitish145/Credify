import 'package:credify/completeKYC3.dart';
import 'package:flutter/material.dart';

class CompleteKYC2 extends StatefulWidget {
  @override
  _CompleteKYC2State createState() => _CompleteKYC2State();
}

class _CompleteKYC2State extends State<CompleteKYC2> {
  var formKey = new GlobalKey<FormState>();

  String pincode;
  String houseNumber;
  String locality;
  String city;

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
                  "  2/3",
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
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).primaryTextTheme.display3,
                        decoration: InputDecoration(
                            labelText: "Pincode",
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder())),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 30, right: 30, bottom: 30),
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        style: Theme.of(context).primaryTextTheme.display3,
                        decoration: InputDecoration(
                            labelText: "House Number , Street Number",
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder())),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 30, right: 30, bottom: 30),
                    child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        style: Theme.of(context).primaryTextTheme.display3,
                        decoration: InputDecoration(
                            labelText: "Locality",
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder())),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 30, right: 30, bottom: 30),
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        style: Theme.of(context).primaryTextTheme.display3,
                        decoration: InputDecoration(
                            labelText: "City / District",
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
                                  builder: (context) => CompleteKYC3()));
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
