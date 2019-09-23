import 'package:credify/Models/is_new_user_model.dart';
import 'package:credify/Models/user_data_model.dart';
import 'package:credify/complete_KYC_1_screen.dart';
import 'package:credify/complete_KYC_2_screen.dart';
import 'package:credify/complete_KYC_3_screen.dart';
import 'package:credify/globals.dart';
import 'package:credify/services/is_new_user.dart' as prefix0;
import 'package:credify/services/user_data.dart';
import 'package:flutter/material.dart';

class CredifyCard extends StatefulWidget {
  final String cardLevel;
  final String cardNumber;
  final String name;

  const CredifyCard({Key key, this.cardLevel, this.cardNumber, this.name})
      : super(key: key);
  @override
  _CredifyCardState createState() => _CredifyCardState();
}

class _CredifyCardState extends State<CredifyCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height / 3.7,
        width: MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(229, 93, 135, 1),
                  Color.fromRGBO(95, 195, 228, 1)
                ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Credify",
                      style: Theme.of(context).accentTextTheme.display3),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(widget.cardLevel,
                      style: Theme.of(context).accentTextTheme.display3),
                )
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 7),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.cardNumber,
                      style: Theme.of(context)
                          .accentTextTheme
                          .display4
                          .copyWith(letterSpacing: 3),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 7),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.name.toUpperCase(),
                      style:
                          Theme.of(context).accentTextTheme.display4.copyWith(
                                letterSpacing: 3,
                              ),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                IsNewUser isNewUser =
                    await prefix0.isNewUser(currentUserMobileNumber);
                print(isNewUser.id);
                currentUserId = isNewUser.id;
                UserData currentUserData = await getUserData(currentUserId);
                if (!currentUserData.kycStatus) {
                  switch (currentUserData.kycProgress) {
                    case 0:
                      {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CompleteKYC1()));
                      }
                      break;
                    case 1:
                      {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CompleteKYC2()));
                      }
                      break;
                    case 2:
                      {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CompleteKYC3()));
                      }
                  }
                }
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text("Upgrade".toUpperCase(),
                      style: Theme.of(context).accentTextTheme.display4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
