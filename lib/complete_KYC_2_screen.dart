import 'package:credify/Models/add_kyc_data_model.dart';
import 'package:credify/Models/pin_info_model.dart';
import 'package:credify/complete_KYC_3_screen.dart';
import 'package:credify/globals.dart';
import 'package:credify/services/add_kyc_data.dart';
import 'package:credify/undismissable_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:credify/services/pin_info.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

class CompleteKYC2 extends StatefulWidget {
  @override
  _CompleteKYC2State createState() => _CompleteKYC2State();
}

class _CompleteKYC2State extends State<CompleteKYC2> {
  var formKey = new GlobalKey<FormState>();

  TextEditingController pincodeController = new TextEditingController();
  TextEditingController houseNumberController = new TextEditingController();
  TextEditingController localityController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();

  int pincode;
  String houseNumber;
  String locality;
  String city;

  bool isPinInfoLoading = false;

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
                            maxLength: 6,
                            style: Theme.of(context).primaryTextTheme.display3,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            validator: (_pincode) {
                              if (_pincode.length < 6) {
                                return "Enter a valid PINCODE";
                              }
                              return null;
                            },
                            onSaved: (_pincode) {
                              pincode = int.parse(_pincode);
                            },
                            onChanged: (text) async {
                              if (text.length == 6) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                setState(() {
                                  isLoading = true;
                                  isPinInfoLoading = true;
                                });
                                PinInfo pinInfo = await pinInfoService(text);
                                setState(() {
                                  isLoading = false;
                                  isPinInfoLoading = false;
                                });
                                cityController.text =
                                    pinInfo.postOffice[0].block +
                                        "/" +
                                        pinInfo.postOffice[0].district;
                                localityController.text =
                                    pinInfo.postOffice[0].name;
                              }
                            },
                            decoration: InputDecoration(
                                labelText: "Pincode",
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder())),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0, left: 30, right: 30, bottom: 30),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: Theme.of(context).primaryTextTheme.display3,
                            controller: houseNumberController,
                            validator: (_houseNo) {
                              if (_houseNo.isEmpty) {
                                return "Enter a house Number";
                              }
                              return null;
                            },
                            onSaved: (_houseNumber) {
                              houseNumber = _houseNumber;
                            },
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
                            controller: localityController,
                            validator: (_locality) {
                              if (_locality.isEmpty) {
                                return "Enter a locality";
                              }
                              return null;
                            },
                            onSaved: (_locality) {
                              locality = _locality;
                            },
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
                            controller: cityController,
                            validator: (_city) {
                              if (_city.isEmpty) {
                                return "Enter a City";
                              }
                              return null;
                            },
                            onSaved: (_city) {
                              city = _city;
                            },
                            decoration: InputDecoration(
                                labelText: "City / District",
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
                                setState(() {
                                  isLoading = true;
                                });
                                AddKycDataResponse addKycResponse =
                                    await addKycData(
                                  currentUserId,
                                  2,
                                  pincode: pincode,
                                  houseNumber: houseNumber,
                                  locality: locality,
                                  city: city,
                                );
                                setState(() {
                                  isLoading = false;
                                });
                                if (addKycResponse.updated) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CompleteKYC3()));
                                } else {
                                  Toast.show("Something Wrong Occured", context,
                                      duration: Toast.LENGTH_SHORT,
                                      gravity: Toast.BOTTOM,
                                      backgroundColor: Colors.blueGrey);
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
            isPinInfoLoading
                ? UndismissableProgressBar(
                    message: "Fetching Location",
                  )
                : UndismissableProgressBar(
                    message: "Saving",
                  )
          ],
        ),
      ),
    );
  }
}
