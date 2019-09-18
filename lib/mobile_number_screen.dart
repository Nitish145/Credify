import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MobileNumberScreen extends StatefulWidget {
  @override
  _MobileNumberScreenState createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  @override
  Widget build(BuildContext context) {
    var formKey = new GlobalKey<FormState>();
    TextEditingController _phoneEditingController = TextEditingController();

    String phoneNo;

    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 4, 5, 1),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Image.asset("assets/images/topBackground.png"))),
                Positioned(
                  left: (MediaQuery.of(context).size.width - 100) / 2,
                  top: 220,
                  child: Container(
                    height: 150,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.white, width: 3)),
                  ),
                ),
                Positioned(
                  top: 256,
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
              style: TextStyle(color: Colors.white, fontSize: 30),
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
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    controller: _phoneEditingController,
                    textAlign: TextAlign.center,
                    decoration: new InputDecoration(
                      labelText: "Mobile Number",
                    ),
                    validator: (_phoneNo) {
                      if (_phoneNo.length < 10) {
                        return "Enter a valid mobile no.";
                      }
                      return null;
                    },
                    onSaved: (String _phoneNo) => phoneNo = _phoneNo,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0 , 30.0 , 50.0 , 30.0),
            child: RaisedButton(
              elevation: 5.0,
              color: Color.fromRGBO(45, 156, 219, 1),
              shape: new RoundedRectangleBorder(
                  side: BorderSide(
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                  borderRadius: new BorderRadius.circular(0)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: new Text('Send OTP',
                    style: new TextStyle(fontSize: 15.0, color: Colors.white)),
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
