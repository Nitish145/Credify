import 'package:credify/Models/is_new_user_model.dart';
import 'package:credify/dashboard_screen.dart';
import 'package:credify/globals.dart';
import 'package:credify/services/is_new_user.dart';
import 'package:credify/services/user_data.dart';
import 'package:credify/undismissable_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String mobileNumber;
  final String otp;

  const OtpVerificationScreen({Key key, this.mobileNumber, this.otp})
      : super(key: key);
  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  var formKey = new GlobalKey<FormState>();
  TextEditingController otpController = new TextEditingController();
  String otp;

  @override
  void initState() {
    super.initState();
    otpController.text = widget.otp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 4, 5, 1),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
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
                        maxLength: 6,
                        style: Theme.of(context).primaryTextTheme.display3,
                        controller: otpController,
                        decoration: InputDecoration(
                            labelText: "OTP",
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder()),
                        validator: (_otp) {
                          if (_otp.length < 6) {
                            return "Invalid OTP";
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
                      padding:
                          const EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
                      child: new Text('Verify',
                          style: new TextStyle(
                              fontSize: 18.0, color: Colors.white)),
                    ),
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        if (otp == widget.otp) {
                          currentUserMobileNumber = widget.mobileNumber;
                          setState(() {
                            isLoading = true;
                          });
                          IsNewUser isNewUserResponse =
                              await isNewUser(currentUserMobileNumber);
                          print(isNewUserResponse.id);
                          currentUserId = isNewUserResponse.id;
                          currentUserData = await getUserData(currentUserId);
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashboardScreen()));
                        } else {
                          Fluttertoast.showToast(
                            msg: "Wrong OTP entered",
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          )),
          UndismissableProgressBar(message: "Fetching Data")
        ],
      ),
    );
  }
}
