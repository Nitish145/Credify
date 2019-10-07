import 'package:credify/Components/travel_card.dart';
import 'package:flutter/material.dart';

class TravelScreen extends StatefulWidget {
  @override
  _TravelScreenState createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  @override
  Widget build(BuildContext context) {
    Widget travelScreenAppbar() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(8)),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
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
                  padding: const EdgeInsets.fromLTRB(30, 4, 4, 4),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "You are eligible for travel loans",
                      style: Theme.of(context)
                          .primaryTextTheme
                          .display3
                          .copyWith(color: Colors.amberAccent, fontSize: 18),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 4, 4, 4),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Level : Silver",
                        style: Theme.of(context)
                            .primaryTextTheme
                            .display3
                            .copyWith(fontSize: 18)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 4, 4, 4),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Travel with us to unlock Gold Level",
                        style: Theme.of(context)
                            .primaryTextTheme
                            .display3
                            .copyWith(fontSize: 18)),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(child: SafeArea(child: travelScreenAppbar())),
              SizedBox(height: 20),
              TravelCard(
                imageLocation: "assets/images/kerela.png",
                place: "Kerela",
                daysNights: "3Days 4Nights",
                price: "9,900/-",
                timeSpan: "per month",
                isLocked: false,
              ),
              SizedBox(height: 20),
              TravelCard(
                imageLocation: "assets/images/goa.png",
                place: "Goa",
                daysNights: "3Days 4Nights",
                price: "8,900/-",
                timeSpan: "per month",
                isLocked: false,
              ),
              SizedBox(height: 20),
              TravelCard(
                imageLocation: "assets/images/singapore.png",
                place: "Singapore",
                daysNights: "3Days 4Nights",
                price: "12,900/-",
                timeSpan: "per month",
                isLocked: true,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
