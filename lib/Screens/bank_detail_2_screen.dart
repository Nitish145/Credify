import 'package:flutter/material.dart';

class BankDetailScreen2 extends StatefulWidget {
  @override
  _BankDetailScreen2State createState() => _BankDetailScreen2State();
}

class _BankDetailScreen2State extends State<BankDetailScreen2> {
  var formKey = new GlobalKey<FormState>();

  String bankAccountNumber;
  String ifscCode;
  String accountHolderName;
  String accountType = "Account Type";

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
                  " Bank Account Details",
                  style: Theme.of(context).primaryTextTheme.display1,
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
                        onSaved: (_accountNumber) {
                          bankAccountNumber = _accountNumber;
                        },
                        validator: (_accountNumber) {
                          if (_accountNumber.isEmpty) {
                            return "Enter a Account Number";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Account Number",
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
                        onSaved: (_ifsc) {
                          ifscCode = _ifsc;
                        },
                        validator: (_ifsc) {
                          bool isIfscValid = RegExp("[A-Za-z]{4}[a-zA-Z0-9]{7}")
                              .hasMatch(_ifsc);
                          if (isIfscValid) {
                            return "Inavlid IFSC Code";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "IFSC Code",
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
                      onSaved: (_accountHolderName) {
                        accountHolderName = _accountHolderName;
                      },
                      decoration: InputDecoration(
                          labelText: "Account Holder Name",
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder()),
                      validator: (_accountHolderName) {
                        if (_accountHolderName.isEmpty) {
                          return "Please Enter a name";
                        }
                        return null;
                      },
                    ),
                  ),
                  Theme(
                    data: ThemeData.dark(),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: accountType,
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 24,
                              elevation: 16,
                              style:
                                  Theme.of(context).primaryTextTheme.display3,
                              onChanged: (String newValue) {
                                setState(() {
                                  accountType = newValue;
                                });
                              },
                              items: <String>[
                                'Account Type',
                                'Savings',
                                'Current',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .display3,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                        onPressed: () async {},
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
