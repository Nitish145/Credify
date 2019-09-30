import 'package:credify/Models/otp_response_model.dart';
import 'package:credify/globals.dart';
import 'package:credify/Screens/otp_verification_screen.dart';
import 'package:credify/Services/otp_response.dart';
import 'package:credify/Components/undismissable_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';

class MobileNumberScreen extends StatefulWidget {
  @override
  _MobileNumberScreenState createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  var formKey = new GlobalKey<FormState>();
  String mobileNumber;

  String generateOtp() {
    var rnd = new math.Random();
    var next = rnd.nextDouble() * 1000000;
    while (next < 100000) {
      next *= 10;
    }
    return next.toInt().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 4, 5, 1),
      body: SingleChildScrollView(
          child: Stack(
        children: <Widget>[
          Column(
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
                            child: Image.asset(
                                "assets/images/topBackground.png"))),
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
                        maxLength: 10,
                        style: Theme.of(context).primaryTextTheme.display3,
                        decoration: InputDecoration(
                            labelText: "Mobile Number",
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder()),
                        validator: (_phoneNo) {
                          if (_phoneNo.length < 10) {
                            return "Enter a valid mobile no.";
                          }
                          return null;
                        },
                        onSaved: (String _phoneNo) => mobileNumber = _phoneNo,
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
                      padding:
                          const EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
                      child: new Text('Send OTP',
                          style: new TextStyle(
                              fontSize: 18.0, color: Colors.white)),
                    ),
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        String otp = generateOtp();
                        setState(() {
                          isLoading = true;
                        });
                        OtpResponse otpResponse =
                            await otpResponseService(mobileNumber, "otp", otp);
                        print(otp);
                        if (otpResponse.isSent) {
                          SharedPreferences sharedPrefs =
                              await SharedPreferences.getInstance();
                          setState(() {
                            isLoading = false;
                          });
                          sharedPrefs.setString(
                              "currentUserMobileNumber", mobileNumber);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OtpVerificationScreen(
                                        mobileNumber: mobileNumber,
                                        otp: otp,
                                      )));
                        }
                      }
                    },
                  ),
                ),
              )
            ],
          ),
          UndismissableProgressBar(
            message: "Sending OTP",
          )
        ],
      )),
    );
  }
}
