import 'package:credify/travel_card.dart';
import 'package:flutter/material.dart';

class TravelScreen extends StatefulWidget {
  @override
  _TravelScreenState createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  @override
  Widget build(BuildContext context) {
    Widget travelScreenAppbar() {
      return Container(
        height: MediaQuery.of(context).size.height / 4.5,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
                  child: Text(
                    "Travel",
                    style: Theme.of(context)
                        .primaryTextTheme
                        .display2
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(36, 4, 8, 4),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "You are eligible for travel loans",
                  style: Theme.of(context)
                      .primaryTextTheme
                      .display3
                      .copyWith(color: Colors.amberAccent),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(36, 4, 8, 4),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Level : Silver",
                    style: Theme.of(context).primaryTextTheme.display3),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(36, 4, 8, 4),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Travel with us to unlock Gold Level",
                    style: Theme.of(context).primaryTextTheme.display3),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  color: Colors.black,
                  child: SafeArea(child: travelScreenAppbar())),
              SizedBox(height: 20),
              TravelCard(
                imageLocation: "assets/images/kerela.png",
                place: "Kerela",
                daysNights: "3Days 4Nights",
                price: "9,900/-",
                timeSpan: "per month",
              ),
              SizedBox(height: 20),
              TravelCard(
                imageLocation: "assets/images/goa.png",
                place: "Goa",
                daysNights: "3Days 4Nights",
                price: "8,900/-",
                timeSpan: "per month",
              ),
              SizedBox(height: 20),
              TravelCard(
                imageLocation: "assets/images/singapore.png",
                place: "Singapore",
                daysNights: "3Days 4Nights",
                price: "12,900/-",
                timeSpan: "per month",
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
