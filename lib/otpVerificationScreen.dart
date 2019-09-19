import 'package:credify/completeKYC1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpVerificationScreen extends StatefulWidget {
  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  var formKey = new GlobalKey<FormState>();
  String otp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 4, 5, 1),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2.2,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height / 3.5,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Image.asset("assets/images/topBackground.png"))),
                Positioned(
                  left: (MediaQuery.of(context).size.width - 100) / 2,
                  top: MediaQuery.of(context).size.height / 4.2,
                  child: Container(
                    height: 150,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.white, width: 3)),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 4.2 + 36,
                  left: (MediaQuery.of(context).size.width - 70) / 2,
                  child: Container(
                    height: 102,
                    width: 52,
                    child: Image.asset("assets/images/C.png"),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              "Credify",
              style: Theme.of(context).primaryTextTheme.display1,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Your window to financial freedom",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 100, left: 30, right: 30, bottom: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    maxLength: 4,
                    style: Theme.of(context).primaryTextTheme.display3,
                    decoration: InputDecoration(
                        labelText: "OTP",
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder()),
                    validator: (_otp) {
                      if (_otp.length < 4) {
                        return "Enter a valid Otp";
                      }
                      return null;
                    },
                    onSaved: (String _otp) => otp = _otp,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 30.0),
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
                  child: new Text('Verify',
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.white)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => CompleteKYC1()));
                },
              ),
            ),
          )
        ],
      )),
    );
  }
}