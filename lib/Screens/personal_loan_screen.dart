import 'package:credify/Components/undismissable_progress_bar.dart';
import 'package:credify/Screens/personal_loan_agreement_screen.dart';
import 'package:credify/Services/submit_loan_request.dart';
import 'package:credify/colors.dart';
import 'package:credify/globals.dart';
import 'package:credify/utils/get_month_string_by_month_int.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalLoanScreen extends StatefulWidget {
  @override
  _PersonalLoanScreenState createState() => _PersonalLoanScreenState();
}

class _PersonalLoanScreenState extends State<PersonalLoanScreen> {
  bool areTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    Widget getRowForColumnScreen(String title, int amount, {String subtitle}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).accentTextTheme.display4,
                ),
                subtitle != null
                    ? Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      )
                    : Container()
              ],
            ),
            Text(
              '\u20B9 ' + amount.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
          ],
        ),
      );
    }

    Widget getDuDateRow(String title, DateTime dueDate) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 32,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
            ),
            Text(
              dueDate.day.toString() +
                  " " +
                  monthIntToMonthString(dueDate.month).substring(0, 3),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
          ],
        ),
      );
    }

    Widget getCheckboxRow() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: Row(
          children: <Widget>[
            Checkbox(
              value: areTermsAccepted,
              activeColor: credifyBlue,
              onChanged: (bool value) {
                setState(() {
                  areTermsAccepted = value;
                });
              },
            ),
            RichText(
              text: new TextSpan(children: [
                new TextSpan(
                    text: 'I have read and accept all the ',
                    style: TextStyle(
                      color: credifyBlack,
                      fontSize: 12,
                    )),
                new TextSpan(
                    text: 'terms and conditions',
                    style: TextStyle(
                      color: credifyBlue,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PersonalLoanAgreementScreen()));
                      })
              ]),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Congratulations!",
                          style: Theme.of(context).accentTextTheme.display1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Your loan has been approved",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "\u20B9 5000/-",
                          style: TextStyle(
                              color: credifyBlue,
                              fontSize: 36,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: <Widget>[
                    getRowForColumnScreen("Processing Fee", 200,
                        subtitle: "Deducted from the loans"),
                    getRowForColumnScreen("One time activation fee", 200,
                        subtitle: "One time charges"),
                    getRowForColumnScreen("GST (18% on all fee)", 72),
                    getDuDateRow("Due Date", DateTime.now()),
                    getRowForColumnScreen("Interest", 0),
                    getRowForColumnScreen("Disbursal Amount", 4628),
                    getRowForColumnScreen("Repayment Amount", 5000),
                    getCheckboxRow(),
                  ],
                ),
              ],
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
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: areTermsAccepted ? credifyBlue : credifyDarkGrey,
              child: FlatButton(
                child: Text(
                  "Confirm and Continue",
                  style: areTermsAccepted
                      ? Theme.of(context).primaryTextTheme.display3
                      : Theme.of(context).accentTextTheme.display3,
                ),
                onPressed: () {
                  if (areTermsAccepted) {
                    setState(() {
                      isLoading = true;
                    });
                    SharedPreferences.getInstance().then((sharedPrefs) {
                      makeLoanRequest(
                              sharedPrefs.getString("currentUserId"), 5000)
                          .then((loanRequestResponse) {
                        if (loanRequestResponse.updated) {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                          isPersonalLoanAvailed = true;
                          Fluttertoast.showToast(msg: "Request accepted !!");
                        } else {
                          Fluttertoast.showToast(
                              msg: "Unable to make request! Try Again Later");
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }).catchError((e) {
                        Fluttertoast.showToast(
                            msg: "Unable to make request! Try Again Later");
                        setState(() {
                          isLoading = false;
                        });
                      });
                    });
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please acknowledge Terms & Conditions");
                  }
                },
              ),
            ),
          ),
          UndismissableProgressBar(
            message: "Making Loan Request",
          )
        ],
      ),
    );
  }
}
