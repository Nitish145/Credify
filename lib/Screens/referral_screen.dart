import 'package:credify/Models/refer_code_response.dart';
import 'package:credify/Models/total_referral_bonus_model.dart';
import 'package:credify/Services/get_refer_code.dart';
import 'package:credify/Services/total_referral_bonus.dart';
import 'package:credify/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReferralScreen extends StatefulWidget {
  @override
  _ReferralScreenState createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  String displayReferCode = "";
  int totalEarnedAmount;
  String referText;
  String playStoreLink = "";

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPrefs) {
      String currentUserId = sharedPrefs.getString("currentUserId");
      setReferCode(currentUserId);
      setTotalEarnedAmount(currentUserId);
    });
  }

  Future<void> setReferCode(String userId) async {
    ReferCode referCode = await getReferCode(userId).catchError((onError) {
      Fluttertoast.showToast(msg: "Cannot fetch Refer code for the user");
    });
    setState(() {
      displayReferCode = referCode.refCode;
      referText =
          "Register on CREDIFY with $displayReferCode and earn Rs.50 Download on $playStoreLink";
    });
  }

  Future<void> setTotalEarnedAmount(String userId) async {
    TotalReferralBonus totalReferralBonus =
        await getTotalReferral(userId).catchError((onError) {
      Fluttertoast.showToast(msg: "Cannot fetch Total amount earned");
    });
    setState(() {
      totalEarnedAmount = totalReferralBonus.referrBonus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.share,
          color: Colors.white,
        ),
        backgroundColor: credifyBlue,
        onPressed: () {
          if (displayReferCode == "") {
            Fluttertoast.showToast(msg: "Refer Code not fetched!!");
          } else {
            final RenderBox box = context.findRenderObject();
            Share.share(referText,
                subject: "Refer and Earn",
                sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
          }
        },
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Container(
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/svg/refer.svg",
                          semanticsLabel: "Refer Background",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 24, 0, 4),
                    child: Text(
                      "Here's your refer link",
                      style: Theme.of(context).accentTextTheme.display3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: Container(
                      color: Color.fromRGBO(232, 232, 232, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              displayReferCode,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).accentTextTheme.display4,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Clipboard.setData(
                                  new ClipboardData(text: displayReferCode));
                              Fluttertoast.showToast(
                                  msg: "Link copied to clipboard");
                            },
                            child: Container(
                              color: Colors.grey.withOpacity(0.5),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  "assets/images/clipboardIcon.png",
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
                    child: Text(
                      "Share the link with your friends",
                      style: Theme.of(context).accentTextTheme.display4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Total Earned amount: ",
                          style: Theme.of(context).accentTextTheme.display4,
                        ),
                        Text(
                          totalEarnedAmount == null
                              ? "-"
                              : totalEarnedAmount.toString(),
                          style: Theme.of(context)
                              .accentTextTheme
                              .display4
                              .copyWith(color: credifyDarkGreen),
                        )
                      ],
                    ),
                  )
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            "Refer",
                            style: Theme.of(context).primaryTextTheme.display2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
