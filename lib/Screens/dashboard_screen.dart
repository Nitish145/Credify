import 'dart:convert';

import 'package:credify/Components/credify_card.dart';
import 'package:credify/Components/dashboard_card.dart';
import 'package:credify/Models/user_data_model.dart';
import 'package:credify/Screens/bank_detail_1_screen.dart';
import 'package:credify/Screens/complete_KYC_1_screen.dart';
import 'package:credify/Screens/complete_KYC_2_screen.dart';
import 'package:credify/Screens/complete_KYC_3_screen.dart';
import 'package:credify/Screens/personal_loan_screen.dart';
import 'package:credify/Services/user_data.dart';
import 'package:credify/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  UserData currentUserData;
  bool isKycDone = false;
  bool isBankAccountAdded = false;
  bool isPersonalLoanAvailed = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPrefs) {
      getUserData(sharedPrefs.getString("currentUserId")).then((userData) {
        sharedPrefs.setString("currentUserData", jsonEncode(currentUserData));
        sharedPrefs.setString("referralCode", userData.referralCode);
        sharedPrefs.setString("referredBy", userData.referredBy);
        sharedPrefs.setInt("referrBonus", userData.referrBonus);
        setState(() {
          currentUserData = userData;
          isKycDone = userData.kycProgress == 3;
          isBankAccountAdded = userData.bankDetailsProvided != null
              ? userData.bankDetailsProvided
              : false;
        });
      });
    });
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
                Container(
                  child: SafeArea(
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
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 70, bottom: 20),
                      child: CredifyCard(),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          "To-do",
                          style: Theme.of(context).accentTextTheme.display3,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (currentUserData != null) {
                          if (!currentUserData.kycStatus) {
                            switch (currentUserData.kycProgress) {
                              case 0:
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CompleteKYC1()));
                                }
                                break;
                              case 1:
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CompleteKYC2()));
                                }
                                break;
                              case 2:
                                {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CompleteKYC3()));
                                }
                            }
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: isKycDone
                                  ? credifyLightGreen
                                  : credifyLightGrey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: isKycDone
                                          ? credifyDarkGreen
                                          : credifyDarkGrey,
                                      radius: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Know your Customer",
                                      style: isKycDone
                                          ? Theme.of(context)
                                              .primaryTextTheme
                                              .display4
                                              .copyWith(
                                                  decoration: TextDecoration
                                                      .lineThrough)
                                          : Theme.of(context)
                                              .accentTextTheme
                                              .display4,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color:
                                      isKycDone ? credifyWhite : credifyBlack,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!isBankAccountAdded) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BankDetailScreen1()));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: isBankAccountAdded
                                  ? credifyLightGreen
                                  : credifyLightGrey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: isBankAccountAdded
                                          ? credifyDarkGreen
                                          : credifyDarkGrey,
                                      radius: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Add Bank Account",
                                      style: isBankAccountAdded
                                          ? Theme.of(context)
                                              .primaryTextTheme
                                              .display4
                                              .copyWith(
                                                  decoration: TextDecoration
                                                      .lineThrough)
                                          : Theme.of(context)
                                              .accentTextTheme
                                              .display4,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: isBankAccountAdded
                                      ? credifyWhite
                                      : credifyBlack,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PersonalLoanScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: isPersonalLoanAvailed
                                  ? credifyLightGreen
                                  : credifyLightGrey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: isPersonalLoanAvailed
                                          ? credifyDarkGreen
                                          : credifyDarkGrey,
                                      radius: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Apply for Personal Loan",
                                      style: isPersonalLoanAvailed
                                          ? Theme.of(context)
                                              .primaryTextTheme
                                              .display4
                                              .copyWith(
                                                  decoration: TextDecoration
                                                      .lineThrough)
                                          : Theme.of(context)
                                              .accentTextTheme
                                              .display4,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: isPersonalLoanAvailed
                                      ? credifyWhite
                                      : credifyBlack,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PersonalLoanScreen()));
            },
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
