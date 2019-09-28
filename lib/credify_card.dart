import 'package:credify/complete_KYC_1_screen.dart';
import 'package:credify/complete_KYC_2_screen.dart';
import 'package:credify/complete_KYC_3_screen.dart';
import 'package:credify/globals.dart';
import 'package:flutter/material.dart';

class CredifyCard extends StatefulWidget {
  final String cardLevel;
  final String cardNumber;
  final String name;
  final int kycStage;

  const CredifyCard(
      {Key key, this.cardLevel, this.cardNumber, this.name, this.kycStage})
      : super(key: key);
  @override
  _CredifyCardState createState() => _CredifyCardState();
}

class _CredifyCardState extends State<CredifyCard> {
  BoxDecoration getBoxDecorationForCard() {
    switch (widget.kycStage) {
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
                  Color.fromRGBO(229, 93, 135, .33),
                  Color.fromRGBO(95, 195, 228, .33)
                ]));
        break;
      case 2:
        return BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(229, 93, 135, .66),
                  Color.fromRGBO(95, 195, 228, .66)
                ]));
        break;
      case 3:
        return BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(229, 93, 135, 1),
                  Color.fromRGBO(95, 195, 228, 1)
                ]));
        break;
      default:
        return BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color.fromRGBO(221, 221, 221, 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3.7,
            width: MediaQuery.of(context).size.width / 1.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3.7,
            width: MediaQuery.of(context).size.width / 1.2,
            decoration: getBoxDecorationForCard(),
            child: (widget.kycStage == 3)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text("Credify",
                                style:
                                    Theme.of(context).accentTextTheme.display3),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(widget.cardLevel,
                                style:
                                    Theme.of(context).accentTextTheme.display3),
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
                                style: Theme.of(context)
                                    .accentTextTheme
                                    .display4
                                    .copyWith(
                                      letterSpacing: 3,
                                    ),
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
                                style:
                                    Theme.of(context).accentTextTheme.display4),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text("Credify",
                                style:
                                    Theme.of(context).accentTextTheme.display3),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Complete KYC to Get your own Credify Card",
                                style:
                                    Theme.of(context).accentTextTheme.display3,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
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
                        },
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(Icons.arrow_forward),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 15, 15, 15),
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
          ),
        ],
      ),
    );
  }
}
