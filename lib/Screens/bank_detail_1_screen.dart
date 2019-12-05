import 'package:credify/Screens/bank_detail_2_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BankDetailScreen1 extends StatefulWidget {
  @override
  _BankDetailScreen1State createState() => _BankDetailScreen1State();
}

class _BankDetailScreen1State extends State<BankDetailScreen1> {
  String bankName = "Choose your Bank";

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
                  " Bank Statement",
                  style: Theme.of(context).primaryTextTheme.display1,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 60, left: 30),
                child: Text(
                  " Select your bank",
                  style: Theme.of(context).primaryTextTheme.display2,
                ),
              ),
            ),
            Theme(
              data: ThemeData.dark(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 30, 40, 5),
                child: Container(
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
                        value: bankName,
                        icon: Icon(Icons.keyboard_arrow_down),
                        iconSize: 24,
                        elevation: 16,
                        style: Theme.of(context).primaryTextTheme.display3,
                        onChanged: (String newValue) {
                          setState(() {
                            bankName = newValue;
                          });
                        },
                        items: <String>[
                          'Choose your Bank',
                          'HDFC Bank',
                          'AXIS Bank',
                          'State Bank of India',
                          'ICICI bank'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style:
                                  Theme.of(context).primaryTextTheme.display3,
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
                    child: new Text('Continue',
                        style:
                            new TextStyle(fontSize: 18.0, color: Colors.white)),
                  ),
                  onPressed: () {
                    if (bankName != "Choose your Bank") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BankDetailScreen2(
                                    bankName: bankName,
                                  )));
                    } else if (bankName == "Choose your Bank") {
                      Fluttertoast.showToast(msg: "Please select a bank");
                    }
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
