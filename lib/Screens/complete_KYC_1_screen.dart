import 'package:credify/Components/undismissable_progress_bar.dart';
import 'package:credify/Models/add_kyc_data_model.dart';
import 'package:credify/Screens/complete_KYC_2_screen.dart';
import 'package:credify/Services/add_kyc_data.dart';
import 'package:credify/Services/pan_verification.dart';
import 'package:credify/globals.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:masked_text_input_formatter/masked_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  String nameFetched;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 4, 5, 1),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
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
                            top: 30, left: 30, right: 30, bottom: 0),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.characters,
                            style: Theme.of(context).primaryTextTheme.display3,
                            onSaved: (_fullName) {
                              fullName = _fullName;
                            },
                            validator: (_fullName) {
                              if (_fullName.isEmpty) {
                                return "Enter a Name";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: "Your Full Name",
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder())),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30, bottom: 30),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "*Enter same name as in PAN",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 30, right: 30, bottom: 30),
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              MaskedTextInputFormatter(
                                  mask: "--/--/----", separator: "/")
                            ],
                            style: Theme.of(context).primaryTextTheme.display3,
                            onSaved: (_dob) {
                              dob = _dob;
                            },
                            validator: (_dob) {
                              if (_dob.length < 10) {
                                return "Inavlid DOB";
                              }
                              return null;
                            },
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
                          maxLength: 10,
                          onSaved: (_panNumber) {
                            panNumber = _panNumber;
                          },
                          onChanged: (_panNumber) {
                            if (_panNumber.length == 10) {
                              verifyPan(_panNumber).then((panDetails) {
                                nameFetched = panDetails.data.fullName;
                              }).catchError((e) {
                                Fluttertoast.showToast(
                                    msg: "Unable to fetch PAN details");
                              });
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "Your PAN Card",
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder()),
                          validator: (pan) {
                            bool isPanValid =
                                RegExp("[A-Z]{3}[ABCFGHLJPT][A-Z][0-9]{4}[A-Z]")
                                    .hasMatch(pan);
                            if (!isPanValid) {
                              return "Please Enter a valid PAN number";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 30, right: 30, bottom: 30),
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              MaskedTextInputFormatter(
                                  mask: "---- ---- ----", separator: " ")
                            ],
                            style: Theme.of(context).primaryTextTheme.display3,
                            onSaved: (_aadhar) {
                              aadhar = _aadhar;
                            },
                            validator: (_aadhar) {
                              if (_aadhar.length < 14) {
                                return "Invalid Aadhar";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: "Your Aadhar Number",
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder())),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 30.0),
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
                              padding: const EdgeInsets.fromLTRB(
                                  60.0, 20.0, 60.0, 20.0),
                              child: new Text('Continue',
                                  style: new TextStyle(
                                      fontSize: 18.0, color: Colors.white)),
                            ),
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                if (fullName != nameFetched) {
                                  Fluttertoast.showToast(
                                      msg: "Unable to verify PAN details");
                                } else {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  SharedPreferences sharedPrefs =
                                      await SharedPreferences.getInstance();
                                  sharedPrefs.setString(
                                      "currentUserName", fullName);
                                  AddKycDataResponse addKycResponse =
                                      await addKycData(
                                          sharedPrefs
                                              .getString("currentUserId"),
                                          1,
                                          name: fullName,
                                          dob: dob,
                                          aadhar: aadhar,
                                          pan: panNumber);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (addKycResponse == null) {
                                    Fluttertoast.showToast(
                                      msg: "Something Wrong Occured",
                                      toastLength: Toast.LENGTH_SHORT,
                                    );
                                  } else {
                                    if (addKycResponse.updated) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CompleteKYC2()));
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Something Wrong Occured",
                                        toastLength: Toast.LENGTH_SHORT,
                                      );
                                    }
                                  }
                                }
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            UndismissableProgressBar(
              message: "Saving",
            )
          ],
        ),
      ),
    );
  }
}
