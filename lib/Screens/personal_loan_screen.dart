import 'package:credify/Screens/personal_loan_agreement_screen.dart';
import 'package:flutter/material.dart';

class PersonalLoanScreen extends StatefulWidget {
  @override
  _PersonalLoanScreenState createState() => _PersonalLoanScreenState();
}

class _PersonalLoanScreenState extends State<PersonalLoanScreen> {
  var formKey = new GlobalKey<FormState>();
  double sliderValue = 1000;

  @override
  Widget build(BuildContext context) {
    String getPaybackTime() {
      if (sliderValue >= 1000 && sliderValue <= 2000) {
        return "1 week";
      } else if (sliderValue > 2000 && sliderValue <= 5000) {
        return "2 week";
      } else {
        return "4 week";
      }
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 30, right: 30, bottom: 30),
                      child: Column(
                        children: <Widget>[
                          Align(
                            child: Padding(
                              padding: const EdgeInsets.only(),
                              child: Text(
                                "How much money do you want?",
                                style:
                                    Theme.of(context).accentTextTheme.display4,
                              ),
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: TextFormField(
                                keyboardType: TextInputType.number,
                                maxLength: 5,
                                style:
                                    Theme.of(context).accentTextTheme.display3,
                                onSaved: (_amount) {},
                                onChanged: (_amount) {
                                  if (int.parse(_amount) % 1000 == 0) {
                                    setState(() {
                                      sliderValue = double.parse(_amount);
                                    });
                                  }
                                },
                                validator: (_amount) {
                                  if (int.parse(_amount) % 1000 == 0) {
                                    return "Enter in multiples of 1000";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Amount",
                                  labelStyle: TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                )),
                          ),
                          Align(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Text(
                                "Payback Time Period",
                                style:
                                    Theme.of(context).accentTextTheme.display4,
                              ),
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    getPaybackTime(),
                                    style: Theme.of(context)
                                        .accentTextTheme
                                        .display3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Apply for Personal Loan",
                              style:
                                  Theme.of(context).primaryTextTheme.display2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(47, 128, 237, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30, left: 15),
                        child: Text(
                          "How much money do you want?",
                          style: Theme.of(context).primaryTextTheme.display4,
                        ),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    Column(
                      children: <Widget>[
                        Slider(
                          activeColor: Color.fromRGBO(242, 153, 74, 1),
                          inactiveColor: Colors.white,
                          min: 1000,
                          max: 10000,
                          divisions: 9,
                          value: sliderValue,
                          onChanged: (newSliderValue) {
                            setState(() {
                              sliderValue = newSliderValue;
                            });
                          },
                          label: sliderValue != 10000
                              ? '$sliderValue'.substring(0, 1) + 'K'
                              : '$sliderValue'.substring(0, 2) + 'K',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "1,000",
                                style:
                                    Theme.of(context).primaryTextTheme.display4,
                              ),
                              Text(
                                "5,000",
                                style:
                                    Theme.of(context).primaryTextTheme.display4,
                              ),
                              Text(
                                "10,000",
                                style:
                                    Theme.of(context).primaryTextTheme.display4,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: RaisedButton(
                          elevation: 5.0,
                          color: Color.fromRGBO(242, 153, 74, 1),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5)),
                          child: Text('Next',
                              style: new TextStyle(
                                  fontSize: 18.0, color: Colors.white)),
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PersonalLoanAgreementScreen()));
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
