import 'dart:convert';

import 'package:credify/Components/progress_bar.dart';
import 'package:credify/Models/user_data_model.dart';
import 'package:credify/Screens/complete_KYC_1_screen.dart';
import 'package:credify/Screens/complete_KYC_2_screen.dart';
import 'package:credify/Screens/complete_KYC_3_screen.dart';
import 'package:credify/Services/card_data.dart';
import 'package:credify/Services/user_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CredifyCard extends StatefulWidget {
  @override
  _CredifyCardState createState() => _CredifyCardState();
}

class _CredifyCardState extends State<CredifyCard> {
  UserData currentUserData;
  String currentUserCardNumber = "";
  String currentUserName = "";
  bool isDataLoading = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      isDataLoading = true;
    });
    SharedPreferences.getInstance().then((sharedPrefs) {
      getUserData(sharedPrefs.getString("currentUserId")).then((userData) {
        getCardData(sharedPrefs.getString("currentUserId")).then((cardData) {
          sharedPrefs.setString("currentUserData", jsonEncode(currentUserData));
          setState(() {
            currentUserData = userData;
          });
          if (cardData != null) {
            sharedPrefs.setString("currentUserName", cardData.userName);
            sharedPrefs.setString("currentUserCardNumber", cardData.cardNumber);
            setState(() {
              currentUserCardNumber = cardData.cardNumber;
              currentUserName = cardData.userName;
            });
          }
          setState(() {
            isDataLoading = false;
          });
        }).catchError((e) {
          Fluttertoast.showToast(msg: "Something Wrong Occured!");
        });
      }).catchError((e) {
        Fluttertoast.showToast(msg: "Something Wrong Occured!");
      });
    }).catchError((e) {
      Fluttertoast.showToast(msg: "Something Wrong Occured!");
    });
  }

  BoxDecoration getBoxDecorationForCard() {
    if (currentUserData != null)
      switch (currentUserData.kycProgress) {
        case 0:
          return BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromRGBO(221, 221, 221, 1));
          break;
        case 1:
          return BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromRGBO(151, 150, 240, .33),
                    Color.fromRGBO(251, 199, 212, .33)
                  ]));
          break;
        case 2:
          return BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromRGBO(151, 150, 240, .66),
                    Color.fromRGBO(251, 199, 212, .66)
                  ]));
          break;
        case 3:
          return BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromRGBO(151, 150, 240, 1),
                    Color.fromRGBO(251, 199, 212, 1)
                  ]));
          break;
        default:
          return BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromRGBO(221, 221, 221, 1));
      }
    return BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color.fromRGBO(221, 221, 221, 1));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              currentUserData != null
                  ? Stack(
                      children: <Widget>[
                        Container(
                          height: 220,
                          width: MediaQuery.of(context).size.width / 1.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                        ),
                        Container(
                          height: 220,
                          width: MediaQuery.of(context).size.width / 1.2,
                          decoration: getBoxDecorationForCard(),
                          child: (currentUserData.kycProgress == 3)
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text("Credify",
                                              style: Theme.of(context)
                                                  .accentTextTheme
                                                  .display3),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text("Silver",
                                              style: Theme.of(context)
                                                  .accentTextTheme
                                                  .display3),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, bottom: 7),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              currentUserCardNumber == ""
                                                  ? ""
                                                  : currentUserCardNumber
                                                          .substring(0, 4) +
                                                      " " +
                                                      currentUserCardNumber
                                                          .substring(4, 8) +
                                                      " " +
                                                      currentUserCardNumber
                                                          .substring(8, 12) +
                                                      " " +
                                                      currentUserCardNumber
                                                          .substring(12, 16),
                                              style: Theme.of(context)
                                                  .accentTextTheme
                                                  .display3
                                                  .copyWith(
                                                      letterSpacing: 3,
                                                      fontWeight:
                                                          FontWeight.w300),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, top: 7),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              currentUserName,
                                              style: Theme.of(context)
                                                  .accentTextTheme
                                                  .display3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () async {},
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Text("Upgrade".toUpperCase(),
                                              style: Theme.of(context)
                                                  .accentTextTheme
                                                  .display4),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : (currentUserData == null)
                                  ? Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text("Loading..",
                                            style: Theme.of(context)
                                                .accentTextTheme
                                                .display2),
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Text("Credify",
                                                  style: Theme.of(context)
                                                      .accentTextTheme
                                                      .display3),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30, right: 30),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Complete KYC to Get your own Credify Card",
                                                  style: Theme.of(context)
                                                      .accentTextTheme
                                                      .display3,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (!currentUserData.kycStatus) {
                                              switch (
                                                  currentUserData.kycProgress) {
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
                                          },
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Icon(Icons.arrow_forward),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 15, 15, 15),
                                                  child: Text("Continue",
                                                      style: Theme.of(context)
                                                          .accentTextTheme
                                                          .display4),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                        )
                      ],
                    )
                  : Container(
                      height: 220,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: getBoxDecorationForCard(),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text("Loading..",
                              style:
                                  Theme.of(context).accentTextTheme.display2),
                        ),
                      ),
                    ),
              currentUserData == null
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(36, 8, 36, 8),
                      child: Container(
                        height: 90,
                      ),
                    )
                  : (currentUserData.kycProgress == 3)
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(36, 8, 36, 8),
                          child: Container(
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("Used",
                                        style: Theme.of(context)
                                            .accentTextTheme
                                            .display4),
                                    Text("Credify limit",
                                        style: Theme.of(context)
                                            .accentTextTheme
                                            .display4)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("4,000/",
                                        style: Theme.of(context)
                                            .accentTextTheme
                                            .display2
                                            .copyWith(
                                                fontWeight: FontWeight.bold)),
                                    Text("10,000/",
                                        style: Theme.of(context)
                                            .accentTextTheme
                                            .display2
                                            .copyWith(
                                                fontWeight: FontWeight.bold))
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 10.0,
                                    child: ProgressBar(
                                      linearGradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Color.fromRGBO(151, 150, 240, 1),
                                            Color.fromRGBO(251, 199, 212, 1)
                                          ]),
                                      progress: 40.0,
                                      borderRadius: BorderRadius.circular(10.0),
                                      height: 15.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(36, 8, 36, 8),
                          child: Container(
                            height: 90,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text("Credify limit",
                                        style: Theme.of(context)
                                            .accentTextTheme
                                            .display4)
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 10.0,
                                    child: ProgressBar(
                                      linearGradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Color.fromRGBO(221, 221, 221, 1),
                                            Color.fromRGBO(221, 221, 221, 1)
                                          ]),
                                      progress: 100.0,
                                      borderRadius: BorderRadius.circular(10.0),
                                      height: 15.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
            ],
          ),
        ],
      ),
    );
  }
}
