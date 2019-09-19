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
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text("Upgrade".toUpperCase(),
                    style: Theme.of(context).accentTextTheme.display4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
