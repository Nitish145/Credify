import 'package:flutter/material.dart';
import 'package:masked_text_input_formatter/masked_text_input_formatter.dart';

class CompleteKYC3 extends StatefulWidget {
  @override
  _CompleteKYC3State createState() => _CompleteKYC3State();
}

class _CompleteKYC3State extends State<CompleteKYC3> {
  var formKey = new GlobalKey<FormState>();
  int _radioValueSalary = -1;

  int _radioValueNotEarning = -1;

  bool _isBikeChecked = false;
  bool _isMobileChecked = false;
  bool _isOthersChecked = false;

  String occupation = "Choose your occupation";
  int monthlyIncome;
  String livesWith;

  String selfEmployedWorkTime = "Choose Time Duration";

  void handleRadioValueChange(int value) {
    setState(() {
      _radioValueSalary = value;
    });
  }

  void handleRadioValueChange2(int value) {
    setState(() {
      _radioValueNotEarning = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget occupationSubOptions() {
      switch (occupation) {
        case "Salaried":
          {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 50, right: 50, bottom: 10),
                  child: Container(
                    height: 40,
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.white,
                        style: Theme.of(context).primaryTextTheme.display4,
                        decoration: InputDecoration(
                          hintText: "Company Name",
                          hintStyle: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 50, right: 50, bottom: 10),
                  child: Container(
                    height: 40,
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.white,
                        style: Theme.of(context).primaryTextTheme.display4,
                        decoration: InputDecoration(
                          hintText: "When did you join the company",
                          hintStyle: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 50, right: 50, bottom: 10),
                  child: Container(
                    height: 40,
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.white,
                        style: Theme.of(context).primaryTextTheme.display4,
                        decoration: InputDecoration(
                          hintText: "How much do you earn monthly?",
                          hintStyle: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 50, right: 50, bottom: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "How do you get your Salary?",
                      style: Theme.of(context).primaryTextTheme.display4,
                    ),
                  ),
                ),
                Theme(
                  data: ThemeData.dark(),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 50, right: 50, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            new Radio(
                              activeColor: Colors.white,
                              value: 0,
                              groupValue: _radioValueSalary,
                              onChanged: handleRadioValueChange,
                            ),
                            new Text(
                              'Bank Transfer',
                              style:
                                  Theme.of(context).primaryTextTheme.display4,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            new Radio(
                              activeColor: Colors.white,
                              value: 1,
                              groupValue: _radioValueSalary,
                              onChanged: handleRadioValueChange,
                            ),
                            new Text(
                              'Cash',
                              style:
                                  Theme.of(context).primaryTextTheme.display4,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            new Radio(
                              activeColor: Colors.white,
                              value: 2,
                              groupValue: _radioValueSalary,
                              onChanged: handleRadioValueChange,
                            ),
                            new Text(
                              'Cheque',
                              style:
                                  Theme.of(context).primaryTextTheme.display4,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 50, right: 50, bottom: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Existing EMI's/Loans",
                      style: Theme.of(context).primaryTextTheme.display4,
                    ),
                  ),
                ),
                Theme(
                  data: ThemeData.dark(),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 50, right: 50, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            new Checkbox(
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                              value: _isBikeChecked,
                              onChanged: (bool value) {
                                setState(() {
                                  _isBikeChecked = value;
                                });
                              },
                            ),
                            new Text(
                              'Bike',
                              style:
                                  Theme.of(context).primaryTextTheme.display4,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            new Checkbox(
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                              value: _isMobileChecked,
                              onChanged: (bool value) {
                                setState(() {
                                  _isMobileChecked = value;
                                });
                              },
                            ),
                            new Text(
                              'Mobile',
                              style:
                                  Theme.of(context).primaryTextTheme.display4,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            new Checkbox(
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                              value: _isOthersChecked,
                              onChanged: (bool value) {
                                setState(() {
                                  _isOthersChecked = value;
                                });
                              },
                            ),
                            new Text(
                              'Others',
                              style:
                                  Theme.of(context).primaryTextTheme.display4,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                _isOthersChecked
                    ? Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 50, right: 50, bottom: 10),
                        child: Container(
                          height: 40,
                          child: TextFormField(
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.white,
                              style:
                                  Theme.of(context).primaryTextTheme.display4,
                              decoration: InputDecoration(
                                hintText: "Mention other EMI/Loans",
                                hintStyle: TextStyle(color: Colors.white),
                              )),
                        ),
                      )
                    : Container(),
              ],
            );
          }
          break;
        case "Self Employed":
          {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 50, right: 50, bottom: 10),
                  child: Container(
                    height: 40,
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.white,
                        style: Theme.of(context).primaryTextTheme.display4,
                        decoration: InputDecoration(
                          hintText: "What do you do for a living?",
                          hintStyle: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 15),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Theme(
                        data: ThemeData.dark(),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selfEmployedWorkTime,
                            icon: Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            elevation: 16,
                            style: Theme.of(context).primaryTextTheme.display4,
                            onChanged: (String newValue) {
                              setState(() {
                                selfEmployedWorkTime = newValue;
                              });
                            },
                            items: <String>[
                              'Choose Time Duration',
                              '<6 months',
                              '6 - 12 months',
                              '1 - 2 years',
                              '2 - 3 years'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .display4,
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
                  padding: const EdgeInsets.only(
                      top: 10, left: 50, right: 50, bottom: 10),
                  child: Container(
                    height: 40,
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.white,
                        style: Theme.of(context).primaryTextTheme.display4,
                        decoration: InputDecoration(
                          hintText: "How much do you earn monthly (in hand)?",
                          hintStyle: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 50, right: 50, bottom: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Existing EMI's/Loans",
                      style: Theme.of(context).primaryTextTheme.display4,
                    ),
                  ),
                ),
                Theme(
                  data: ThemeData.dark(),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 50, right: 50, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            new Checkbox(
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                              value: _isBikeChecked,
                              onChanged: (bool value) {
                                setState(() {
                                  _isBikeChecked = value;
                                });
                              },
                            ),
                            new Text(
                              'Bike',
                              style:
                                  Theme.of(context).primaryTextTheme.display4,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            new Checkbox(
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                              value: _isMobileChecked,
                              onChanged: (bool value) {
                                setState(() {
                                  _isMobileChecked = value;
                                });
                              },
                            ),
                            new Text(
                              'Mobile',
                              style:
                                  Theme.of(context).primaryTextTheme.display4,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            new Checkbox(
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                              value: _isOthersChecked,
                              onChanged: (bool value) {
                                setState(() {
                                  _isOthersChecked = value;
                                });
                              },
                            ),
                            new Text(
                              'Others',
                              style:
                                  Theme.of(context).primaryTextTheme.display4,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                _isOthersChecked
                    ? Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 50, right: 50, bottom: 10),
                        child: Container(
                          height: 40,
                          child: TextFormField(
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.white,
                              style:
                                  Theme.of(context).primaryTextTheme.display4,
                              decoration: InputDecoration(
                                hintText: "Mention other EMI/Loans",
                                hintStyle: TextStyle(color: Colors.white),
                              )),
                        ),
                      )
                    : Container(),
              ],
            );
          }
          break;
        case "Not Earning":
          {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 50, right: 50, bottom: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "What do you do?",
                      style: Theme.of(context).primaryTextTheme.display4,
                    ),
                  ),
                ),
                Theme(
                  data: ThemeData.dark(),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 50, right: 50, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            new Radio(
                              activeColor: Colors.white,
                              value: 0,
                              groupValue: _radioValueNotEarning,
                              onChanged: handleRadioValueChange2,
                            ),
                            new Text(
                              'Student',
                              style:
                                  Theme.of(context).primaryTextTheme.display4,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            new Radio(
                              activeColor: Colors.white,
                              value: 1,
                              groupValue: _radioValueNotEarning,
                              onChanged: handleRadioValueChange2,
                            ),
                            new Text(
                              'Looking for a Job',
                              style:
                                  Theme.of(context).primaryTextTheme.display4,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                _radioValueNotEarning == 1
                    ? Padding(
                        padding: const EdgeInsets.only(
                            top: 0, left: 80, right: 40, bottom: 20),
                        child: Container(
                          height: 40,
                          child: TextFormField(
                              keyboardType: TextInputType.datetime,
                              inputFormatters: [
                                MaskedTextInputFormatter(
                                    mask: "--/--/----", separator: "/")
                              ],
                              cursorColor: Colors.white,
                              style:
                                  Theme.of(context).primaryTextTheme.display4,
                              decoration: InputDecoration(
                                hintText: "Since when you are unemployed?",
                                hintStyle: TextStyle(color: Colors.white),
                              )),
                        ),
                      )
                    : Container(),
              ],
            );
          }
          break;
        default:
          {
            return Container();
          }
      }
    }

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
                  "  3/3",
                  style: Theme.of(context).primaryTextTheme.display3,
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Theme(
                          data: ThemeData.dark(),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: occupation,
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 24,
                              elevation: 16,
                              style:
                                  Theme.of(context).primaryTextTheme.display3,
                              onChanged: (String newValue) {
                                setState(() {
                                  occupation = newValue;
                                });
                              },
                              items: <String>[
                                'Choose your occupation',
                                'Salaried',
                                'Self Employed',
                                'Not Earning'
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
                  occupationSubOptions(),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 30, right: 30, bottom: 30),
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        style: Theme.of(context).primaryTextTheme.display3,
                        decoration: InputDecoration(
                            labelText: "You live with",
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
                          Navigator.pushNamedAndRemoveUntil(context,
                              '/aadharScreen', (Route<dynamic> route) => false);
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
