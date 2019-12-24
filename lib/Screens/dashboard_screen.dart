import 'dart:convert';

import 'package:credify/Components/credify_card.dart';
import 'package:credify/Components/dashboard_card.dart';
import 'package:credify/Components/due_date_vs_amount_table.dart';
import 'package:credify/Models/user_data_model.dart';
import 'package:credify/Screens/bank_detail_1_screen.dart';
import 'package:credify/Screens/complete_KYC_1_screen.dart';
import 'package:credify/Screens/complete_KYC_2_screen.dart';
import 'package:credify/Screens/complete_KYC_3_screen.dart';
import 'package:credify/Screens/personal_loan_screen.dart';
import 'package:credify/Screens/profile_screenshot_screen.dart';
import 'package:credify/Services/loan_details.dart';
import 'package:credify/Services/user_data.dart';
import 'package:credify/colors.dart';
import 'package:credify/globals.dart';
import 'package:credify/helper_methods/log_event.dart';
import 'package:credify/utils/iso_string_to_dashboard_date.dart';
import 'package:credify/utils/parse_date_time_string.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  UserData currentUserData;
  bool isKycDone;
  bool isBankAccountAdded;
  bool isJobProfileUpdated;
  bool isPersonalLoanAvailed;

  bool isLoanAvailable = false;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((sharedPrefs) {
      getUserData(sharedPrefs.getString("currentUserId")).then((userData) {
        sharedPrefs.setString("currentUserData", jsonEncode(currentUserData));
        sharedPrefs.setString("referralCode", userData.referralCode);
        sharedPrefs.setString("referredBy", userData.referredBy);
        sharedPrefs.setInt("referrBonus", userData.referrBonus);
        sharedPrefs.setBool("loanTaken", userData.loanTaken);
        sharedPrefs.setBool("isProfileUpdated", userData.isProfileUpdated);
        setState(() {
          currentUserData = userData;
          isKycDone = userData.kycProgress == 3;
          isBankAccountAdded = userData.bankDetailsProvided != null
              ? userData.bankDetailsProvided
              : false;
          isJobProfileUpdated = userData.isProfileUpdated;
          isPersonalLoanAvailed = userData.loanTaken;

          isLoanAvailable =
              isKycDone && isBankAccountAdded && isJobProfileUpdated;
        });
        if (userData.loanTaken) {
          getLoanDetails(sharedPrefs.getString("currentUserId"))
              .then((loanResponse) {
            DateTime startDateTime = getDateTimeObject(loanResponse.startDate);
            setState(() {
              relationMap = {
                isoStringToDashboardDate(startDateTime
                    .add(Duration(days: 07))
                    .toIso8601String()): loanResponse.week1,
                isoStringToDashboardDate(startDateTime
                    .add(Duration(days: 14))
                    .toIso8601String()): loanResponse.week2,
                isoStringToDashboardDate(startDateTime
                    .add(Duration(days: 21))
                    .toIso8601String()): loanResponse.week3,
                isoStringToDashboardDate(startDateTime
                    .add(Duration(days: 28))
                    .toIso8601String()): loanResponse.week4,
              };
            });
          }).catchError((e) {
            Fluttertoast.showToast(msg: "Cannot fetch Loan Details");
          });
        }
      }).catchError((e) {
        Fluttertoast.showToast(msg: "Cannot fetch User Data");
      });
    });
  }

  Widget getTodoItem(bool controller, String title, VoidCallback onTodoTap,
      {bool isItemLocked = false}) {
    return GestureDetector(
      onTap: !isItemLocked ? onTodoTap : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: controller ? credifyLightGreen : credifyLightGrey,
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor:
                          controller ? credifyDarkGreen : credifyDarkGrey,
                      radius: 18,
                      child: Center(
                        child: isItemLocked
                            ? IconButton(
                                icon: Icon(
                                  Icons.lock_outline,
                                  size: 18,
                                ),
                                onPressed: null)
                            : Container(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: controller
                          ? Theme.of(context)
                              .primaryTextTheme
                              .display4
                              .copyWith(decoration: TextDecoration.lineThrough)
                          : Theme.of(context).accentTextTheme.display4,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: controller ? credifyWhite : credifyBlack,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onTodo1Tapped() {
    if (currentUserData != null) {
      if (!currentUserData.kycStatus) {
        logEvent("Know your Customer Tapped", eventParameters: {
          "user_data": currentUserData.toJson().toString()
        });
        switch (currentUserData.kycProgress) {
          case 0:
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CompleteKYC1()));
            }
            break;
          case 1:
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CompleteKYC2()));
            }
            break;
          case 2:
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CompleteKYC3()));
            }
        }
      }
    }
  }

  void onTodo2Tapped() {
    if (!isBankAccountAdded) {
      logEvent("Add Bank Account Tapped",
          eventParameters: {"user_data": currentUserData.toJson().toString()});
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BankDetailScreen1()));
    }
  }

  void onTodo3Tapped() {
    if (!isJobProfileUpdated) {
      logEvent("Add your Job Profile Tapped",
          eventParameters: {"user_data": currentUserData.toJson().toString()});
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ProfileScreenshotScreen()));
    }
  }

  void onTodo4Tapped() {
    if (!isPersonalLoanAvailed && isLoanAvailable) {
      logEvent("Apply for Personal Loan Tapped",
          eventParameters: {"user_data": currentUserData.toJson().toString()});
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PersonalLoanScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black,
                      ),
                      height: MediaQuery.of(context).size.height / 8,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 70, bottom: 20),
                      child: CredifyCard(),
                    ),
                    isPersonalLoanAvailed == false
                        ? Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text(
                                    "To-do",
                                    style: Theme.of(context)
                                        .accentTextTheme
                                        .display3,
                                  ),
                                ),
                              ),
                              getTodoItem(isKycDone, "Know your Customer",
                                  onTodo1Tapped),
                              getTodoItem(isBankAccountAdded,
                                  "Add Bank Account", onTodo2Tapped),
                              getTodoItem(isJobProfileUpdated,
                                  "Add your Job Profile", onTodo3Tapped),
                              getTodoItem(isPersonalLoanAvailed,
                                  "Apply for Personal Loan", onTodo4Tapped,
                                  isItemLocked: !isLoanAvailable),
                            ],
                          )
                        : Container(),
                    isPersonalLoanAvailed == true
                        ? DashBoardLoanTable(
                            relationMap: relationMap,
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          isPersonalLoanAvailed == false
              ? GestureDetector(
                  onTap: onTodo4Tapped,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        right: MediaQuery.of(context).size.width * .1667 / 2,
                        left: MediaQuery.of(context).size.width * .1667 / 2),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: DashboardCard(
                        isAtBottom: false,
                        heading: "Get your personal loan",
                        subheading:
                            "Apply now and get money \ninto your bank account",
                        isDark: true,
                        imageLocation: "assets/images/personal.png",
                        isLocked: !isLoanAvailable,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
