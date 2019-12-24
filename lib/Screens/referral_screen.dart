import 'package:credify/colors.dart';
import 'package:credify/helper_methods/log_event.dart';
import 'package:credify/helper_methods/set_current_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ReferralScreen extends StatefulWidget {
  @override
  _ReferralScreenState createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> with RouteAware {
  String displayReferCode = "";
  int totalEarnedAmount;
  String referText;
  String playStoreLink = "";

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPrefs) {
      setState(() {
        displayReferCode = sharedPrefs.getString("referralCode");
        totalEarnedAmount = sharedPrefs.getInt("referrBonus");
        referText =
            "Register on CREDIFY with $displayReferCode and earn Rs.50 Download on $playStoreLink";
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyApp.observer.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    MyApp.observer.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    setCurrentScreen("referral");
  }

  @override
  void didPopNext() {
    setCurrentScreen("referral");
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
          logEvent("Share Tapped");
          final RenderBox box = context.findRenderObject();
          Share.share(referText,
              subject: "Refer and Earn",
              sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
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
