import 'package:credify/credify_card.dart';
import 'package:credify/dashboard_card.dart';
import 'package:credify/travel_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                      color: Colors.black,
                      child: SafeArea(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: Icon(Icons.people),
                                color: Colors.white,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100, bottom: 40),
                      child: CredifyCard(
                        cardLevel: "Silver",
                        cardNumber: "1234 5678 9123 4567",
                        name: "Tanmay Joshi",
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(36, 8, 36, 8),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Used",
                              style:
                                  Theme.of(context).accentTextTheme.display4),
                          Text("Credify limit",
                              style: Theme.of(context).accentTextTheme.display4)
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
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(36, 8, 36, 16),
                child: Container(
                  height: 130,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromRGBO(47, 128, 237, .8)),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                          child: Text(
                              "Add friends and increase your score"
                                  .toUpperCase(),
                              softWrap: true,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .display3
                                  .copyWith(fontSize: 19, letterSpacing: 3)),
                        ),
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30,
                                child: Image.asset(
                                  "assets/images/addFriend.png",
                                  height: 40,
                                  width: 40,
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TravelScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: DashboardCard(
                    isAtBottom: false,
                    heading: "Travel with us",
                    subheading:
                        "Check amazing packages customised for you. Travel now. Pay later",
                    isDark: true,
                    imageLocation: "assets/images/travel.png",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: DashboardCard(
                  isAtBottom: true,
                  heading: "Your Ride. Your Bike",
                  subheading:
                      "Get your bike of dreams. Easy installments. Ride away.",
                  isDark: false,
                  imageLocation: "assets/images/bikeRide.png",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
