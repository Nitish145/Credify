import 'package:credify/Components/credify_card.dart';
import 'package:credify/Components/progress_bar.dart';
import 'package:credify/Models/user_data_model.dart';
import 'package:credify/Services/card_data.dart';
import 'package:credify/Services/user_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CredifyScreen extends StatefulWidget {
  @override
  _CredifyScreenState createState() => _CredifyScreenState();
}

class _CredifyScreenState extends State<CredifyScreen> {
  UserData currentUserData;
  String currentUserName = "";
  String currentUserCardNumber = "";

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPrefs) {
      getUserData(sharedPrefs.getString("currentUserId")).then((userData) {
        setState(() {
          print(userData.kycProgress);
          currentUserData = userData;
        });
        getCardData(sharedPrefs.getString("currentUserId")).then((cardData) {
          if (cardData != null) {
            sharedPrefs.setString("currentUserName", cardData.userName);
            sharedPrefs.setString("currentUserCardNumber", cardData.cardNumber);
            setState(() {
              currentUserCardNumber = cardData.cardNumber;
              currentUserName = cardData.userName;
            });
          }
        });
      }).catchError((e) {
        Fluttertoast.showToast(msg: "Something Wrong Occured!");
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
                Padding(
                  padding: const EdgeInsets.only(top: 70, bottom: 20),
                  child: CredifyCard(
                    cardLevel: "Silver",
                    cardNumber: currentUserCardNumber,
                    name: currentUserName,
                    kycStage: currentUserData == null
                        ? 0
                        : currentUserData.kycProgress,
                    isUserDataNull: (currentUserData == null) ? true : false,
                  ),
                ),
              ],
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("4,000/",
                                    style: Theme.of(context)
                                        .accentTextTheme
                                        .display2
                                        .copyWith(fontWeight: FontWeight.bold)),
                                Text("10,000/",
                                    style: Theme.of(context)
                                        .accentTextTheme
                                        .display2
                                        .copyWith(fontWeight: FontWeight.bold))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                    ),
        ],
      ),
    );
  }
}
